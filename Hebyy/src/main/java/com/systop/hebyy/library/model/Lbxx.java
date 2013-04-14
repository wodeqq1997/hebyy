package com.systop.hebyy.library.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.systop.core.model.BaseModel;

/**
 * 图书类别信息
 * 
 * @author 王亚萍
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "LBXX")
public class Lbxx extends BaseModel {

	private Integer id;

	// 类别名称
	private String lbMc;
	
	//备注
	private String  descn;
	
	// 图书集合
	private List<Tsxx> tsxxList;

	@Id
	@GeneratedValue(generator = "hibseq")
	@GenericGenerator(name = "hibseq", strategy = "hilo")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLbMc() {
		return lbMc;
	}

	public void setLbMc(String lbMc) {
		this.lbMc = lbMc;
	}

	@OneToMany(cascade = {}, mappedBy = "lbxx")
	public List<Tsxx> getTsxxList() {
		return tsxxList;
	}

	public void setTsxxList(List<Tsxx> tsxxList) {
		this.tsxxList = tsxxList;
	}
    
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

}
