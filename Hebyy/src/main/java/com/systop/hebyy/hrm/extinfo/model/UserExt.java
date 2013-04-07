package com.systop.hebyy.hrm.extinfo.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;

/**
 * 人事档案
 * 
 * @author GaoRuoFan
 */
@Entity
@Table(name = "user_ext")
public class UserExt {
	/**
	 * 主键
	 */
	private Integer id;
	
	/**
	 * 员工
	 * */
	private User user;
	
	/** 
	 *档案存放地
	 * */
	private String  archivesAddress;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getArchivesAddress() {
		return archivesAddress;
	}

	public void setArchivesAddress(String archivesAddress) {
		this.archivesAddress = archivesAddress;
	}
}
