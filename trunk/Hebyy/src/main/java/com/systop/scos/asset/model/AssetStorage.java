package com.systop.scos.asset.model;

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
 * 入库管理
 * @author Zero
 */
@Entity
@Table(name = "asset_storage")
@SuppressWarnings("serial")
public class AssetStorage extends BaseModel {
	
	private Integer id;
	
	// 物资领用 日期
	private Date takeTime;
	// 物资领用 操作人
	private User takeOperator;
	// 物资领用 人
	private String takePerson;
	// 物资领用 明细
	private String takeDetail;

	// 物资归还  操作人
	private User bringOperator;
	// 物品归还 人
	private String bringPerson;
	// 物资归还 明细
	private String bringDetail;
	// 物资归还 日期
	private Date bringTime;
	// 方量
	private Integer square;
	
	// 物资
	private Asset asset;
	// 状态
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

	@Column(name = "take_time")
	public Date getTakeTime() {
		return takeTime;
	}

	public void setTakeTime(Date takeTime) {
		this.takeTime = takeTime;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "take_operator_id")
	public User getTakeOperator() {
		return takeOperator;
	}

	public void setTakeOperator(User takeOperator) {
		this.takeOperator = takeOperator;
	}

	@Column(name = "take_person")
	public String getTakePerson() {
		return takePerson;
	}

	public void setTakePerson(String takePerson) {
		this.takePerson = takePerson;
	}

	@Column(name = "take_detail", length=1000)
	public String getTakeDetail() {
		return takeDetail;
	}

	public void setTakeDetail(String takeDetail) {
		this.takeDetail = takeDetail;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "bring_operator_id")
	public User getBringOperator() {
		return bringOperator;
	}

	public void setBringOperator(User bringOperator) {
		this.bringOperator = bringOperator;
	}

	@Column(name = "bring_person")
	public String getBringPerson() {
		return bringPerson;
	}

	public void setBringPerson(String bringPerson) {
		this.bringPerson = bringPerson;
	}

	@Column(name = "bring_detail",length=1000)
	public String getBringDetail() {
		return bringDetail;
	}

	public void setBringDetail(String bringDetail) {
		this.bringDetail = bringDetail;
	}

	@Column(name = "bring_time")
	public Date getBringTime() {
		return bringTime;
	}

	public void setBringTime(Date bringTime) {
		this.bringTime = bringTime;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "asset_id")
	public Asset getAsset() {
		return asset;
	}

	public void setAsset(Asset asset) {
		this.asset = asset;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "square")
	public Integer getSquare() {
		return square;
	}

	public void setSquare(Integer square) {
		this.square = square;
	}
}
