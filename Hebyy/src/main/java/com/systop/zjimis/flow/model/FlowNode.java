package com.systop.zjimis.flow.model;

import java.util.Date;

import javax.persistence.*;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;
import com.systop.scos.communicate.smsg.model.Message;

/**
 * 流程节点
 * 
 * @author Nice
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "flow_nodes")
public class FlowNode extends BaseModel {

	private Integer id;

	// 审核人
	private User auditor;

	// 审核时间
	private Date audDate;

	// 说明
	private String descn;

	// 状态[pending,pass,noPass]
	private String status;

	// 节点审核顺序
	private Integer orderId;

	// 对应的流程
	private Flow flow;
    private String notified;

    private Message message;

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
	@JoinColumn(name = "auditor_id")
	public User getAuditor() {
		return auditor;
	}

	public void setAuditor(User auditor) {
		this.auditor = auditor;
	}

	@Column(name = "aud_date")
	public Date getAudDate() {
		return audDate;
	}

	public void setAudDate(Date audDate) {
		this.audDate = audDate;
	}

	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "flow_id")
	public Flow getFlow() {
		return flow;
	}

	public void setFlow(Flow flow) {
		this.flow = flow;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

    @Column(name="notified")
    public String getNotified() {
        return notified;
    }

    public void setNotified(String notified) {
        this.notified = notified;
    }

    @OneToOne
    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }
}
