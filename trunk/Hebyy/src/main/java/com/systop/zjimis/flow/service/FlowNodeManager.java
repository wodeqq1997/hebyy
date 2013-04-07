package com.systop.zjimis.flow.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.StrutsStatics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.systop.archive.ArchiveConstants;
import com.systop.archive.model.ArchiveFileLend;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.dao.support.Page;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.scos.communicate.smsg.service.MessageManager;
import com.systop.zjimis.flow.FlowConstants;
import com.systop.zjimis.flow.model.Flow;
import com.systop.zjimis.flow.model.FlowNode;

/**
 * 流程节点Service
 * 
 * @author SongBaojie
 */
@Service
public class FlowNodeManager extends BaseGenericsManager<FlowNode> {

	@Autowired
	private FlowManager flowManager;

	@Autowired
	private UserManager userManager;

	@Autowired
	private MessageManager messageManager;// 短消息

	/**
	 * 修改审批流程中的审批人（修改第一个审批人）
	 * 
	 * @param list
	 * @param auditor
	 */
	@Transactional
	public void update(List<FlowNode> list, Integer auditor) {
		// 判断修改第一个审批人
		for (FlowNode node : list) {
			if (!Integer.valueOf(auditor).equals(node.getAuditor().getId())) {
				User aud = userManager.get(Integer.valueOf(auditor));
				node.setAuditor(aud);
				node.setStatus(FlowConstants.STATUS_PENDING);
				getDao().getHibernateTemplate().clear();
				update(node);
				return;
			}
		}
	}

	/**
	 * 审批流程节点
	 */
	@Transactional
	public void auditFlowNode(FlowNode node, Flow flow, String auditor,
			String field, String contextPath) {
		// 审批通过
		if (node.getStatus().equals(FlowConstants.STATUS_PASS)) {
			node = getFlowNodePass(node, flow, auditor, field, contextPath);
		} else {// 审批未通过
			node = getFlowNodeNoPass(node, flow, auditor, field);
		}
		// 审批时间
		node.setAudDate(new Date());
		update(node);
	}

	/**
	 * 得到审核通过的流程节点
	 * 
	 * @param node
	 * @param flow
	 * @param auditor
	 * @param field
	 * @return
	 */
	@Transactional
	public FlowNode getFlowNodePass(FlowNode node, Flow flow, String auditor,
			String field, String contextPath) {
		// 判断是否有下一个审批人
		if (auditor != null && !auditor.equals("")) {
			// 创建下一个审批人
			User user = userManager.get(Integer.valueOf(auditor));
			FlowNode flowNode = new FlowNode();
			flowNode.setStatus(FlowConstants.STATUS_PENDING);
			flowNode.setFlow(flow);
			flowNode.setOrderId(node.getOrderId() + 1);
			flowNode.setAuditor(user);
			save(flowNode);

			flow.setEndDate(new Date());
			// 改变流程状态为：开始
			flowManager.changeFlowForStart(flow);
			// 生成短消息
			ServletContext ctx = (ServletContext) ActionContext.getContext()
					.get(StrutsStatics.SERVLET_CONTEXT);
			String path = ctx.getContextPath();
			messageManager.saveNodeMsg(
					new Object[] { FlowConstants.TITLE_MAP.get(field), path,
							flowNode.getId() ,flowNode}, user);
		} else {
			// 最终审批人
			flow.setAuditor(node.getAuditor());
			// 最终审批时间
			flow.setEndDate(new Date());
			// flowManager.update(flow);
			// 改变流程状态为：结束
			flowManager.changeFlowForEnd(flow);
			// 审批反馈消息描述
			String feedbackMsg = "";

			// 【档案】审批
			if (field.equals(FlowConstants.FIELD_ARCHIVEFILELEND)) {
				// 改变【档案借阅】状态（【审批通过】状态）
				ArchiveFileLend archiveFileLend = flow.getArchiveFileLend();
				archiveFileLend.setStatus(ArchiveConstants.STATUS_PASS);
				getDao().saveOrUpdate(archiveFileLend);
				feedbackMsg = "档案【"
						+ archiveFileLend.getArchiveFile().getArchive()
								.getName() + " - "
						+ archiveFileLend.getArchiveFile().getName() + "】审批通过！";
			}

			// 生成审批通过反馈短消息
			messageManager.saveNodeFeedbackMsg(new Object[] { feedbackMsg },
					flow.getProposer());
		}
		return node;
	}

	/**
	 * 得到审核未通过的流程节点
	 * 
	 * @param node
	 * @param flow
	 * @param auditor
	 * @param field
	 * @return
	 */
	@Transactional
	public FlowNode getFlowNodeNoPass(FlowNode node, Flow flow, String auditor,
			String field) {
		// 改变流程状态为：停止
		flow.setEndDate(new Date());
		flow.setAuditor(node.getAuditor());
		flowManager.changeFlowForStop(flow);
		// 审批反馈消息描述
		String feedbackMsg = "";


		// 【档案】审批
		if (field.equals(FlowConstants.FIELD_ARCHIVEFILELEND)) {
			// 改变【档案借阅】状态（【审批未通过】状态）
			ArchiveFileLend archiveFileLend = flow.getArchiveFileLend();
			archiveFileLend.setStatus(ArchiveConstants.STATUS_NOPASS);
			getDao().saveOrUpdate(archiveFileLend);
			feedbackMsg = "档案【"
					+ archiveFileLend.getArchiveFile().getArchive().getName()
					+ " - " + archiveFileLend.getArchiveFile().getName()
					+ "】审批未通过！";
		}

		// 生成审批通过反馈短消息
		messageManager.saveNodeFeedbackMsg(new Object[] { feedbackMsg },
				flow.getProposer());

		return node;
	}

	/**
	 * 根据当前用户ID查询待审节点信息
	 * 
	 * @param page
	 * @param userId
	 * @param flowField
	 *            (流程中的关联字段名例：project,scheme)
	 * @return
	 */
	public Page queryPaddingNodes(Page page, Integer userId, String flowField) {
		List<Object> args = new ArrayList<Object>();

		StringBuffer hql = new StringBuffer(
				"from FlowNode f where f.auditor.id = ?");
		hql.append(" and f.status = ?");
		hql.append(" and f.flow.");
		hql.append(flowField);
		hql.append(" is not null ");

		args.add(userId);
		args.add(FlowConstants.STATUS_PENDING);

		page = pageQuery(page, hql.toString(), args.toArray());
		return page;
	}

	/**
	 * 根据当前用户ID查询历史审批节点信息(不包括待审批)
	 * 
	 * @param page
	 * @param startDate
	 * @param endDate
	 * @param flowStatus
	 *            审批状态【通过：pass，未通过：noPass】
	 * @param userId
	 * @param flowField
	 *            (流程中的关联字段名例：project,scheme等)
	 * @return
	 */
	public Page queryHistoryNodes(Page page, Integer userId, Date startDate,
			Date endDate, String flowStatus, String flowField) {
		List<Object> args = new ArrayList<Object>();

		StringBuffer hql = new StringBuffer(
				"from FlowNode f where f.auditor.id = ?");
		args.add(userId);

		// 流程审批状态
		if (StringUtils.isNotBlank(flowStatus)) {
			hql.append(" and f.status = ?");
			args.add(flowStatus);
		} else {
			hql.append(" and f.status != ?");
			args.add(FlowConstants.STATUS_PENDING);
		}
		// 审批时间
		if (startDate != null) {
			hql.append(" and f.audDate >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if (endDate != null) {
			hql.append(" and f.audDate <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}
		
		hql.append(" and f.flow.");
		hql.append(flowField);
		hql.append(" is not null order by f.audDate desc");

		page = pageQuery(page, hql.toString(), args.toArray());
		return page;
	}

	/**
	 * 根据用户获得count给定的前若干条记录
	 * 
	 * @param user
	 * @param count
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FlowNode> getPendingNodes(User user, Integer count) {
		String hql = "from FlowNode n where n.auditor.id = ? and n.status = ? order by n.flow.createDate desc";
		Page page = PageUtil.getPage(1, count);
		page = pageQuery(page, hql, new Object[] { user.getId(),
				FlowConstants.STATUS_PENDING });
		return page.getData();
	}

    public List<FlowNode> getAllPendingNodes(User user) {
		String hql = "from FlowNode n where n.auditor.id = ? and n.status = ? and n.notified is null order by n.flow.createDate desc";
        List<FlowNode> list = getDao().limitQurey(hql,999, new Object[]{user.getId(),
                FlowConstants.STATUS_PENDING});
        return list;
	}
}
