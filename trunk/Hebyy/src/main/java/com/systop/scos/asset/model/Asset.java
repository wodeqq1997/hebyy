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

import com.systop.common.modules.dept.model.Dept;
import com.systop.core.model.BaseModel;

/**
 * 资产、设备、物资
 * 
 * @author Nice
 */
@Entity
@Table(name = "assets")
@SuppressWarnings("serial")
public class Asset extends BaseModel {

	// 主键
	private Integer id;

	// 资产名称
	private String name;

	// 资产编号
	private String assetNo;

	// 规格型号
	private String stardard;

	// 厂家
	private String manufacturer;

	// 出厂日期
	private Date exFactoryDate;

	// 购买日期
	private Date buyDate;

	// 保管人
	private String custodian;

	// 资产值
	private Double assetValue;

	// 备注
	private String notes;

	// 物资类别
	private AssetType assetType;

	// 物资状态：好、损坏、报废
	private String status;
	
	// 配套物品
	private String matchItems;
	
	//部门
	private Dept dept;
	
	// 库存量
	private Integer stockCounts;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", length = 64)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "asset_no", length = 64)
	public String getAssetNo() {
		return assetNo;
	}

	public void setAssetNo(String assetNo) {
		this.assetNo = assetNo;
	}

	@Column(name = "stardard", length = 128)
	public String getStardard() {
		return stardard;
	}

	public void setStardard(String stardard) {
		this.stardard = stardard;
	}

	@Column(name = "manufacturer", length = 128)
	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	@Column(name = "ex_factory_date")
	public Date getExFactoryDate() {
		return exFactoryDate;
	}

	public void setExFactoryDate(Date exFactoryDate) {
		this.exFactoryDate = exFactoryDate;
	}

	@Column(name = "buy_date")
	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}

	@Column(name = "custodian", length = 64)
	public String getCustodian() {
		return custodian;
	}

	public void setCustodian(String custodian) {
		this.custodian = custodian;
	}

	@Column(name = "asset_value")
	public Double getAssetValue() {
		return assetValue;
	}

	public void setAssetValue(Double assetValue) {
		this.assetValue = assetValue;
	}

	@Column(name = "notes", length = 500)
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "asset_type_id")
	public AssetType getAssetType() {
		return assetType;
	}

	public void setAssetType(AssetType assetType) {
		this.assetType = assetType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "match_items")
	public String getMatchItems() {
		return matchItems;
	}

	public void setMatchItems(String matchItems) {
		this.matchItems = matchItems;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_id")
	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}
	
	public Integer getStockCounts() {
		return stockCounts;
	}

	public void setStockCounts(Integer stockCounts) {
		this.stockCounts = stockCounts;
	}
}
