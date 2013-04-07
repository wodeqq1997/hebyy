package com.systop.scos.attendance.webapp;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.attendance.model.AnnualLeave;
import com.systop.scos.attendance.service.AnnualLeaveManager;

/**
 * 年假管理Action
 * @author SongBaoJie
 *
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AnnualLeaveAction extends DefaultCrudAction<AnnualLeave, AnnualLeaveManager> {

	// 部门ID
	private String deptId;

	private Date startDate;
	
	private Map<String, Object> result;
	
	/**
	 * 显示考勤信息
	 */
	public String index() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from AnnualLeave l where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		sql.append("order by l.user.dept.serialNo");
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	public String generateAnnualLeave(){
		return SUCCESS;
	}
	
	/**
	 * 考勤编辑
	 */
	public String edit() {
		return INPUT;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	
	public Map<String, Object> getResult() {
		return result;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
}
