package com.systop.scos.communicate.mail.service;

import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.communicate.mail.MailConstants;
import com.systop.scos.communicate.mail.model.Mail;
import com.systop.scos.communicate.mail.model.MailBox;

/**
 * EMail管理
 * 
 * @author Nice
 * 
 */
@Service
public class MailBoxManager extends BaseGenericsManager<MailBox> {

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
	public void sendToUsers(Mail mail, String[] ids, String type) {
		// 发送邮件
		for (String id : ids) {
			if (StringUtils.isNotBlank(id) && StringUtils.isNumeric(id)) {
				User user = getDao().get(User.class, Integer.valueOf(id));
				MailBox mailBoxSend = mail2Box(mail, user,
						MailConstants.TYPE_RECEVICE);
				if (MailConstants.SEND_NORMAL.equals(type)) {// 正常发送的邮件
					mailBoxSend.setNote("正常发送邮件");
				} else {// 抄送的邮件
					mailBoxSend.setNote("抄送邮件");
				}
				save(mailBoxSend);
			}
		}
	}

	// 根据邮件类型将Mail转换成MailBox
	private MailBox mail2Box(Mail mail, User user, String sendType) {
		MailBox mailBox = null;
		if (mail != null) {
			mailBox = new MailBox();
			mailBox.setUser(user);
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
	 * 将所有未读邮件设置为已读（根据当前登陆用户）
	 */
	@Transactional
	public void readAllMailBoxs(User user) {
		List<MailBox> list = query(
				"from MailBox m where m.isRead = ? and m.type = ? and m.user.id = ?",
				MailConstants.N, MailConstants.TYPE_RECEVICE, user.getId());
		for (MailBox mailBox : list) {
			mailBox.setIsRead(MailConstants.Y);
			update(mailBox);
		}
	}
}
