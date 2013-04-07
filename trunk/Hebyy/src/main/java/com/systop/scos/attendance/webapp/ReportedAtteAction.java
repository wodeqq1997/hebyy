package com.systop.scos.attendance.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.attendance.AttendanceConstants;
import com.systop.scos.attendance.model.ReportedAtte;
import com.systop.scos.attendance.service.ReportedAtteManager;

/**
 * 考勤上报
 * 
 * @author LinJie
 * @version 1.0
 * @create 2012-6-11 下午3:52:10
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ReportedAtteAction extends
		DefaultCrudAction<ReportedAtte, ReportedAtteManager> {

	// 用户名
	private String userName;

	// 日期
	private Date date;

	public String index() {
		if (getLoginUser().getDept()!= null) {
			StringBuffer hql = new StringBuffer(
					"from ReportedAtte r where r.dept.id = ?");
			List<Object> args = new ArrayList<Object>();
			args.add(getLoginUser().getDept().getId());
			if (StringUtils.isNotBlank(userName)) {
				hql.append(" and r.user.name like ?");
				args.add(MatchMode.ANYWHERE.toMatchString(userName));
			}
			if (date != null) {
				hql.append(" and r.date = ?");
				args.add(date);
			}
			hql.append("order by r.date desc");

			page = PageUtil.getPage(getMyPageNo(), getPageSize());
			page = getManager().pageQuery(page, hql.toString(), args.toArray());
			restorePageData(page);
		}
		return INDEX;
	}

	/**
	 * 保存信息
	 */
	public String save() {
		String[] id = getRequest().getParameterValues("auditor");
		String[] diseaseDays = getRequest().getParameterValues("diseaseDays");
		String[] leaveDays = getRequest().getParameterValues("leaveDays");
		String[] lateCounts = getRequest().getParameterValues("lateCounts");
		String[] absentCounts = getRequest().getParameterValues("absentCounts");
		String[] marks = getRequest().getParameterValues("marks");
		if (id.length > 1) {
			getManager().save(id, diseaseDays, leaveDays, lateCounts,
					absentCounts, marks, getModel().getDate());
		}
		return SUCCESS;
	}

	/**
	 * 编辑某个员工考勤
	 * 
	 * @return
	 */
	public String editAtte() {
		super.edit();
		return "editAtte";
	}

	/**
	 * 保存某个员工考勤
	 * 
	 * @return
	 */
	public String saveAtte() {
		super.save();
		return "saveAtte";
	}

	/**
	 * 上报
	 * 
	 * @return
	 */
	public String report() {
		getModel().setStatus(AttendanceConstants.STATUS_REPORTED);
		super.save();
		return "report";
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
