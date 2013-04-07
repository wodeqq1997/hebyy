package com.systop.scos.communicate.mail.model;

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

import org.hibernate.annotations.Type;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

@SuppressWarnings("serial")
@Entity
@Table(name = "mail")
public class Mail extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 发送人名称 */
	private String senderName;

	/** 1=一般; 2=重要; 3=非常重要 */
	private Short importantFlag;

	/** 发送时间 */
	private Date sendTime;

	/** 内容 */
	private String content;

	/** 主题 */
	private String subject;

	/** 抄送人列表 */
	private String copyToNames;

	/** 抄送人ID列表 */
	private String copyToIDs;

	/** 收件人列表 */
	private String recipientNames;

	/** 收件人ID列表 */
	private String recipientIDs;

	/** 邮件状态 1=正式邮件 0=草稿邮件 */
	private Short mailStatus;

	/** 发送人 */
	private User sender;

	/** 附件列表 */
	private String fileIds;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "sender_name")
	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	@Column(name = "important_flag")
	public Short getImportantFlag() {
		return importantFlag;
	}

	public void setImportantFlag(Short importantFlag) {
		this.importantFlag = importantFlag;
	}

	@Column(name = "send_time")
	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	@Type(type = "text")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	@Column(name = "copy_to_names")
	public String getCopyToNames() {
		return copyToNames;
	}

	public void setCopyToNames(String copyToNames) {
		this.copyToNames = copyToNames;
	}

	@Column(name = "copy_to_ids")
	public String getCopyToIDs() {
		return copyToIDs;
	}

	public void setCopyToIDs(String copyToIDs) {
		this.copyToIDs = copyToIDs;
	}

	@Column(name = "recipient_names")
	public String getRecipientNames() {
		return recipientNames;
	}

	public void setRecipientNames(String recipientNames) {
		this.recipientNames = recipientNames;
	}

	@Column(name = "recipient_ids")
	public String getRecipientIDs() {
		return recipientIDs;
	}

	public void setRecipientIDs(String recipientIDs) {
		this.recipientIDs = recipientIDs;
	}

	@Column(name = "mail_status")
	public Short getMailStatus() {
		return mailStatus;
	}

	public void setMailStatus(Short mailStatus) {
		this.mailStatus = mailStatus;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "sender_id")
	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	@Column(name = "file_ids")
	public String getFileIds() {
		return fileIds;
	}

	public void setFileIds(String fileIds) {
		this.fileIds = fileIds;
	}

}
