package com.systop.hebyy.gzzd.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.systop.core.model.BaseModel;

/**
 * 分类
 * 
 * @author wangyaping
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "ZCXX")
public class Zcxx extends BaseModel {

	private Integer id;

	// 类别编号
	private String zcxh;

	// 类别名称
	private String zcMc;
	
	//分类备注
	private String remark;
	
	

	// 规章制度集合
	private List<Gzzd> gzzdList;

	@Id
	@GeneratedValue(generator = "hibseq")
	@GenericGenerator(name = "hibseq", strategy = "hilo")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getZcxh() {
		return zcxh;
	}

	public void setZcxh(String zcxh) {
		this.zcxh = zcxh;
	}

	public String getZcMc() {
		return zcMc;
	}

	public void setZcMc(String zcMc) {
		this.zcMc = zcMc;
	}

	@OneToMany(cascade = {}, mappedBy = "zcxx")
	public List<Gzzd> getGzzdList() {
		return gzzdList;
	}

	public void setGzzdList(List<Gzzd> gzzdList) {
		this.gzzdList = gzzdList;
	}
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	
}
