package com.systop.hebyy.hrm.job.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hrm.job.model.Job;
import com.systop.hebyy.hrm.job.service.JobManager;

@SuppressWarnings("serial")
@Controller
@Scope(value = BeanDefinition.SCOPE_PROTOTYPE)
public class JobAction extends DefaultCrudAction<Job, JobManager> {

	// 部门ID
	private Integer deptId;

	/**
	 * 职位列表
	 */
	public String index() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer hql = new StringBuffer(
				"from Job j where j.dept.id is not null ");
		List<Object> args = new ArrayList<Object>();
 		if (StringUtils.isNotBlank(getModel().getJobName())) {
			hql.append("and j.jobName like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getJobName()));
		}
 		if (deptId != null){
 			hql.append("and j.dept.id = ? ");
 			args.add(deptId);
 		}
 		hql.append("order by j.orderId desc");
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

}
