package com.systop.archive.model;

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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 档案柜
 * 
 * @author SongBaoJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "archive_cabinets")
public class ArchiveCabinet extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 档案柜名称 */
	private String name;

	/** 案卷保管位置 */
	private String location;

	/** 备注 */
	private String remark;

	/** 创建时间 */
	private Date createTime = new Date();

	/** 创建人 */
	private User user;
	
	private Set<Archive> archives = new HashSet<Archive>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
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

	@Column(name = "location")
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
	@Column(name = "remark", length = 500)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@OneToMany(cascade = {}, fetch = FetchType.LAZY, mappedBy = "archiveCabinet")
	public Set<Archive> getArchives() {
		return archives;
	}

	public void setArchives(Set<Archive> archives) {
		this.archives = archives;
	}

}