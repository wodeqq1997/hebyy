package com.systop.hebyy.hrm.resume.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.systop.core.model.BaseModel;

/**
* 简历模板类
* @author GaoRuoFan
*/
@Entity
@Table(name = "resume_template")
@SuppressWarnings("serial")
public class ResumeTemplate extends BaseModel{
	
	private Integer id;
	
	//简历其他信息
	private String  otherExpTemp;

	//备注
	private String remark;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Type(type="text")
	public String getOtherExpTemp() {
		return otherExpTemp;
	}

	public void setOtherExpTemp(String otherExpTemp) {
		this.otherExpTemp = otherExpTemp;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
