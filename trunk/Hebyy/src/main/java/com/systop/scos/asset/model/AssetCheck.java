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
 * 设备物资检测记录
 *@author LinJie
 *@version 1.0
 *@create 2012-6-21 下午3:47:11
 */
@Entity
@Table(name = "asset_repairs")
@SuppressWarnings("serial")
public class AssetCheck extends BaseModel {

	//主键
    private Integer id;
    
    //送检时间
	private Date checkDate;
	
	// 校检时间
	private Date correctDate;
	
	//送检人
	private String executant;
	
	//备注
	private String notes;
		
	//物资
	private Asset asset;
	
	/** 附件 */
	private String attachIds;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "check_date")
	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	@Column(name = "correct_date")
	public Date getCorrectDate() {
		return correctDate;
	}

	public void setCorrectDate(Date correctDate) {
		this.correctDate = correctDate;
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

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "asset_id")
	public Asset getAsset() {
		return asset;
	}

	public void setAsset(Asset asset) {
		this.asset = asset;
	}
	
	@Column(name = "attach_ids")
	public String getAttachIds() {
		return attachIds;
	}

	public void setAttachIds(String attachIds) {
		this.attachIds = attachIds;
	}
	
}
