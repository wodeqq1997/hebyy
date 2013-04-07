package com.systop.scos.attendance.model;

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
/**
 * 个人考勤实体类
 *@author LinJie
 *@version 1.0
 */
@Entity
@Table(name = "persion_att")
@SuppressWarnings("serial")
public class PeopleAtt extends BaseModel{
	
	private Integer id;
	
	/**
	 * 员工
	 */
	private User persion;
	
	/**
	 * 打卡时间
	 */
	private Date punchTime;
	
	/**
	 * 状态
	 */
	private String status;

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
	@JoinColumn(name = "user_id")
	public User getPersion() {
		return persion;
	}

	public void setPersion(User persion) {
		this.persion = persion;
	}

	@Column(name = "punch_time")
	public Date getPunchTime() {
		return punchTime;
	}

	public void setPunchTime(Date punchTime) {
		this.punchTime = punchTime;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
