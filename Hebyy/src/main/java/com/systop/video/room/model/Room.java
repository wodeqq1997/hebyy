package com.systop.video.room.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.systop.core.model.BaseModel;

@Entity
@Table(name = "rooms", uniqueConstraints = {})
@SuppressWarnings("serial")
public class Room extends BaseModel {
	
	private Integer id;
	
	/**
	 * 房间name
	 */
	private String name;
	
	/**
	 * 房间密码
	 */
	private String password;
	
	/**
	 * 成员数量
	 */
	private Integer membersCount;

	/**
	 * 房主的用户名
	 */
	private String master;
	
	/**
	 * 房主姓名
	 */
	private String masterName;

	/**
	 * 房间成员，用,隔开的多个用户ID
	 */
	private String members;

	/**
	 * 等待队列，用,隔开的多个用户ID
	 */
	private String waitings;

	private String remark;

	private Date createTime;
	
	/** 会议记录 */
	private String meetingRecord;
	
	/** 会议所归属的区县 */
	// private Dept county;
	
	/** 会议状态 0未开始 1 进行中 2 暂停 3结束 */
	private String status;

	@Column(unique = true, name = "roomName")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getMembersCount() {
		return membersCount;
	}

	@Column(name = "members_count")
	public void setMembersCount(Integer membersCount) {

		this.membersCount = membersCount;
	}

	public String getMaster() {
		return master;
	}

	public void setMaster(String master) {
		this.master = master;
	}

	public String getMembers() {
		return members;
	}

	public void setMembers(String members) {
		this.members = members;
	}

	@Column(name = "waitings", columnDefinition = "varchar(2000)")
	public String getWaitings() {
		return waitings;
	}

	public void setWaitings(String waitings) {
		this.waitings = waitings;
	}

	@Column(name = "remark", columnDefinition = "varchar(2000)")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Transient
	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	@Column(name = "create_Time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "meeting_Record", columnDefinition = "varchar(2000)")
	public String getMeetingRecord() {
		return meetingRecord;
	}

	public void setMeetingRecord(String meetingRecord) {
		this.meetingRecord = meetingRecord;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	// @ManyToOne(fetch = FetchType.LAZY)
	/*
	 * @JoinColumn(name = "COUNTY") public Dept getCounty() { return county; }
	 * 
	 * public void setCounty(Dept county) { this.county = county; }
	 */

	@Column(name = "STATUS", length = 1)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "PASSWORD")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
