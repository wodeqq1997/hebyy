package com.systop.zjimis.flow.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.systop.common.modules.security.user.UserUtil;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.ApplicationException;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.JsonCrudAction;
import com.systop.zjimis.flow.FlowConstants;
import com.systop.zjimis.flow.model.FlowNode;
import com.systop.zjimis.flow.service.FlowNodeManager;

/**
 * 流程管理Action
 * 
 * @author Nice,SongBaojie
 */

@SuppressWarnings({ "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class FlowNodeAction extends JsonCrudAction<FlowNode, FlowNodeManager> {

	// 根据flow.title查询
	private String flowTitle;

	private Map<String, Object> result;

	// AJAX调用，首页显示待办事项
	private List<Map<String, Object>> nodes;

	// 首页显示待办事项条数
	private Integer viewCount;

	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;
	
	// flow类型
	private String flowType;

	/**
	 * 属于我的审批节点
	 * 
	 * @return
	 */
	public String myIndex() {
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer(
				"from FlowNode n where n.auditor.id = ?");
		args.add(getLoginUser().getId());
		if (StringUtils.isNotBlank(flowTitle)) {
			hql.append(" and n.flow.title like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(flowTitle));
		}
		
		if(StringUtils.isNotBlank(flowType)){
			hql.append(" and n.flow." + flowType + " is not null");
		}
		
		if (startDate != null) {
			hql.append(" and n.flow.createDate >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}

		if (endDate != null) {
			hql.append(" and n.flow.createDate <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}
		
		hql.append(" order by n.flow.createDate desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return "myIndex";
	}

	/**
	 * 首页获取待办事项
	 * 
	 * @return
	 */
	public String indexPendingNodes() {
		nodes = toMapList(getManager().getPendingNodes(getLoginUser(), viewCount));
		return "indexNodes";
	}

	// 转换成Map避免转换JSON数据的时候把太多没用的数据加在进来
	private List<Map<String, Object>> toMapList(List<FlowNode> items) {
		List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
		for (FlowNode node : items) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", node.getId());
			map.put("descn", node.getDescn());
			map.put("flowTitle", node.getFlow().getTitle());
			map.put("createDate", node.getFlow().getCreateDateStr());
			maps.add(map);
		}
		return maps;
	}

	/**
	 * 审核
	 */
	public String auditFlowNode() {
		result = new HashMap<String, Object>();
		if (getModel() != null && getModel().getId() != null) {
			String auditor = getRequest().getParameter("auditorId");
			String field = getRequest().getParameter("field");
			getManager().auditFlowNode(getModel(), getModel().getFlow(),
					auditor, field, getServletContext().getContextPath());
			result.put("success", true);
			result.put("info", "审核完成");
		} else {
			result.put("success", false);
			result.put("info", "审核失败");
		}
		return "saveSuccess";
	}

    @Override
    public String view() {
        User auditor = getModel().getAuditor();
        User user = UserUtil.getLoginUser(getRequest());
        if (auditor.getId().equals(user.getId())) {
            try{
            String isRead = getModel().getMessage().getIsRead();
            if(isRead.equals("0")){
                getModel().getMessage().setIsRead("1");
                getManager().save(getModel());
            }
            }
            catch(Exception e){
            }
            return super.view();
        }
        throw new ApplicationException();
    }

    /**
	 * 返回flow中所有审批名称
	 * @return
	 */
	public Map<String, String> getFlowTitleMap(){
		return FlowConstants.TITLE_MAP;
	}
	
	public Map<String, Object> getResult() {
		return result;
	}

	public String getFlowTitle() {
		return flowTitle;
	}

	public void setFlowTitle(String flowTitle) {
		this.flowTitle = flowTitle;
	}

	public List<Map<String, Object>> getNodes() {
		return nodes;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}
	
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public String getFlowType() {
		return flowType;
	}

	public void setFlowType(String flowType) {
		this.flowType = flowType;
	}

}