package com.systop.common.modules.security.user.model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.acegisecurity.GrantedAuthority;
import org.acegisecurity.userdetails.UserDetails;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.fileattch.model.FileAttch;
import com.systop.core.Constants;
import com.systop.core.model.BaseModel;
import com.systop.core.util.DateUtil;
import com.systop.hebyy.hrm.extinfo.model.EnterpriseExt;
import com.systop.scos.position.model.Position;

/**
 * 用户表 The persistent class for the users database table.
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "users", uniqueConstraints = {})
public class User extends BaseModel implements UserDetails, Serializable {

	private static Log log = LogFactory.getLog(User.class);

	// 主键
	private Integer id;

	// 登录帐号
	private String loginId;

	// 密码
	private String password;

	// 确认密码
	private String confirmPwd;

	// 状态
	private String status;

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
	
	//skypeId
	private String skype;

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

	// 最后登录IP
	private String lastLoginIp;

	// 最后登录时间
	private Date lastLoginTime;

	// 登录次数
	private Integer loginTimes;

	// 是否系统用户
	private String isSys = Constants.NO;

	// 用户排序ID
	private Integer orderId;

	// 用户照片
	private String photoId;
	
	//用户照片附件对象
	private FileAttch photo;
	
	// 所属部门
	private Dept dept;
	
	//最近合同签订开始时间
	private Date lastContractBegin;
	
	//最近合同签订截止时间
	private Date lastContractEnd;

	// 所具有的角色
	private Set<Role> roles = new HashSet<Role>(0);
	
	// 纬度
    private String locationLatitude;
    
    // 精度
    private String locationLongitude;
    private Date locationTime;
    
    // 紧急联系方式
 	private String emergencyPhone;
 	
 	// 档案存放
 	private String fileStorage;
 	
 	// 籍贯
 	private String hometown;
 	
    private String notified;
    private String notifiedSms;

    private Date lastOnlineTime;

    private EnterpriseExt enterpriseExt;
    // 缺省构造器
	public User() {
	}

	public User(Integer id) {
		this.id = id;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "login_id", length = 50)
	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	@Column(name = "password", length = 255)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	// 不做数据库映射
	@Transient
	public String getConfirmPwd() {
		return confirmPwd;
	}

	public void setConfirmPwd(String confirmPwd) {
		this.confirmPwd = confirmPwd;
	}

	@Column(name = "status", length = 1)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "name", length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "sex", length = 1)
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "mobile", length = 40)
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "phone", length = 40)
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "fox", length = 40)
	public String getFox() {
		return fox;
	}

	public void setFox(String fox) {
		this.fox = fox;
	}

	@Column(name = "email", length = 255)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getGraduationTime() {
		return graduationTime;
	}

	public void setGraduationTime(Date graduationTime) {
		this.graduationTime = graduationTime;
	}

	@Column(name = "oicq", length = 16)
	public String getOicq() {
		return oicq;
	}

	public void setOicq(String oicq) {
		this.oicq = oicq;
	}

	@Column(name = "msn", length = 64)
	public String getMsn() {
		return msn;
	}

	public void setMsn(String msn) {
		this.msn = msn;
	}

	@Column(name = "skype", length = 64)
	public String getSkype() {
		return skype;
	}

	public void setSkype(String skype) {
		this.skype = skype;
	}

	@Column(name = "address", length = 255)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "zip", length = 6)
	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	@Column(name = "id_card", length = 20)
	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	@Column(name = "birthday")
	public Date getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}

	@Column(name = "college", length = 100)
	public String getCollege() {
		return college;
	}

	public void setCollege(String college) {
		this.college = college;
	}

	@Column(name = "degree", length = 100)
	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	@Column(name = "major", length = 100)
	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	@Column(name = "join_time")
	public Date getJoinTime() {
		return joinTime;
	}

	public void setJoinTime(Date joinTime) {
		this.joinTime = joinTime;
	}

	@Column(name = "responsible_depts")
	public String getResponsibleDepts() {
		return responsibleDepts;
	}

	public void setResponsibleDepts(String responsibleDepts) {
		this.responsibleDepts = responsibleDepts;
	}

	@Column(name = "descn", length = 500)
	public String getDescn() {
		return descn;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "position_id")
	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@Column(name = "last_login_ip", length = 32)
	public String getLastLoginIp() {
		return lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}

	@Column(name = "last_login_time")
	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	@Transient
	public String getLastLoginTimeStr() {
		return DateUtil.convertDateToString(lastLoginTime, "yyyy-MM-dd HH:mm");
	}

	@Column(name = "loginTimes")
	public Integer getLoginTimes() {
		return loginTimes;
	}

	public void setLoginTimes(Integer loginTimes) {
		this.loginTimes = loginTimes;
	}

	@Column(name = "is_sys", columnDefinition = "char(1) default '0'")
	public String getIsSys() {
		return isSys;
	}

	public void setIsSys(String isSys) {
		this.isSys = isSys;
	}

	@Column(name = "order_id")
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
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
	
	public Date getLastContractBegin() {
		return lastContractBegin;
	}

	public void setLastContractBegin(Date lastContractBegin) {
		this.lastContractBegin = lastContractBegin;
	}

	public Date getFormalDate() {
		return formalDate;
	}

	public void setFormalDate(Date formalDate) {
		this.formalDate = formalDate;
	}

	public Date getLastContractEnd() {
		return lastContractEnd;
	}

	public void setLastContractEnd(Date lastContractEnd) {
		this.lastContractEnd = lastContractEnd;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_id")
	public Dept getDept() {
		return this.dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	@ManyToMany(targetEntity = Role.class, cascade = {}, fetch = FetchType.LAZY)
	@JoinTable(name = "user_role", joinColumns = { @JoinColumn(name = "user_id") }, inverseJoinColumns = { @JoinColumn(name = "role_id") })
	public Set<Role> getRoles() {
		return this.roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	/**
	 * 是否有角色
	 */
	@Transient
	public boolean getHasRoles() {
		return roles != null && roles.size() > 0;
	}

	@Override
	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof User)) {
			return false;
		}
		User castOther = (User) other;
		return new EqualsBuilder().append(this.getId(), castOther.getId())
				.isEquals();
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).toHashCode();
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this).append("id", getId())
				.append("name", getName()).toString();
	}

	// Methods from UserDetails
	/**
	 * 用户所具有的权限，可用通过角色-权限对应关系得到
	 */
	private transient GrantedAuthority[] authorities;

	/**
	 * @see {@link UserDetails#getAuthorities()}
	 */
	@Transient
	public GrantedAuthority[] getAuthorities() {
		return this.authorities;
	}

	/**
	 * @param authorities
	 *            the authorities to set
	 */
	public void setAuthorities(GrantedAuthority[] authorities) {
		log.info("Set GrantedAuthorities :" + Arrays.toString(authorities));
		this.authorities = authorities;
	}

	/**
	 * @see {@link UserDetails#getUsername()}
	 */
	@Transient
	public String getUsername() {
		return this.loginId;
	}

	/**
	 * @see {@link UserDetails#isAccountNonExpired()}
	 */
	@Transient
	public boolean isAccountNonExpired() {
		return true;
	}

	/**
	 * @see {@link UserDetails#isAccountNonLocked()}
	 */
	@Transient
	public boolean isAccountNonLocked() {
		return true;
	}

	/**
	 * {@link UserDetails#isCredentialsNonExpired()}
	 */
	@Transient
	public boolean isCredentialsNonExpired() {
		return true;
	}

	/**
	 * {@link UserDetails#isEnabled()}
	 */
	@Transient
	public boolean isEnabled() {
		return StringUtils.equalsIgnoreCase(status, Constants.STATUS_AVAILABLE);
	}

    public void setLocationLatitude(String locationLatitude) {
        this.locationLatitude = locationLatitude;
    }

    public void setLocationLongitude(String locationLongitude) {
        this.locationLongitude = locationLongitude;
    }

    @Column(name = "latitude", length = 32)
    public String getLocationLatitude() {
        return locationLatitude;
    }

    @Column(name = "longitude", length = 32)
    public String getLocationLongitude() {
        return locationLongitude;
    }

    @Column(name = "emergency_phone")
	public String getEmergencyPhone() {
		return emergencyPhone;
	}

	public void setEmergencyPhone(String emergencyPhone) {
		this.emergencyPhone = emergencyPhone;
	}

	@Column(name = "file_storage")
	public String getFileStorage() {
		return fileStorage;
	}

	public void setFileStorage(String fileStorage) {
		this.fileStorage = fileStorage;
	}

	public String getHometown() {
		return hometown;
	}

	public void setHometown(String hometown) {
		this.hometown = hometown;
	}

    @Column(name="notified")
    public String getNotified() {
        return notified;
    }

    public void setNotified(String notified) {
        this.notified = notified;
    }

    @Column(name="notified_sms")
    public String getNotifiedSms() {
        return notifiedSms;
    }

    public void setNotifiedSms(String notifiedSms) {
        this.notifiedSms = notifiedSms;
    }

    @Column(name="last_online_time")
    public Date getLastOnlineTime() {
        return lastOnlineTime;
    }

    public void setLastOnlineTime(Date lastOnlineTime) {
        this.lastOnlineTime = lastOnlineTime;
    }

    /**
     * @return
     */
    @Transient
    public boolean getOnline(){
        if(lastOnlineTime==null) return false;
        long l = new Date().getTime() - lastOnlineTime.getTime();
        return l <= (5 * 60+5) * 1000;//比5分钟多5秒
    }

    @Column(name="location_time")
    public Date getLocationTime() {
        return locationTime;
    }

    public void setLocationTime(Date locationTime) {
        this.locationTime = locationTime;
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
    
    @ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "enterpriseExt_id")
	public EnterpriseExt getEnterpriseExt() {
		return enterpriseExt;
	}

	public void setEnterpriseExt(EnterpriseExt enterpriseExt) {
		this.enterpriseExt = enterpriseExt;
	}
    
    
}