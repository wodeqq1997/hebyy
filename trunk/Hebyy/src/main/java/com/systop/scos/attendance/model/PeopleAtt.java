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
	 * 上午上班
	 */
	private Date morWorkPunch;
	
	//上午下班
	private Date morOverPunch;
	
	//下午上班
	private Date aftWorkPunch;
	
	//下午下班
	private Date aftOverPunch;
	
	/**
	 * 日期
	 */
	private Date date;
	/**
	 * 上午上班状态
	 */
	private String morWorkStatus;
	
	private String morOverStatus;
	
	private String aftWorkStatus;
	
	private String aftOverStatus;
	
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

	@Column(name = "date")
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getMorWorkPunch() {
		return morWorkPunch;
	}

	public void setMorWorkPunch(Date morWorkPunch) {
		this.morWorkPunch = morWorkPunch;
	}

	public Date getMorOverPunch() {
		return morOverPunch;
	}

	public void setMorOverPunch(Date morOverPunch) {
		this.morOverPunch = morOverPunch;
	}

	public Date getAftWorkPunch() {
		return aftWorkPunch;
	}

	public void setAftWorkPunch(Date aftWorkPunch) {
		this.aftWorkPunch = aftWorkPunch;
	}

	public Date getAftOverPunch() {
		return aftOverPunch;
	}

	public void setAftOverPunch(Date aftOverPunch) {
		this.aftOverPunch = aftOverPunch;
	}

	public String getMorWorkStatus() {
		return morWorkStatus;
	}

	public void setMorWorkStatus(String morWorkStatus) {
		this.morWorkStatus = morWorkStatus;
	}

	public String getMorOverStatus() {
		return morOverStatus;
	}

	public void setMorOverStatus(String morOverStatus) {
		this.morOverStatus = morOverStatus;
	}

	public String getAftWorkStatus() {
		return aftWorkStatus;
	}

	public void setAftWorkStatus(String aftWorkStatus) {
		this.aftWorkStatus = aftWorkStatus;
	}

	public String getAftOverStatus() {
		return aftOverStatus;
	}

	public void setAftOverStatus(String aftOverStatus) {
		this.aftOverStatus = aftOverStatus;
	}

}
