package com.systop.scos.games.model;

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
@SuppressWarnings("serial")
@Entity
@Table(name = "doc_types")
public class Games extends BaseModel{

	private Integer id;
	
	//游戏名称
	private String name;
	
	//上传者
	private User user;
	
	//上传日期
	private Date date;
	
	//附件列表
	private String fileattchIds;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getFileattchIds() {
		return fileattchIds;
	}

	public void setFileattchIds(String fileattchIds) {
		this.fileattchIds = fileattchIds;
	}
	
}
