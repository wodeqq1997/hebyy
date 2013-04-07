package com.systop.scos.car.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.systop.common.modules.fileattch.model.FileAttch;
import com.systop.core.model.BaseModel;

/**
 * 车辆信息
 * 
 * @author Nice
 */
@Entity
@Table(name = "cars")
@SuppressWarnings("serial")
public class Car extends BaseModel {

	// 主键
	private Integer id;

	// 车牌
	private String carNo;

	// 汽车类型:轿车、货车、商务车
	private String carType;

	// 发动机号
	private String engineNo;

	// 厂家
	private String factory;

	// 保险购买日期
	private Date buyInsureTime;

	// 年审时间
	private Date auditTime;

	// 购置日期
	private Date buyDate;

	// 汽车照片
	private String carPhoto;

	// 车辆状态: 1=可用、2=维修中、0=报废
	private String status;

	// 服务电话 4s店
	private String servicePhone;

	// 描述
	private String descn;
	
	//多少公里保养
	private String maintenance;
	
	private FileAttch fileAttch;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "car_no", length = 16)
	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	@Column(name = "car_type", length = 16)
	public String getCarType() {
		return carType;
	}

	public void setCarType(String carType) {
		this.carType = carType;
	}

	@Column(name = "engine_no", length = 64)
	public String getEngineNo() {
		return engineNo;
	}

	public void setEngineNo(String engineNo) {
		this.engineNo = engineNo;
	}

	@Column(name = "factory", length = 128)
	public String getFactory() {
		return factory;
	}

	public void setFactory(String factory) {
		this.factory = factory;
	}

	@Column(name = "buy_insure_time")
	public Date getBuyInsureTime() {
		return buyInsureTime;
	}

	public void setBuyInsureTime(Date buyInsureTime) {
		this.buyInsureTime = buyInsureTime;
	}

	@Column(name = "audit_time")
	public Date getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(Date auditTime) {
		this.auditTime = auditTime;
	}

	@Column(name = "buy_date")
	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}

	@Column(name = "car_photo", length = 128)
	public String getCarPhoto() {
		return carPhoto;
	}

	public void setCarPhoto(String carPhoto) {
		this.carPhoto = carPhoto;
	}

	@Column(name = "status", length = 1)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "service_phone", length = 32)
	public String getServicePhone() {
		return servicePhone;
	}

	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}

	@Column(name = "descn", length = 500)
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@Transient
	public FileAttch getFileAttch() {
		return fileAttch;
	}

	public void setFileAttch(FileAttch fileAttch) {
		this.fileAttch = fileAttch;
	}

	@Column(name = "maintenance")
	public String getMaintenance() {
		return maintenance;
	}

	public void setMaintenance(String maintenance) {
		this.maintenance = maintenance;
	}

	
}
