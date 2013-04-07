package com.systop.zjimis.flow.model;

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
import javax.persistence.Table;
import javax.persistence.Transient;

import com.systop.archive.model.ArchiveFileLend;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;
import com.systop.core.util.DateUtil;

/***
 * 流程表
 * 
 * @author Nice
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "flows")
public class Flow extends BaseModel {

	private Integer id;

	// 申请人
	private User proposer;

	// 最终具体审核人
	private User auditor;

	// 标题
	private String title;

	// 创建日期
	private Date createDate;

	// 流程结束日期
	private Date endDate;

	// 状态:[start, stop, end]
	private String status;

	// 流程节点集合
	private List<FlowNode> nodes = new ArrayList<FlowNode>();

	// 档案文件借阅记录
	private ArchiveFileLend archiveFileLend;

	private List<FlowNode> flowNodes = new ArrayList<FlowNode>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "proposer_id")
	public User getProposer() {
		return proposer;
	}

	public void setProposer(User proposer) {
		this.proposer = proposer;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "auditor_id")
	public User getAuditor() {
		return auditor;
	}

	public void setAuditor(User auditor) {
		this.auditor = auditor;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "create_date")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Transient
	public String getCreateDateStr() {
		return DateUtil.getDateToString(createDate, "MM.dd");
	}

	@Column(name = "end_date")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@OneToMany(cascade = { CascadeType.REMOVE }, fetch = FetchType.LAZY, mappedBy = "flow")
	@JoinColumn(name = "flow_id")
	public List<FlowNode> getNodes() {
		return nodes;
	}

	public void setNodes(List<FlowNode> nodes) {
		this.nodes = nodes;
	}

	// @OneToOne(cascade = {}, fetch = FetchType.LAZY)
	// @JoinColumn(name = "contract_id")
	// public Contract getContract() {
	// return contract;
	// }
	//
	// public void setContract(Contract contract) {
	// this.contract = contract;
	// }

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "archive_file_lend_id")
	public ArchiveFileLend getArchiveFileLend() {
		return archiveFileLend;
	}

	public void setArchiveFileLend(ArchiveFileLend archiveFileLend) {
		this.archiveFileLend = archiveFileLend;
	}

	@OneToMany(cascade = { CascadeType.REMOVE }, fetch = FetchType.LAZY, mappedBy = "flow")
	public List<FlowNode> getFlowNodes() {
		return flowNodes;
	}

	public void setFlowNodes(List<FlowNode> flowNodes) {
		this.flowNodes = flowNodes;
	}

}
