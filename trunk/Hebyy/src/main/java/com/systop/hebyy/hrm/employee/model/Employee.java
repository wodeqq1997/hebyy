package com.systop.hebyy.hrm.employee.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.fileattch.model.FileAttch;
import com.systop.core.model.BaseModel;
import com.systop.scos.position.model.Position;
/**
 * 员工表 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "employee", uniqueConstraints = {})
public class Employee  extends BaseModel{

		// 主键
		private Integer id;

		// 姓名
		private String name;

		// 性别
		private String sex;

		// 手机
		private String mobile;

		// 办公电话
		private String phone;

		// 传真
		private String fox;

		// 电子邮件地址
		private String email;

		//QQ
		private String oicq;

		//MSN
		private String msn;

		// 地址
		private String address;
		
		// 邮编
		private String zip;

		// 身份证号
		private String idCard;

		// 出生日期
		private Date birthDay;

		// 毕业院校
		private String college;
		
		 //毕业时间
		private Date graduationTime;

		// 学历
		private String degree;

		// 专业
		private String major;

		// 入职时间
		private Date joinTime;
		
		//转正时间
		private Date formalDate;

		// 职务、职责
		private Position position;

		// 负责部门 （负责多个部门用,号分开）
		private String responsibleDepts;
		
		// 用户描述
		private String descn;

		// 用户照片
		private String photoId;
		
		//用户照片附件对象
		private FileAttch photo;

		
		//最近合同签订开始时间
		private Date lastContractBegin;
		
		//最近合同签订截止时间
		private Date lastContractEnd;
	    
	    // 紧急联系方式
	 	private String emergencyPhone;
	 	
	 	// 籍贯
	 	private String hometown;

		// 所属部门
		private Dept dept;

	 	
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
		@Column(name = "sex")
		public String getSex() {
			return sex;
		}

		public void setSex(String sex) {
			this.sex = sex;
		}
		@Column(name = "mobile")
		public String getMobile() {
			return mobile;
		}

		public void setMobile(String mobile) {
			this.mobile = mobile;
		}
		@Column(name = "phone")
		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}
		@Column(name = "fox")
		public String getFox() {
			return fox;
		}

		public void setFox(String fox) {
			this.fox = fox;
		}
		@Column(name = "email")
		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}
		@Column(name = "oicq")
		public String getOicq() {
			return oicq;
		}

		public void setOicq(String oicq) {
			this.oicq = oicq;
		}
		@Column(name = "msn")
		public String getMsn() {
			return msn;
		}

		public void setMsn(String msn) {
			this.msn = msn;
		}
		@Column(name = "address")
		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}
		@Column(name = "zip")
		public String getZip() {
			return zip;
		}

		public void setZip(String zip) {
			this.zip = zip;
		}
		@Column(name = "idCard")
		public String getIdCard() {
			return idCard;
		}

		public void setIdCard(String idCard) {
			this.idCard = idCard;
		}
		@Column(name = "birthDay")
		public Date getBirthDay() {
			return birthDay;
		}

		public void setBirthDay(Date birthDay) {
			this.birthDay = birthDay;
		}
		@Column(name = "college")
		public String getCollege() {
			return college;
		}

		public void setCollege(String college) {
			this.college = college;
		}
		@Column(name = "graduationTime")
		public Date getGraduationTime() {
			return graduationTime;
		}

		public void setGraduationTime(Date graduationTime) {
			this.graduationTime = graduationTime;
		}
		@Column(name = "degree")
		public String getDegree() {
			return degree;
		}

		public void setDegree(String degree) {
			this.degree = degree;
		}
		@Column(name = "major")
		public String getMajor() {
			return major;
		}

		public void setMajor(String major) {
			this.major = major;
		}
		@Column(name = "joinTime")
		public Date getJoinTime() {
			return joinTime;
		}

		public void setJoinTime(Date joinTime) {
			this.joinTime = joinTime;
		}
		@Column(name = "formalDate")
		public Date getFormalDate() {
			return formalDate;
		}

		public void setFormalDate(Date formalDate) {
			this.formalDate = formalDate;
		}
		@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
		@JoinColumn(name = "position_id")
		public Position getPosition() {
			return position;
		}

		public void setPosition(Position position) {
			this.position = position;
		}
		@Column(name = "responsibleDepts")
		public String getResponsibleDepts() {
			return responsibleDepts;
		}

		public void setResponsibleDepts(String responsibleDepts) {
			this.responsibleDepts = responsibleDepts;
		}
		@Column(name = "descn")
		public String getDescn() {
			return descn;
		}

		public void setDescn(String descn) {
			this.descn = descn;
		}
		
		@Column(name = "photo_id")
		public String getPhotoId() {
			return photoId;
		}

		public void setPhotoId(String photoId) {
			this.photoId = photoId;
		}
		
		@Transient
		public FileAttch getPhoto() {
			return photo;
		}

		public void setPhoto(FileAttch photo) {
			this.photo = photo;
		}
		
		@Column(name = "lastContractBegin")
		public Date getLastContractBegin() {
			return lastContractBegin;
		}

		public void setLastContractBegin(Date lastContractBegin) {
			this.lastContractBegin = lastContractBegin;
		}
		@Column(name = "lastContractEnd")
		public Date getLastContractEnd() {
			return lastContractEnd;
		}

		public void setLastContractEnd(Date lastContractEnd) {
			this.lastContractEnd = lastContractEnd;
		}
		@Column(name = "emergencyPhone")
		public String getEmergencyPhone() {
			return emergencyPhone;
		}

		public void setEmergencyPhone(String emergencyPhone) {
			this.emergencyPhone = emergencyPhone;
		}
		@Column(name = "hometown")
		public String getHometown() {
			return hometown;
		}

		public void setHometown(String hometown) {
			this.hometown = hometown;
		}
		
		@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
		@JoinColumn(name = "dept_id")
		public Dept getDept() {
			return this.dept;
		}

		public void setDept(Dept dept) {
			this.dept = dept;
		}
	    /**
	     * 合同是否过期,-1不存在,0过期,1正常
	     * @return
	     */
	    @Transient
	    public int getContractStatus(){
	        if(getLastContractEnd()==null){
	            return -1;
	        }
	        else{
	            Date now = new Date();
	            return now.after(getLastContractEnd())?0:1;
	        }

	    }
}
