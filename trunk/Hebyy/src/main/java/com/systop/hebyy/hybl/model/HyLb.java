package com.systop.hebyy.hybl.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.systop.core.model.BaseModel;

/**
 * 会议类别信息
 * 
 * @author wyp
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "HYLB")
public class HyLb extends BaseModel {
	
	private Integer id;
	
	//会议类别
	private String hyLbMc;
	
	//备注
    private String remark;	


	@Id
	@GeneratedValue(generator = "hibseq")
	@GenericGenerator(name = "hibseq", strategy = "hilo")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getHyLbMc() {
		return hyLbMc;
	}

	public void setHyLbMc(String hyLbMc) {
		this.hyLbMc = hyLbMc;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}
