package com.systop.scos.car.model;

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
 * 汽车使用申请记录
 * 
 * @author Nice
 */
@Entity
@Table(name = "car_applys")
@SuppressWarnings("serial")
public class CarApply extends BaseModel {

	// 主键
	private Integer id;

	// 申请人
	private User proposer;

	// 人数
	private Integer personCount;

	// 申请日期
	private Date applyDate;

	// 事由
	private String reason;

	// 开始时间
	private Date startTime;

	// 结束时间
	private Date endTime;

	// 开始里程
	private Double startMileage;

	// 结束里程
	private Double endMileage;

	// 耗油量
	private Double oilUse;

	// 备注
	private String notes;

	// 审批状态 0：未审核 1：通过 2：未通过
	private String status;

	// 车辆
	private Car car;

	// 司机
	private User chauffeur;
	
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
	@JoinColumn(name = "proposer_id")
	public User getProposer() {
		return proposer;
	}

	public void setProposer(User proposer) {
		this.proposer = proposer;
	}

	@Column(name = "person_count")
	public Integer getPersonCount() {
		return personCount;
	}

	public void setPersonCount(Integer personCount) {
		this.personCount = personCount;
	}

	@Column(name = "apply_date")
	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	@Column(name = "reason")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Column(name = "start_time")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	@Column(name = "end_time")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	@Column(name = "start_mileage")
	public Double getStartMileage() {
		return startMileage;
	}

	public void setStartMileage(Double startMileage) {
		this.startMileage = startMileage;
	}

	@Column(name = "end_mileage")
	public Double getEndMileage() {
		return endMileage;
	}

	public void setEndMileage(Double endMileage) {
		this.endMileage = endMileage;
	}

	@Column(name = "oil_use")
	public Double getOilUse() {
		return oilUse;
	}

	public void setOilUse(Double oilUse) {
		this.oilUse = oilUse;
	}

	@Column(name = "notes")
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	@Column(name = "status")
		public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "car_id")
	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "chauffeur_id")
	public User getChauffeur() {
		return chauffeur;
	}

	public void setChauffeur(User chauffeur) {
		this.chauffeur = chauffeur;
	}
}
