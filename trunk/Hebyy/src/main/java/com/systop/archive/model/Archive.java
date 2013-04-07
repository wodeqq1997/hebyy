package com.systop.archive.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 案卷
 * 
 * @author SongBaoJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "archives")
public class Archive extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 案卷编号 */
	private String archiveNO;

	/** 案卷名称 */
	private String name;

	/** 状态 */
	private String status;

	/** 备注 */
	private String remark;

	/** 创建时间 */
	private Date createTime;

	/** 案卷类型 */
	private ArchiveType archiveType;
	
	/** 创建人  */
	private User user;

	/** 归档年代 */
	private Date archiveYear;
	
	/** (保管)起始日期 */
	private Date beginDate;
	
	/** (保管)终止日期 */
	private Date endDate; 
	
	/** 所属部门 */
	private Dept dept;
	
	/** 编制机构 */
	private String editDept;
	
	/** 保管期限 */
	private String deadline;
	
	/** 案卷密级 */
	private String dense;
	
	/** 全宗号 */
	private String categoryNO;
	
	/** 目录号 */
	private String catalogNO;
	
	// 案卷保管位置 
	// 档案柜
	private ArchiveCabinet archiveCabinet;
	
	/** 缩微号 */
	private String microNO;
	
	/** 页数 */
	private Integer archivePage;
	
	private List<ArchiveFile> archiveFiles = new ArrayList<ArchiveFile>(0);


    private String content;

    /**
     * 是否有提交归档
     */
    private Boolean submit;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "archive_no")
	public String getArchiveNO() {
		return archiveNO;
	}

	public void setArchiveNO(String archiveNO) {
		this.archiveNO = archiveNO;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "archive_type_id")
	public ArchiveType getArchiveType() {
		return archiveType;
	}

	public void setArchiveType(ArchiveType archiveType) {
		this.archiveType = archiveType;
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
	
	@Column(name = "archive_year")
	public Date getArchiveYear() {
		return archiveYear;
	}

	public void setArchiveYear(Date archiveYear) {
		this.archiveYear = archiveYear;
	}

	@Column(name = "begin_date")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	@Column(name = "end_date")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_id")
	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	@Column(name = "edit_dept")
	public String getEditDept() {
		return editDept;
	}

	public void setEditDept(String editDept) {
		this.editDept = editDept;
	}

	@Column(name = "deadline")
	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	@Column(name = "dense")
	public String getDense() {
		return dense;
	}

	public void setDense(String dense) {
		this.dense = dense;
	}

	@Column(name = "category_no")
	public String getCategoryNO() {
		return categoryNO;
	}

	public void setCategoryNO(String categoryNO) {
		this.categoryNO = categoryNO;
	}

	@Column(name = "catalog_no")
	public String getCatalogNO() {
		return catalogNO;
	}

	public void setCatalogNO(String catalogNO) {
		this.catalogNO = catalogNO;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "archive_cabinet_id")
	public ArchiveCabinet getArchiveCabinet() {
		return archiveCabinet;
	}

	public void setArchiveCabinet(ArchiveCabinet archiveCabinet) {
		this.archiveCabinet = archiveCabinet;
	}

	@Column(name = "micro_no")
	public String getMicroNO() {
		return microNO;
	}

	public void setMicroNO(String microNO) {
		this.microNO = microNO;
	}

	@Column(name = "archive_page")
	public Integer getArchivePage() {
		return archivePage;
	}

	public void setArchivePage(Integer archivePage) {
		this.archivePage = archivePage;
	}

	@OneToMany(cascade = {CascadeType.REMOVE}, fetch = FetchType.LAZY, mappedBy = "archive")
	public List<ArchiveFile> getArchiveFiles() {
		return archiveFiles;
	}

	public void setArchiveFiles(List<ArchiveFile> archiveFiles) {
		this.archiveFiles = archiveFiles;
	}

    public Boolean getSubmit() {
        return submit;
    }

    public void setSubmit(Boolean submit) {
        this.submit = submit;
    }

    /**
     * 案卷内容
     * @return
     */
    @Column(length = 1000,name="content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}