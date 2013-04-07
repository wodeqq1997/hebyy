package com.systop.archive.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.archive.ArchiveConstants;
import com.systop.archive.model.ArchiveFileLend;
import com.systop.archive.service.ArchiveFileLendManager;
import com.systop.archive.service.ArchiveTypeManager;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.Constants;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.zjimis.flow.FlowConstants;
import com.systop.zjimis.flow.service.FlowNodeManager;

/**
 * 案卷借阅记录管理Action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings({ "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ArchiveFileLendAction extends DefaultCrudAction<ArchiveFileLend, ArchiveFileLendManager> {

	@Autowired
	private FlowNodeManager flowNodeManager;
	
	@Autowired
	private ArchiveTypeManager archiveTypeManager;
	
	// 流程状态
	private String flowStatus;
	
	//归还状态
	private String alsoStatus;
	
	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;

	private Map<String, Object> result;
	
	// 查询条件
	private String hql;

	// 查询条件所需参数
	private Object[] args;
	
	/**
	 * 查询我的案卷借阅
	 */
	@Override
	public String index() {
		Map<String, Object> queryMap = buildQuery(getLoginUser());

		hql = queryMap.get(Constants.HQL_KEY).toString();
		args = (Object[]) queryMap.get(Constants.ARGS_KEY);
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args);
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 查询案卷借阅记录（所有记录）
	 */
	public String allIndex() {
		Map<String, Object> queryMap = buildQuery(null);

		hql = queryMap.get(Constants.HQL_KEY).toString();
		args = (Object[]) queryMap.get(Constants.ARGS_KEY);
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args);
		restorePageData(page);
		return "allIndex";
	}
	
	/**
	 * 组合查询条件
	 * 
	 * @param user
	 *            可为null
	 * @return
	 */
	private Map<String, Object> buildQuery(User user) {
		Map<String, Object> query = new HashMap<String, Object>();
		StringBuffer sql = new StringBuffer("from ArchiveFileLend a where 1=1");
		List<Object> args = new ArrayList<Object>();

		if(user != null){
			sql.append(" and a.lendUser.id = ?");
			args.add(getLoginUser().getId());
		}
		
		//归还状态
		if(StringUtils.isNotBlank(alsoStatus)){
			//未归还状态
			if(alsoStatus.equals("null")){
				sql.append(" and a.alsoDate is null");
			}else if(alsoStatus.equals("notNull")){//已归还状态
				sql.append(" and a.alsoDate is not null");
			}
		}
		
		if (getModel().getArchiveFile() != null && StringUtils.isNotBlank(getModel().getArchiveFile().getName())) {
			sql.append(" and a.archiveFile.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getArchiveFile().getName()));
		}
		if (startDate != null) {
			sql.append(" and a.createTime >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if (endDate != null) {
			sql.append(" and a.createTime <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}
		
		sql.append(" order by a.createTime desc");

		query.put(Constants.HQL_KEY, sql.toString());
		query.put(Constants.ARGS_KEY, args.toArray());
		return query;
	}
	
	/**
	 * 审核审核信息列表
	 */
	public String auditIndex(){
		User user = getLoginUser();
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = flowNodeManager.queryPaddingNodes(page, user.getId(), FlowConstants.FIELD_ARCHIVEFILELEND);
		restorePageData(page);
		return "auditIndex";
	}
	
	/**
	 * 案卷借阅记录审核页面
	 */
	public String auditEdit(){
		return "auditEdit";
	}

	/**
	 * 异步保存案卷借阅 
	 */
	public String lendSave(){
		// 默认保存负责人
		getModel().setLendUser(getLoginUser());
		result = new HashMap<String, Object>();
		String auditor = getRequest().getParameter("auditor");
		String fileIds = getRequest().getParameter("fileIds");
		if(getModel().getId() != null){
			//案卷借阅已存在
			result.put("success",false);
		}else{
			//保存案卷借阅记录（待审批）
			getModel().setStatus(ArchiveConstants.STATUS_PENDING);
			getManager().save(getModel(), auditor, fileIds);
			result.put("success",true);
		}
		return "jsonSuccess";
	}
	
	/**
	 * 异步判断档案文件是否已经借阅 
	 */
	public String isArchiveFile(){
		// 默认保存负责人
		result = new HashMap<String, Object>();
		String fileIds = getRequest().getParameter("fileIds");
		if(getManager().isArchiveFile(Integer.valueOf(fileIds), getLoginUser())){
			// 该档案文件已借阅 
			result.put("success",true);
		}else{
			// 该档案文件未借阅
			result.put("success",false);
		}
		return "jsonSuccess";
	}
	
	/**
	 * 预览案卷借阅记录
	 */
	public String view() {
		//否则在只查看案卷借阅记录信息(审核通过或未通过或未审核)
		return VIEW;
	}
	
	/**
	 * 归还案卷
	 */
	public String alsoArchiveLend(){
		if(getModel() != null && getModel().getId() != null){
			getModel().setAlsoDate(new Date());
			getManager().save(getModel());
		}
		return SUCCESS;
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

	public String getAlsoStatus() {
		return alsoStatus;
	}

	public void setAlsoStatus(String alsoStatus) {
		this.alsoStatus = alsoStatus;
	}

	public String getFlowStatus() {
		return flowStatus;
	}

	public void setFlowStatus(String flowStatus) {
		this.flowStatus = flowStatus;
	}
	
	public Map<String, Object> getResult() {
		return result;
	}
	
	/**
	 * 返回审核状态
	 * @return
	 * Map<String,String>
	 */
	public Map<String, String> getIsFlowNodeStatusMap(){
		return FlowConstants.STATUS_MAP;
	}
	
	/**
	 * 所有案卷类型MAP
	 * 
	 * @return Map
	 */
	public Map<Integer, String> getArchiveTypeMap() {
		return archiveTypeManager.getAllArchiveType();
	}
}