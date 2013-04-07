package com.systop.scos.goods.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.systop.core.model.BaseModel;

/**
 * 物品类别
 * @author Nice
 */
@Entity
@Table(name = "goods_types")
@SuppressWarnings("serial")
public class GoodsType extends BaseModel {
	
	// 主键
	private Integer id;

	// 类别名称
	private String name;

	// 描述
	private String descn;
	
	private Set<Goods> goods = new HashSet<Goods>(0);

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

	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}
	
	@OneToMany(cascade = {}, fetch = FetchType.LAZY, mappedBy = "goodsType")
	public Set<Goods> getGoods() {
		return goods;
	}

	public void setGoods(Set<Goods> goods) {
		this.goods = goods;
	}
	

}
