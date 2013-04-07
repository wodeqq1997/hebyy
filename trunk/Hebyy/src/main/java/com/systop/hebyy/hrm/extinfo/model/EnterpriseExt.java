package com.systop.hebyy.hrm.extinfo.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 企业档案
 * 
 * @author GaoRuoFan
 */
@Entity
@Table(name = "enterprise_ext")
@SuppressWarnings("serial")
public class EnterpriseExt extends BaseModel {

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 员工
	 * */
	private User user;

	/**
	 * 薪酬
	 * */
	private String salary;

	/**
	 * 企业工龄
	 * */
	private String workYear;

	/**
	 * 转正日期
	 * */
	private Date formalDate;

	/**
	 * 奖罚情况
	 * */
	private String awardPunish;

	/**
	 * 工作经历
	 * */
	private String workExp;

	/**
	 * 个人爱好
	 * */
	private String hobby;

	/**
	 * 职称
	 * */
	private String technical;

	/**
	 * 所获证书 附件
	 * */
	private String fileAttchIds;

	/**
	 * 培训经历
	 * */
	private String trainExp;

	/**
	 * 再教育经历
	 * */
	private String reEducationExp;

	/** 本企业表现 */
	private String companyRep;

	/** 创建时间 */
	private Date createTime = new Date();
	
	/** 保险：（五险）养老保险Pension[p]、
	 * 				  医 疗保险Medical[m]、
	 * 				  失业保险unemployment[u]、
	 * 				  工伤保险injuries[i]、
	 *				  生育保险 Fertility[f]
	 *        （一金）住房公积金。 HousingFund[h]
	 *  可以多个，例如：p,m,u,i,f 代表缴纳 养老、医疗、失业、工伤、生育。
	 */
	private String insurance;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@OneToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getWorkYear() {
		return workYear;
	}

	public void setWorkYear(String workYear) {
		this.workYear = workYear;
	}

	public Date getFormalDate() {
		return formalDate;
	}

	public void setFormalDate(Date formalDate) {
		this.formalDate = formalDate;
	}

	public String getAwardPunish() {
		return awardPunish;
	}

	public void setAwardPunish(String awardPunish) {
		this.awardPunish = awardPunish;
	}

	public String getWorkExp() {
		return workExp;
	}

	public void setWorkExp(String workExp) {
		this.workExp = workExp;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getTechnical() {
		return technical;
	}

	public void setTechnical(String technical) {
		this.technical = technical;
	}

	public String getFileAttchIds() {
		return fileAttchIds;
	}

	public void setFileAttchIds(String fileAttchIds) {
		this.fileAttchIds = fileAttchIds;
	}

	public String getTrainExp() {
		return trainExp;
	}

	public void setTrainExp(String trainExp) {
		this.trainExp = trainExp;
	}

	public String getReEducationExp() {
		return reEducationExp;
	}

	public void setReEducationExp(String reEducationExp) {
		this.reEducationExp = reEducationExp;
	}

	public String getCompanyRep() {
		return companyRep;
	}

	public void setCompanyRep(String companyRep) {
		this.companyRep = companyRep;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getInsurance() {
		return insurance;
	}

	public void setInsurance(String insurance) {
		this.insurance = insurance;
	}
	
}
