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
 * 请假记录
 * @author SongBaoJie
 *
 */

@Entity
@Table(name = "leaves")
@SuppressWarnings("serial")
public class Leave extends BaseModel{
	
	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 请假天数
	 */
	private Double leaveDay;
	
	/**
	 * 请假开始日期
	 */
	private Date leaveStartDate;
	
	/**
	 * 请假结束日期
	 */
	private Date leaveEndDate;
	
	/**
	 * 请假员工
	 */
	private User leaveUser;
	
	/** 
	 * 请假原因
	 */
	private String leaveData;
	
	/**
	 * 是否需要给审核人消息通知
	 */
	private String isRemind;
	
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	@Column(name = "leave_day")
	public Double getLeaveDay() {
		return leaveDay;
	}

	public void setLeaveDay(Double leaveDay) {
		this.leaveDay = leaveDay;
	}

	@Column(name = "leave_start_date")
	public Date getLeaveStartDate() {
		return leaveStartDate;
	}

	public void setLeaveStartDate(Date leaveStartDate) {
		this.leaveStartDate = leaveStartDate;
	}

	@Column(name = "leave_end_date")
	public Date getLeaveEndDate() {
		return leaveEndDate;
	}

	public void setLeaveEndDate(Date leaveEndDate) {
		this.leaveEndDate = leaveEndDate;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "leave_user_id")
	public void setLeaveUser(User leaveUser) {
		this.leaveUser = leaveUser;
	}

	public User getLeaveUser() {
		return leaveUser;
	}

	@Column(name = "remark", length = 500)
	public String getLeaveData() {
		return leaveData;
	}

	public void setLeaveData(String leaveData) {
		this.leaveData = leaveData;
	}

	@Column(name = "is_remind")
	public String getIsRemind() {
		return isRemind;
	}

	public void setIsRemind(String isRemind) {
		this.isRemind = isRemind;
	}

}
