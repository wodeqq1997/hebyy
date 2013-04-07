package com.systop.archive.model;

import java.util.Date;

import javax.persistence.*;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 档案文件
 * 
 * @author SongBaoJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "archive_files")
public class ArchiveFile extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 文件名称 */
	private String name;

	/** 文件编号 */
	private String fileNO;

	/** 状态 */
	private String status;

	/** 备注 */
	private String remark;

	/** 创建时间 */
	private Date createTime;

	/** 文件所属案卷 */
	private Archive archive;
	
	/** 创建人  */
	private User user;
	
	/** 发文单位 */
	private String sendUnit;
	
	/** 发文日期 */
	private Date sendDate;
	
	/** 密级 */
	private String dense;
	
	/** 文件页数 */
	private Integer filePage;
	
	/** 打印页数 */
	private Integer printPage;
	
	/** 附件 */
	private String attachIds;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "file_no")
		public String getFileNO() {
		return fileNO;
	}

	public void setFileNO(String fileNO) {
		this.fileNO = fileNO;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "archive_id")
	public Archive getArchive() {
		return archive;
	}

	public void setArchive(Archive archive) {
		this.archive= archive;
	}

	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
	
	@Column(name = "status", length = 1, columnDefinition = "char(1) default '1'")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "send_unit")
	public String getSendUnit() {
		return sendUnit;
	}

	public void setSendUnit(String sendUnit) {
		this.sendUnit = sendUnit;
	}

	@Column(name = "send_date")
	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	public String getDense() {
		return dense;
	}

	public void setDense(String dense) {
		this.dense = dense;
	}

	@Column(name = "file_page")
	public Integer getFilePage() {
		return filePage;
	}

	public void setFilePage(Integer filePage) {
		this.filePage = filePage;
	}

	@Column(name = "print_page")
	public Integer getPrintPage() {
		return printPage;
	}

	public void setPrintPage(Integer printPage) {
		this.printPage = printPage;
	}

	@Column(name = "attach_ids")
	public String getAttachIds() {
		return attachIds;
	}

	public void setAttachIds(String attachIds) {
		this.attachIds = attachIds;
	}

}