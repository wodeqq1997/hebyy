package com.systop.scos.goods.model;

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
 * 物品管理：办公用品、烟酒等
 * 
 * @author Nice
 */
@Entity
@Table(name = "goods")
@SuppressWarnings("serial")
public class Goods extends BaseModel {

	// 主键
	private Integer id;

	// 物品名称
	private String name;

	// 物品编号
	private String goodsNo;

	// 规格
	private String specifications;
	
	// 单价
	private Double price;
	
	// 计量单位
	private String unit;

	// 备注
	private String notes;

	// 库存量
	private Integer stockCounts;

	// 最低库存量、警告库存量
	//private Integer warnCounts;
	
	// 上限数量
	private Integer maxCount;

	// 报警数量 （下限数量）
	private Integer minCount;
	
	//物品类别
	private GoodsType goodsType;

	// 创建日期
	private Date createTime;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGoodsNo() {
		return goodsNo;
	}

	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}

	public String getSpecifications() {
		return specifications;
	}

	public void setSpecifications(String specifications) {
		this.specifications = specifications;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public Integer getStockCounts() {
		return stockCounts;
	}

	public void setStockCounts(Integer stockCounts) {
		this.stockCounts = stockCounts;
	}

	@Column(name = "max_count")
	public Integer getMaxCount() {
		return maxCount;
	}

	public void setMaxCount(Integer maxCount) {
		this.maxCount = maxCount;
	}

	@Column(name = "min_count")
	public Integer getMinCount() {
		return minCount;
	}

	public void setMinCount(Integer minCount) {
		this.minCount = minCount;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "goods_type_id")
	public GoodsType getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(GoodsType goodsType) {
		this.goodsType = goodsType;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
