package com.systop.scos.asset.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.systop.core.model.BaseModel;

/**
 * 设备物资类别
 * 
 * @author Nice
 */
@Entity
@Table(name = "asset_types")
@SuppressWarnings("serial")
public class AssetType extends BaseModel {

	// 主键
	private Integer id;

	// 类别名称
	private String name;

	// 描述
	private String descn;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", length = 32)
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

}