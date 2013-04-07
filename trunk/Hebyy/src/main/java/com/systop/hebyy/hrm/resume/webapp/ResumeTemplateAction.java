package com.systop.hebyy.hrm.resume.webapp;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hrm.resume.model.ResumeTemplate;
import com.systop.hebyy.hrm.resume.service.ResumeTemplateManager;

/**
 * 简历模板管理Action
 * @author GaoRuoFan
 *
 */
@SuppressWarnings({ "serial"})
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ResumeTemplateAction extends DefaultCrudAction<ResumeTemplate,ResumeTemplateManager>{

	/**
	 * 简历模板管理
	 * */
	public String index(){
		String sql = "from ResumeTemplate ";
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql);
		restorePageData(page);
		return INDEX;
	}
}
