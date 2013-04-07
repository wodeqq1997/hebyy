package com.systop.scos.attendance.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 考勤
 * 
 * @author SongBaoJie
 */
@Entity
@Table(name = "attendances")
@SuppressWarnings("serial")
public class Attendance extends BaseModel {

	/** 主键*/
	private Integer id;

	/**月份*/
	private Date attendanceDate; 
	
	/**考勤部门*/
	private Dept dept;
	
	/**应出勤天数*/
	private Double shouldDays;
		
	/**录入时间*/
	private Date createTime;
	
	/**录入员*/
	private User user;
	
	/**备注*/
	private String remark;
	
	/**
	 * 考勤人员项
	 */
	private List<AttendanceItem> items = new ArrayList<AttendanceItem>(0);
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "attendance_date")
	public Date getAttendanceDate() {
		return attendanceDate;
	}

	public void setAttendanceDate(Date attendanceDate) {
		this.attendanceDate = attendanceDate;
	}
	
	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_id")
	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "should_days")
	public Double getShouldDays() {
		return shouldDays;
	}

	public void setShouldDays(Double shouldDays) {
		this.shouldDays = shouldDays;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "remark", length = 500)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@OneToMany(cascade = {}, fetch = FetchType.LAZY, mappedBy = "attendance")
	public List<AttendanceItem> getItems() {
		return items;
	}

	public void setItems(List<AttendanceItem> items) {
		this.items = items;
	}
	
	
}
