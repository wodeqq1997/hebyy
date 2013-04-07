package com.systop.scos.position.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.systop.common.modules.dept.model.Dept;
import com.systop.core.model.BaseModel;

/**
 *@author LinJie
 *@version 1.0
 *@create 2012-5-25 下午4:22:55
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "positions")
public class Position extends BaseModel {

	//Id
	private Integer id;
	
	//职位名称
	private String name;
	
	//描述
	private String descn;
	
	//关联部门表Id
	private Dept dept;
	
	// 排序
	private Integer orderId;
	
	// 职位权限：例如审批：0
	private String authority;
	
	//缺省构造方法
	public Position(){
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "descn")
	@Type(type = "text")
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_id")
	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	@Column(name = "order_id")
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	@Column(name = "authority")
	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
}
