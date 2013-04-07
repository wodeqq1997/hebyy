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

import com.systop.core.model.BaseModel;

/**
 * 设备物资维修记录
 *@author LinJie
 *@version 1.0
 *@create 2012-6-21 下午3:47:11
 */
@Entity
@Table(name = "asset_repairs")
@SuppressWarnings("serial")
public class AssetRepair extends BaseModel {

	//主键
    private Integer id;
    
    //维修日期
	private Date repairDate;
	
	//维修类型： 维修、保养
	private String repairType;

	//原因
	private String reason;
	
	//经办人
	private String executant;
	
	//备注
	private String notes;
	
	//费用
	private Double fee;
	
	//物资
	private Asset asset;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "repair_date")
	public Date getRepairDate() {
		return repairDate;
	}

	public void setRepairDate(Date repairDate) {
		this.repairDate = repairDate;
	}

	@Column(name = "repair_type", length = 8)
	public String getRepairType() {
		return repairType;
	}

	public void setRepairType(String repairType) {
		this.repairType = repairType;
	}

	@Column(name = "reason")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Column(name = "executant", length = 32)
	public String getExecutant() {
		return executant;
	}

	public void setExecutant(String executant) {
		this.executant = executant;
	}

	@Column(name = "notes", length = 500)
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	@Column(name = "fee")
	public Double getFee() {
		return fee;
	}

	public void setFee(Double fee) {
		this.fee = fee;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "asset_id")
	public Asset getAsset() {
		return asset;
	}

	public void setAsset(Asset asset) {
		this.asset = asset;
	}
	
}
