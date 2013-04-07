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
 * 供应商询价
 * @author SongBaojie
 */
@Entity
@Table(name = "goods_supplier_inquirys")
@SuppressWarnings("serial")
public class GoodsInquiry extends BaseModel {

	// 主键
	private Integer id;

	
	// 商品
	private Goods goods;

	// 报价
	private String price;

	// 供应商
	private GoodsSupplier goodsSupplier;

	// 备注
	private String notes;

	// 创建时间 
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

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "goods_id")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	@Column(name = "price")
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "goods_supplier_id")
	public GoodsSupplier getGoodsSupplier() {
		return goodsSupplier;
	}

	public void setGoodsSupplier(GoodsSupplier goodsSupplier) {
		this.goodsSupplier = goodsSupplier;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "notes", length = 500)
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

}
