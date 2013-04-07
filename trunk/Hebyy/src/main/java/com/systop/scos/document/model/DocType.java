package com.systop.scos.document.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.Constants;
import com.systop.core.model.BaseModel;

@SuppressWarnings("serial")
@Entity
@Table(name = "doc_types")
public class DocType extends BaseModel {

	//主键
	private Integer id;

	//类别名称
	private String name;

	//文档作者
	private User owner;
	
	//类型描述
	private String descn;

	/**
	 * 是否公共文档类别
	 */
	private String isPublic = Constants.NO;
	
	// 上级文档类型
	private DocType parentDocType;

	// 下级文档类型
	private Set<DocType> childDocTypes = new HashSet<DocType>(0);

	// 商品类型编号规则：两位数字，从1自动排；
	private String serialNo;
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "owner_id")
	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	@Column(name = "is_public", length = 1)
	public String getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}

	
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id")
	public DocType getParentDocType() {
		return parentDocType;
	}

	public void setParentDocType(DocType parentDocType) {
		this.parentDocType = parentDocType;
	}

	@OneToMany(cascade = {}, fetch = FetchType.LAZY, mappedBy = "parentDocType")
	public Set<DocType> getChildDocTypes() {
		return childDocTypes;
	}

	public void setChildDocTypes(Set<DocType> childDocTypes) {
		this.childDocTypes = childDocTypes;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	
}
