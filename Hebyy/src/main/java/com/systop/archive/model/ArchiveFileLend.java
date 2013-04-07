package com.systop.archive.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;
import com.systop.zjimis.flow.model.Flow;

/**
 * 档案文件借阅记录
 * 
 * @author SongBaoJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "archive_file_lends")
public class ArchiveFileLend extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 状态 */
	// 1:待审批      2：审批通过
	private String status;

	/** 备注 */
	private String remark;

	/** 归还档案日期 */
	private Date alsoDate;
	
	/** 借阅人  */
	private User lendUser;
	
	/** 借阅档案文件 */
	private ArchiveFile archiveFile;
	
	/** 创建时间 (申请日期)*/
	private Date createTime;
	
	private List<Flow> flows = new ArrayList<Flow>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "remark", length = 500)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "also_date")
	public Date getAlsoDate() {
		return alsoDate;
	}

	public void setAlsoDate(Date alsoDate) {
		this.alsoDate = alsoDate;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "lend_user_id")
	public User getLendUser() {
		return lendUser;
	}

	public void setLendUser(User lendUser) {
		this.lendUser = lendUser;
	}

	@Column(name = "status", length = 2)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "archive_file_id")
	public ArchiveFile getArchiveFile() {
		return archiveFile;
	}

	public void setArchiveFile(ArchiveFile archiveFile) {
		this.archiveFile = archiveFile;
	}
	
	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@OneToMany(cascade = {CascadeType.REMOVE}, fetch = FetchType.LAZY, mappedBy = "archiveFileLend")
	@OrderBy("createDate desc")
	public List<Flow> getFlows() {
		return flows;
	}

	public void setFlows(List<Flow> flows) {
		this.flows = flows;
	}
	
	@Transient
	public Flow getLastFlow(){
		if(getFlows().size() >0){
			return getFlows().get(0);
		}
		return null;
	}
}