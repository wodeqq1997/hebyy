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
 * 入库单,办公用品入库时需要同时更新物品表的库存
 * @author Nice
 */
@Entity
@Table(name = "in_stock")
@SuppressWarnings("serial")
public class InStock extends BaseModel {
	
	//主键
	private Integer id;
	
	//供应商
	private String provider;
	
	// 供应商 对象引用
	private GoodsSupplier goodsSupplier;
	
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
	
	//物品
	private Goods goods;

	// 备注
	private String notes;
	
	//保质期（选填）
	private Date shelflife;
	
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

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "goods_id")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	@Column(name = "notes")
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	@Column(name="shelflife")
	public Date getShelflife() {
		return shelflife;
	}

	public void setShelflife(Date shelflife) {
		this.shelflife = shelflife;
	}

	
	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "goods_supplier_id")
	public GoodsSupplier getGoodsSupplier() {
		return goodsSupplier;
	}

	public void setGoodsSupplier(GoodsSupplier goodsSupplier) {
		this.goodsSupplier = goodsSupplier;
	}
	
	

}
