package com.systop.hebyy.hrm.resume.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.systop.core.model.BaseModel;


/**
* 简历
* @author GaoRuoFan
*/
@Entity
@Table(name = "resume")
@SuppressWarnings("serial")
public class Resume extends BaseModel{

	private Integer id;
	
	//姓名
	private String name;
	
	//生日
	private String birthday;
	
	//性别
	private String sex;
	
	 //学历
	private String degree;
	
	//专业
	private String major;
	
	//籍贯
	private String jiguan;
	
	//毕业时间
	private String graduationTime;
	
	//毕业院校
	private String graduatCollege;
	
	//户口所在地
	private String hukou;
	
	// 手机
	private String mobile;
	
	//档案存放地
	private String archivesAdd;
	
	//身份证号
	private String personalId;
	
	//联系地址
	private String address;
	
	//邮箱
	private String email;
	
	//个人爱好
	private String hobby;

	//简历创建时间
	private Date CreateTime = new Date();
	
	/** 
	 *其他信息
	 * */
	private String otherExp;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getJiguan() {
		return jiguan;
	}

	public void setJiguan(String jiguan) {
		this.jiguan = jiguan;
	}

	public String getGraduationTime() {
		return graduationTime;
	}

	public void setGraduationTime(String graduationTime) {
		this.graduationTime = graduationTime;
	}

	public String getHukou() {
		return hukou;
	}

	public void setHukou(String hukou) {
		this.hukou = hukou;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getArchivesAdd() {
		return archivesAdd;
	}

	public void setArchivesAdd(String archivesAdd) {
		this.archivesAdd = archivesAdd;
	}

	public String getPersonalId() {
		return personalId;
	}

	public void setPersonalId(String personalId) {
		this.personalId = personalId;
	}

	public String getGraduatCollege() {
		return graduatCollege;
	}

	public void setGraduatCollege(String graduatCollege) {
		this.graduatCollege = graduatCollege;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	@Type(type = "text")
	public String getOtherExp() {
		return otherExp;
	}

	public void setOtherExp(String otherExp) {
		this.otherExp = otherExp;
	}

	public Date getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(Date createTime) {
		CreateTime = createTime;
	}
}
