package com.systop.scos.survey.webapp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.survey.model.SurveyItem;
import com.systop.scos.survey.service.SurveyItemManager;

/**
 * 调查项目管理
 * 
 * @author LinJie
 */
@SuppressWarnings("serial")
@Controller
@Scope(value = BeanDefinition.SCOPE_PROTOTYPE)
public class SurveyItemAction extends DefaultCrudAction<SurveyItem, SurveyItemManager> {
	
	/**
	 * 查询调查项目
	 */
	public String index(){
		page = PageUtil.getPage(getPageNo(), getPageSize());
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer(
				"from SurveyItem s where s.survey.id = ?");
		args.add(getModel().getSurvey().getId());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
		}
	
	/**
	 * 创建和编辑调查项目
	 * 
	 * @return 创建问卷调查项目结果页面
	 */
	public String save() {
		getManager().save(getModel());
		return SUCCESS;
	}
	
	/**
	 * 删除问卷调查项目
	 * 
	 * @return 问卷调查项目删除结果页面
	 */
	public String delete(){
		return super.remove();
	}
	
	/**
	 * 跳转到添加选项页面
	 * @return
	 */
	public String edit(){
		return super.edit();
	}
	
}
