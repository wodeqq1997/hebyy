package com.systop.scos.communicate.smsg.webapp;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import junit.framework.Assert;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.security.user.model.User;
//import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.Constants;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.JsonCrudAction;
import com.systop.scos.communicate.smsg.MsgConstants;
import com.systop.scos.communicate.smsg.model.Message;
import com.systop.scos.communicate.smsg.service.MessageManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class MessageAction extends JsonCrudAction<Message, MessageManager> {

	/** 接收人 序列 */
	private String receiverIds;
	
	/** 接受人 名 */
	private String receiverNames;
	
	private Date startDate;

	private Date endDate;

	// 发件箱标识
	private final String sendType = "s";

	// 收件箱标识
	private final String receiveType = "r";

	// 最新短信异步检查调用
	private List<Message> newMsgs;
	
	//异步请求返回值
	private Map<String, Object> result;

	// 用户管理类
	//@Autowired
	//private UserManager userManager;

	/**
	 * 新建站内短信
	 * 
	 * @return
	 */
	public String newMsg() {
		getModel().setSender(getLoginUser());
		//getModel().setReceiver(userManager.getUser(receiverIds));// 回复信息时得到收信人
		
		return INPUT;
	}

	/**
	 * 发送信息
	 * 
	 * @return
	 */
	public String sendMsg() {
		List<User> receivers = getReceivers();
		if (receivers != null) {
			for (User receiver : receivers) {
				Message msg = new Message();
				msg.setSender(getLoginUser());
				msg.setReceiver(receiver);
				msg.setCreateTime(new Date());
				msg.setContent(getModel().getContent());
				//本来就是一步多余的操作，但为为了系统消息提示增加的一个字段，我也郁闷
				msg.setTitle(getModel().getContent());
				msg.setIsRead(Constants.NO);
				msg.setMsgType(MsgConstants.IS_PERSONAL);// 个人消息
				msg.setReceiverDel(MsgConstants.NOMAL);// 未移除
				msg.setSenderDel(MsgConstants.NOMAL);
				getManager().save(msg);
			}
		}
		return SUCCESS;
	}

	/**
	 * 已发信息列表
	 * 
	 * @return
	 */
	public String sendIndex() {
		Map<String, Object> query = getQueryAndPam(sendType);
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, (String) query.get("hql"),
				(Object[]) query.get("args"));
		restorePageData(page);
		return "sendIndex";
	}

	/**
	 * 接收信息列表
	 * 
	 * @return
	 */
	public String receiveIndex() {
		Map<String, Object> query = getQueryAndPam(receiveType);
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, (String) query.get("hql"),
				(Object[]) query.get("args"));
		restorePageData(page);
		return "receiveIndex";
	}

	/**
	 * 获得查询条件和参数
	 * 
	 * @return
	 */
	private Map<String, Object> getQueryAndPam(String type) {
		Assert.assertNotNull("type 不能为空!", type);
		Map<String, Object> query = new HashMap<String, Object>();

		StringBuffer hql = new StringBuffer("from Message m");
		List<Object> args = new ArrayList<Object>();

		if (sendType.equals(type)) {
			hql.append(" where m.sender.id = ? and m.senderDel = 0");// 未移除的
		} else if (receiveType.equals(type)) {
			hql.append(" where m.receiver.id = ? and m.receiverDel = 0");// 未移除的
		}

		args.add(getLoginUser().getId());
		// // 根据标题查询
		// if (getModel().getTitle() != null) {
		// hql.append(" and m.title like ?");
		// args.add("%" + getModel().getTitle() + "%");
		// }
		
		// 判断消息类型（个人，系统）
		if(StringUtils.isNotBlank(getModel().getMsgType())){
			hql.append(" and m.msgType = ?");
			args.add(getModel().getMsgType());
		}
		
		// 根据接收人查询
		if (getModel().getReceiver() != null
				&& getModel().getReceiver().getName() != null) {
			hql.append(" and m.receiver.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getReceiver().getName()));
		}
		// 根据发送人查询
		if (getModel().getSender() != null
				&& StringUtils.isNotBlank(getModel().getSender().getName())) {
			hql.append(" and m.sender.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getSender().getName()));
		}
		if (startDate != null ) {
			hql.append(" and m.createTime > ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if( endDate != null) {
			hql.append(" and m.createTime < ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}
		hql.append(" order by m.createTime desc");
		query.put("hql", hql.toString());
		query.put("args", args.toArray());
		return query;
	}

	public String view() {
		if (getModel() != null && getModel().getId() != null) {
			String updateState = getRequest().getParameter("updateState");
			if ("Y".equals(updateState)) {
				getModel().setIsRead(Constants.YES);
				getManager().save(getModel());
			}
		}
		return VIEW;
	}

	/**
	 * 收件箱移除
	 */
	public String receiveDel() {
		setModel(getManager().get(getModel().getId()));
		getModel().setReceiverDel(MsgConstants.DELETE);// 移除
		getManager().update(getModel());
		return "receives";
	}

	/**
	 * 发件箱移除
	 */
	public String sendDel() {
		setModel(getManager().get(getModel().getId()));
		getModel().setSenderDel(MsgConstants.DELETE);// 移除
		getManager().update(getModel());
		return SUCCESS;
	}

	/**
	 * 收件箱批量移除
	 */
	public String receiveRemove() {
		if (selectedItems != null) {
			Message message = null;
			for (Serializable id : selectedItems) {
				message = getManager().get(convertId(id));
				message.setReceiverDel(MsgConstants.DELETE);// 设置receiverDel的值
				getManager().save(message);
			}
		}
		return "receives";
	}

	/**
	 * 发件箱批量移除
	 */
	public String sendRemove() {
		if (selectedItems != null) {
			Message message = null;
			for (Serializable id : selectedItems) {
				message = getManager().get(convertId(id));
				message.setSenderDel(MsgConstants.DELETE);// 设置senderDel的值
				getManager().save(message);
			}
		}
		return SUCCESS;
	}

	/**
	 * 获取接收用户序列
	 * 
	 * @return
	 */
	private List<User> getReceivers() {
		List<User> receivers = null;
		if (StringUtils.isNotBlank(receiverIds)) {
			receivers = new ArrayList<User>();
			String[] uIds = receiverIds.split(",");
			for (String id : uIds) {
				if (StringUtils.isNumeric(id)) {
					User u = getManager().getDao().get(User.class,
							Integer.valueOf(id));
					if (u != null) {
						receivers.add(u);
					}
				}
			}
		}
		return receivers;
	}

	/**
	 * 全部标记为已读
	 */
	public String readAllMsgs(){
		getManager().readAllMsgs(getLoginUser(),getModel().getMsgType());
		return this.receiveIndex();
	}
	
	/**
	 * 异步设置已读 
	 */
	public String ajaxReadAllMsgs(){
		result = new HashMap<String, Object>();
		try {
			getManager().readAllMsgs(getLoginUser(), null);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return "ajaxReadAllMsgs";
	}
	
	/**
	 * 异步查询未读信息
	 * 
	 * @return
	 */
	public String checkNewMsgs() {
		String hql = "select m.id as id, m.title as title from Message m where m.receiver.id = ? and m.isRead = ? and m.receiverDel = ? order by m.createTime desc";
		newMsgs = getManager().query(
				hql,
				new Object[] { getLoginUser().getId(), Constants.NO,
						MsgConstants.NOMAL });
		return "newmsg";
	}

	public String getReceiverIds() {
		return receiverIds;
	}

	public void setReceiverIds(String receiverIds) {
		this.receiverIds = receiverIds;
	}

	public String getReceiverNames() {
		return receiverNames;
	}

	public void setReceiverNames(String receiverNames) {
		this.receiverNames = receiverNames;
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

	public List<Message> getNewMsgs() {
		return newMsgs;
	}
	
	public Map<String, Object> getResult() {
		return result;
	}

}
