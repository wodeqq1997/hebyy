package com.systop.scos.attendance.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 年假记录
 * @author SongBaoJie
 *
 */

@Entity
@Table(name = "leaves")
@SuppressWarnings("serial")
public class AnnualLeave extends BaseModel{
	
	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 原始天数
	 */
	private Integer days;
	
	/**
	 * 剩余天数
	 */
	private Integer lastDays;
	
	/**
	 * 录入时间
	 */
	private Date createTime;
	
	/**
	 * 录入员
	 */
	private User user;
	
	/** 
	 * 备注
	 */
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

	@Column(name = "days")
	public Integer getDays() {
		return days;
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	@Column(name = "last_days")
	public Integer getLastDays() {
		return lastDays;
	}

	public void setLastDays(Integer lastDays) {
		this.lastDays = lastDays;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
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

}
