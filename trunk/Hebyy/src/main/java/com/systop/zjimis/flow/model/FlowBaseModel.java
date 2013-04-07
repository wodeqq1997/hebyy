package com.systop.zjimis.flow.model;

import javax.persistence.Column;

public class FlowBaseModel {

	//审核状态
	protected String auditState;

	@Column(name = "audit_state", length = 2)
	public String getAuditState() {
		return auditState;
	}

	public void setAuditState(String auditState) {
		this.auditState = auditState;
	}
}
