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

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 *@author LinJie
 *@version 1.0
 *@create 2012-6-11 下午3:53:54
 */
@Entity
@Table(name = "reported_atte")
@SuppressWarnings("serial")
public class ReportedAtte extends BaseModel {

	//id
	private Integer id;
	
	//日期
	private Date date;
	
	//用户
	private User user;
	
	//考勤部门
	private Dept dept;
	
	//事假
	private Double leaveDay;
	
	//病假
	private Double diseaseDay;
	
	//旷工
	private Integer absentCount;
	
	//迟到
	private Integer lateCount;

	//备注
	private String mark;
	
	//状态
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

	@Column(name = "date")
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_id")
	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	@Column(name = "leaveDays")
	public Double getLeaveDay() {
		return leaveDay;
	}

	public void setLeaveDay(Double leaveDay) {
		this.leaveDay = leaveDay;
	}
	
	@Column(name = "diseaseDays")
	public Double getDiseaseDay() {
		return diseaseDay;
	}

	public void setDiseaseDay(Double diseaseDay) {
		this.diseaseDay = diseaseDay;
	}


	@Column(name = "absentCount")
	public Integer getAbsentCount() {
		return absentCount;
	}

	public void setAbsentCount(Integer absentCount) {
		this.absentCount = absentCount;
	}

	@Column(name = "lateCount")
	public Integer getLateCount() {
		return lateCount;
	}

	public void setLateCount(Integer lateCount) {
		this.lateCount = lateCount;
	}

	@Column(name = "mark")
	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
