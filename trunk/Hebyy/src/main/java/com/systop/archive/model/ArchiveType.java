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
import com.systop.core.Constants;
import com.systop.core.model.BaseModel;

/**
 * 档案类别
 * 
 * @author SongBaoJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "archive_types")
public class ArchiveType extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 档案类别名称 */
	private String name;
	
	// 档案编号标示：例如：2012kc-01 其中标示为kc。2012djcl-01其中标示为djcl。等。
	private String archiveNumMark;

	/** 状态 */
	private String status = Constants.YES;

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

	@Column(name = "remark")
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
	
	@Column(name = "archive_num_mark")
	public String getArchiveNumMark() {
		return archiveNumMark;
	}

	public void setArchiveNumMark(String archiveNumMark) {
		this.archiveNumMark = archiveNumMark;
	}

	@Column(name = "status", length = 1, columnDefinition = "char(1) default '1'")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@OneToMany(cascade = {}, fetch = FetchType.LAZY, mappedBy = "archiveType")
	public Set<Archive> getArchives() {
		return archives;
	}

	public void setArchives(Set<Archive> archives) {
		this.archives = archives;
	}

}