package com.systop.scos.communicate.smsg.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;
import com.systop.scos.communicate.smsg.MsgConstants;

@Entity
@Table(name = "messages")
@SuppressWarnings("serial")
public class Message extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 发送者 */
	private User sender;
	
	//标题
	private String title;

	/** 内容 */
	private String content;

	/** 信息类型 */
	private String msgType;

	/** 创建时间 */
	private Date createTime;

	/** 接收者 */
	private User receiver;

	/** 是否已读 */
	private String isRead = MsgConstants.NOMAL;

	/** 发送者删除状态 */
	private String senderDel = MsgConstants.NOMAL;

	/** 接收者删除状态 */
	private String receiverDel = MsgConstants.NOMAL;

    /**
     * 是否短信通知,默认是不需要
     */
    private String notified = "0";

    /**
     * 附件
     */
    private String fileAttchIds;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "sender_id")
	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}
	
	@Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "content", length = 2000)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "receiver_id")
	public User getReceiver() {
		return receiver;
	}

	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}

	public String getIsRead() {
		return isRead;
	}

	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}

	public String getSenderDel() {
		return senderDel;
	}

	public void setSenderDel(String senderDel) {
		this.senderDel = senderDel;
	}

	public String getReceiverDel() {
		return receiverDel;
	}

	public void setReceiverDel(String receiverDel) {
		this.receiverDel = receiverDel;
	}

    public String getNotified() {
        return notified;
    }

    public void setNotified(String notified) {
        this.notified = notified;
    }

    @Column(name = "fileAttchIds")
	public String getFileAttchIds() {
		return fileAttchIds;
	}

	public void setFileAttchIds(String fileAttchIds) {
		this.fileAttchIds = fileAttchIds;
	}
    
}
