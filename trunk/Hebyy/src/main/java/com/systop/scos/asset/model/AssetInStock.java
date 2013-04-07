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
 * @Date 2012-8-31
 * @author LinJie
 * 
 */
@Entity
@Table(name = "asset_instocks")
@SuppressWarnings("serial")
public class AssetInStock extends BaseModel {

	//主键
	private Integer id;
	
	//供应商
	private String provider;
	
	//入库单编号
	private String stockNo;
	
	//单价
	private Double price;
	
	//入库数量
	private Integer inCounts;

	//现有数量
	private Integer nowCounts;
	
	//金额
	private Double amount;
	
	//入库日期
	private Date inDate;
	
	//创建单子时间
	private Date createTime;
	
	//经手人
	private String buyer;
	
	// 备注
	private String notes;
	
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

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	@Column(name = "stock_no")
	public String getStockNo() {
		return stockNo;
	}

	public void setStockNo(String stockNo) {
		this.stockNo = stockNo;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	@Column(name = "in_counts")
	public Integer getInCounts() {
		return inCounts;
	}

	public void setInCounts(Integer inCounts) {
		this.inCounts = inCounts;
	}

	@Column(name = "now_counts")
	public Integer getNowCounts() {
		return nowCounts;
	}

	public void setNowCounts(Integer nowCounts) {
		this.nowCounts = nowCounts;
	}

	@Column(name = "amount")
	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	@Column(name = "in_date")
	public Date getInDate() {
		return inDate;
	}

	public void setInDate(Date inDate) {
		this.inDate = inDate;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "buyer", length = 32)
	public String getBuyer() {
		return buyer;
	}

	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	
	@Column(name = "notes")
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
	
}
