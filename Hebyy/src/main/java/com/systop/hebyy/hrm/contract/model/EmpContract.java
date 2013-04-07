package com.systop.hebyy.hrm.contract.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 员工合同
 * 
 * @author GaoRuoFan
 */
@Entity
@Table(name = "emp_contract")
@SuppressWarnings("serial")
public class EmpContract extends BaseModel{
	
	private Integer id;
	
	//合同起始时间
	private Date startTime;
	
	//合同截止时间
	private Date endTime;
	
	//员工
	private User user;
	
	//部门
	private Dept dept;
	
	//备注项
	private String remark;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	@OneToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_id")
	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}
}
