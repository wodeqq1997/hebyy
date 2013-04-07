package com.systop.zjimis.flow.service;

import java.util.Date;

import javax.servlet.ServletContext;

import org.apache.struts2.StrutsStatics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.systop.archive.model.ArchiveFileLend;
import com.systop.archive.service.ArchiveFileLendManager;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.communicate.smsg.service.MessageManager;
import com.systop.zjimis.flow.FlowConstants;
import com.systop.zjimis.flow.model.Flow;
import com.systop.zjimis.flow.model.FlowNode;

/**
 * 流程管理
 * 
 * @author SongBaojie
 */
@Service
public class FlowManager extends BaseGenericsManager<Flow> {
	
	@Autowired
	private FlowNodeManager flowNodeManager;
	
	@Autowired
	private UserManager userManager;
	
	@Autowired
	private ArchiveFileLendManager archiveFileLendManager;
	
	@Autowired
	private MessageManager messageManager;//短消息
	
	@Transactional
	public void save(){
		
	}
	
	/**
	 * 根据字段名，对应ID保存flow及审批人
	 * @param field 字段名
	 * @param fieldId    对应ID
	 * @param auditor 审批人
	 * @param proposer 申请人
	 * @see FlowConstants field 字段名
	 * 
	 */
	@Transactional
	public void saveFlowByField(String field, String fieldId, String auditor, User proposer){
		//创建流程
		Flow flow = new Flow();
		flow.setCreateDate(new Date());
		flow.setProposer(proposer);
		//字段：档案文件借阅(archiveFileLend)
		if(field.equals(FlowConstants.FIELD_ARCHIVEFILELEND)){
			ArchiveFileLend fileLend = archiveFileLendManager.get(Integer.valueOf(fieldId));
			flow.setArchiveFileLend(fileLend);
			flow.setTitle("【"+ fileLend.getArchiveFile().getArchive().getName() 
							  + "-" 
							  +fileLend.getArchiveFile().getName() + "】档案文件借阅审批");
		}		
		
		
		//保存流程
		try{
			
			save(flow);
		}catch(Exception e){e.printStackTrace();}
		//得到审批人
		User auditorUser = userManager.get(Integer.valueOf(auditor));
		if(auditorUser == null){
			throw new ApplicationException("审批人为空");
		}else{
			//创建流程节点
			FlowNode flowNode = new FlowNode();
			User user = userManager.get(Integer.valueOf(auditor));
			flowNode.setAuditor(user);
			flowNode.setFlow(flow);
			flowNode.setOrderId(1);
			flowNode.setStatus(FlowConstants.STATUS_PENDING);
			flowNodeManager.save(flowNode);
		
			//生成短消息			 
			ServletContext ctx = (ServletContext) ActionContext.getContext().get(StrutsStatics.SERVLET_CONTEXT);
			String path = ctx.getContextPath();
			messageManager.saveNodeMsg(new Object[] { FlowConstants.TITLE_MAP.get(field), path, flowNode.getId() ,flowNode}, user);
		}
	}
	
	
	/**
	 * 改变流程状态为:开始
	 */
	@Transactional
	public void changeFlowForStart(Flow flow){
		flow.setStatus(FlowConstants.FLOW_STATUS_START);
		update(flow);
	}
	
	/**
	 * 改变流程状态为:停止
	 */
	@Transactional
	public void changeFlowForStop(Flow flow){
		flow.setStatus(FlowConstants.FLOW_STATUS_STOP);
		update(flow);
	}
	
	/**
	 * 改变流程状态为:结束
	 */
	@Transactional
	public void changeFlowForEnd(Flow flow){
		flow.setStatus(FlowConstants.FLOW_STATUS_END);
		update(flow);
	}
}
