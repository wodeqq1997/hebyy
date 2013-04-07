package com.systop.scos.communicate.mail.model;

import java.util.Date;

import javax.persistence.*;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;
import com.systop.scos.communicate.smsg.model.Message;

@SuppressWarnings("serial")
@Entity
@Table(name = "mail_box")
public class MailBox extends BaseModel {

	private Integer id;
	private Date sendTime;
	private Short isDel;
	private Short isRead;
	private String note;
	private Mail mail;
	private User user;
	private Short isReply;
	private String type;
    private Message msg;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "send_time")
	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "mail_id")
	public Mail getMail() {
		return mail;
	}

	public void setMail(Mail mail) {
		this.mail = mail;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Short getIsDel() {
		return isDel;
	}

	public void setIsDel(Short isDel) {
		this.isDel = isDel;
	}

	public Short getIsRead() {
		return isRead;
	}

	public void setIsRead(Short isRead) {
		this.isRead = isRead;
	}

	public Short getIsReply() {
		return isReply;
	}

	public void setIsReply(Short isReply) {
		this.isReply = isReply;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

    @OneToOne
    public Message getMsg() {
        return msg;
    }

    public void setMsg(Message msg) {
        this.msg = msg;
    }
}
