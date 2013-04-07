package com.systop.scos.communicate.mail.webapp;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.dao.support.Page;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.communicate.mail.MailConstants;
import com.systop.scos.communicate.mail.model.Mail;
import com.systop.scos.communicate.mail.model.MailBox;
import com.systop.scos.communicate.mail.service.MailBoxManager;
import com.systop.scos.communicate.mail.service.MailManager;
import com.systop.scos.communicate.smsg.service.MessageManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class MailAction extends DefaultCrudAction<Mail, MailManager> {

	// 其实是MailBox's id.
	private Integer mailId;

	// 区别显示收件箱还是发件箱, 默认为收件箱
	private String mailIndexType = MailConstants.TYPE_SEND;

	// 邮件状态（正式邮件、草稿），默认为草稿邮件
	private short mailStatus = MailConstants.N;

	// 收件人Id
	private String receiverIds;

	/** 附件序列,ID以","分割 */
	private String fileattchids;

	// 查询开始日期
	private Date startDate;

	// 查询结束日期
	private Date endDate;

	// 首页显示最新邮件
	private List<Map<String, Object>> indexMails;

	// 首页显示条数
	private Integer viewCount;

	@Autowired
	private MailBoxManager mailBoxManager;

	@Autowired
	private MessageManager messageManager;

	/**
	 * 新建邮件
	 * 
	 * @return
	 */
	public String newMail() {
		getModel().setSender(getLoginUser());
		return INPUT;
	}

	/**
	 * 发送邮件
	 * 
	 * @return
	 */
	public String sendMail() {
		if (StringUtils.isNotBlank(getModel().getRecipientIDs())) {
			Mail mail = getModel();
			mail.setSender(getLoginUser());// 发件人
			if (StringUtils.isNotBlank(fileattchids)) {// 存附件
				mail.setFileIds(fileattchids);
			}
			mail.setMailStatus(MailConstants.Y);// 设置邮件状态（正式邮件）
			// 保存邮件Mail
			getManager().save(mail);
			// 在发件箱中保持Mail的引用
			MailBox mailBox = mail2Box(mail, getLoginUser(),
					MailConstants.TYPE_SEND);
			mailBoxManager.save(mailBox);
			if (mail.getRecipientIDs() != null) {
				String[] recipientIDs = mail.getRecipientIDs().split(",");// 收件人IDs
				sendToUsers(mail, recipientIDs, MailConstants.SEND_NORMAL);// 发送
			}
			if (mail.getCopyToIDs() != null) {
				String[] copyToIDs = mail.getCopyToIDs().split(",");// 抄送人IDs
				sendToUsers(mail, copyToIDs, MailConstants.SEND_COPY);// 抄送
			}
		}
		return SUCCESS;
	}

	/**
	 * 存草稿
	 */
	public String saveDraft() {
		getModel().setSender(getLoginUser());// 发件人
		if (StringUtils.isNotBlank(fileattchids)) {// 存附件
			getModel().setFileIds(fileattchids);
		}
		getModel().setMailStatus(MailConstants.N);// 设置邮件状态（草稿）
		getManager().save(getModel());// 保存邮件Mail

		return "draftSuccess";
	}

	/**
	 * 将邮件发送给用户
	 * 
	 * @param mail
	 *            邮件
	 * @param ids
	 *            用户id列表
	 * @param type
	 *            类别[发送/抄送]
	 */
	private void sendToUsers(Mail mail, String[] ids, String type) {
		// 发送邮件
		for (String id : ids) {
			if (StringUtils.isNotBlank(id) && StringUtils.isNumeric(id)) {
				User user = getManager().getDao().get(User.class,
						Integer.valueOf(id));
				MailBox mailBoxSend = mail2Box(mail, user,
						MailConstants.TYPE_RECEVICE);
				if (MailConstants.SEND_NORMAL.equals(type)) {// 正常发送的邮件
					mailBoxSend.setNote("正常发送邮件");
				} else {// 抄送的邮件
					mailBoxSend.setNote("抄送邮件");
				}
				mailBoxManager.save(mailBoxSend);
				messageManager.saveMailMsg(
						new Object[] { getServletContext().getContextPath(),
								mailBoxSend.getId() ,mailBoxSend}, user);
			}
		}
	}

	// 根据邮件类型将Mail转换成MailBox
	private MailBox mail2Box(Mail mail, User u, String sendType) {
		MailBox mailBox = null;
		if (mail != null) {
			mailBox = new MailBox();
			mailBox.setUser(u);
			mailBox.setMail(mail);
			mailBox.setSendTime(mail.getSendTime());
			mailBox.setType(sendType);
			mailBox.setIsDel(MailConstants.N);
			if (MailConstants.TYPE_RECEVICE.equals(sendType)) {// 如果是收件箱则设置下列属性
				mailBox.setIsRead(MailConstants.N);
				mailBox.setIsReply(MailConstants.N);
			}
		}
		return mailBox;
	}

	/**
	 * 邮件列表
	 */
	public String index() {
		Assert.notNull(getLoginUser());
		StringBuffer hql = new StringBuffer("from MailBox m where 1 = 1");
		List<Object> args = new ArrayList<Object>();
		hql.append(" and m.user.id = ? and m.type = ? and m.isDel = ?");
		args.add(getLoginUser().getId());
		args.add(this.mailIndexType);
		args.add(MailConstants.N);// 未被移除的
		if (getModel().getSubject() != null) {// 根据标题查询
			hql.append(" and m.mail.subject like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getSubject()));
		}
		if (startDate != null && endDate != null) {// 根据时间查询
			hql.append(" and (m.sendTime between ? and ?)");
			args.add(startDate);
			args.add(endDate);
		}
		hql.append("order by m.sendTime desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = mailBoxManager.pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);

		return INDEX;
	}

	/**
	 * 首页AJAX调用查看最新邮件
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String indexMails() {
		String hql = "from MailBox m where m.user.id = ? and m.type = ? and m.isDel = ? order by m.sendTime desc";
		List<Object> args = new ArrayList<Object>();
		args.add(getLoginUser().getId());
		// 查询收件箱的邮件
		args.add(MailConstants.TYPE_RECEVICE);
		args.add(MailConstants.N);// 未被移除的
		page = PageUtil.getPage(1, viewCount);
		page = mailBoxManager.pageQuery(page, hql, args.toArray());
		indexMails = toMapList(page.getData());
		return "indexMails";
	}

	private List<Map<String, Object>> toMapList(List<MailBox> items) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (MailBox m : items) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", m.getId());
			map.put("subject", m.getMail().getSubject());
			map.put("sendTime",
					DateUtil.getDateToString(m.getSendTime(), "MM.dd HH:mm"));
			map.put("sender", m.getMail().getSender().getName());
			map.put("isRead", m.getIsRead());
			list.add(map);
		}
		return list;
	}

	/**
	 * 草稿箱
	 */
	public String indexDraft() {
		Assert.notNull(getLoginUser());
		String hql = "from Mail m where m.sender.id = ? and m.mailStatus = ? order by m.sendTime desc";
		Page page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql,
				new Object[] { getLoginUser().getId(), this.mailStatus });
		restorePageData(page);
		return "indexDraft";
	}

	/**
	 * 查看邮件[发件箱查看/收件箱查看]
	 */
	public String view() {
		Assert.notNull(getLoginUser());
		MailBox mailbox = mailBoxManager.get(mailId);
		Assert.notNull(mailbox);
		if (getLoginUser().equals(mailbox.getUser())
				&& mailbox.getType().equals(MailConstants.TYPE_RECEVICE) && mailbox.getIsRead().equals(MailConstants.N)) {
			mailbox.setIsRead(MailConstants.Y);
            mailbox.getMsg().setIsRead("1");
		}
		mailBoxManager.save(mailbox);
		getRequest().setAttribute("mailbox", mailbox);
		return VIEW;
	}

	/**
	 * 正式邮件删除.修改isDel值
	 */
	public String removeMailBox() {
		if (selectedItems != null) {
			MailBox mailBox = null;
			for (Serializable id : selectedItems) {
				mailBox = mailBoxManager.get(convertId(id));
				mailBox.setIsDel(MailConstants.Y);// 设置isDel的值
				mailBoxManager.save(mailBox);
			}
		}
		//return SUCCESS;
		return "delSuccess";
	}

	/**
	 * 将所有未读邮件设置为已读 
	 */
	public String readAllMailBoxs(){
		mailBoxManager.readAllMailBoxs(getLoginUser());
		return this.index();
	}
	
	/**
	 * 草稿删除
	 * 
	 * @return
	 */
	public String remove() {
		getManager().remove(getModel());
		return "draftSuccess";
	}

	public String getMailIndexType() {
		return mailIndexType;
	}

	public void setMailIndexType(String mailIndexType) {
		this.mailIndexType = mailIndexType;
	}

	public void setMailId(Integer mailId) {
		this.mailId = mailId;
	}

	public String getFileattchids() {
		return fileattchids;
	}

	public void setFileattchids(String fileattchids) {
		this.fileattchids = fileattchids;
	}

	public String getReceiverIds() {
		return receiverIds;
	}

	public void setReceiverIds(String receiverIds) {
		this.receiverIds = receiverIds;
	}

	public short getMailStatus() {
		return mailStatus;
	}

	public void setMailStatus(short mailStatus) {
		this.mailStatus = mailStatus;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public List<Map<String, Object>> getIndexMails() {
		return indexMails;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}
}
