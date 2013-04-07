package com.systop.scos.attendance.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.systop.core.model.BaseModel;
/**
 * 考勤时间
 *@author LinJie
 *@version 1.0
 */
@Entity
@Table(name = "persion_att")
@SuppressWarnings("serial")
public class Time extends BaseModel{

	private Integer id;
	
	//上午上班
	private String morWork = "8:30";
	
	//上午下班
	private String morOver = "12:00";
	
	//下午上班
	private String afWork = "14:00";
	
	//下午下班
	private String afOver = "18:00";

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMorWork() {
		return morWork;
	}

	public void setMorWork(String morWork) {
		this.morWork = morWork;
	}

	public String getMorOver() {
		return morOver;
	}

	public void setMorOver(String morOver) {
		this.morOver = morOver;
	}

	public String getAfWork() {
		return afWork;
	}

	public void setAfWork(String afWork) {
		this.afWork = afWork;
	}

	public String getAfOver() {
		return afOver;
	}

	public void setAfOver(String afOver) {
		this.afOver = afOver;
	}
}
