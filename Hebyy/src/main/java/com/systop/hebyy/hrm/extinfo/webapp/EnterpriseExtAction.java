package com.systop.hebyy.hrm.extinfo.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.Constants;
import com.systop.core.dao.support.Page;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hrm.extinfo.model.EnterpriseExt;
import com.systop.hebyy.hrm.extinfo.service.EnterpriseExtManager;

/**
 * 企业档案管理Action
 * @author GaoRuoFan
 *
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class EnterpriseExtAction  extends DefaultCrudAction<EnterpriseExt, EnterpriseExtManager>{


	/**
	 * 用户列表
	 * */
	public String showUsers(){
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer("from User u where  u.isSys = ? and u.status = ?");
		args.add(Constants.NO);
		args.add(Constants.STATUS_AVAILABLE);
		if (getModel() != null && getModel().getUser() !=null && StringUtils.isNotBlank(getModel().getUser().getName())) {// 根据名称查询
			hql.append(" and u.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getUser().getName()));
		}
		if (getModel() != null && getModel().getUser() !=null &&  getModel().getUser().getDept() !=null && StringUtils.isNotBlank(getModel().getUser().getDept().getName())) {// 根据部门名称
			hql.append(" and u.dept.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getUser().getDept().getName()));
		}
		hql.append(" order by u.dept.serialNo");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return "showusers";
	}
	
	/**
	 * 编辑档案信息
	 */
	@Override
	public String edit() {
		EnterpriseExt enterpriseExt = null;
		if(getModel().getUser() != null 
				&& getModel().getUser().getId() != null){
			enterpriseExt = getManager().getEnterpriseExt(getModel().getUser());
		}
		if(enterpriseExt == null){
			User u = getManager().getDao().get(User.class, getModel().getUser().getId() );			
			if(u != null && u.getId() != null){
				getModel().setUser(u);
			}
		}else{
			setModel(enterpriseExt);
		}
		return INPUT;
	}
	
	/**
	 * 保存档案信息
	 */
	@Override
	public String save() {
		getManager().save(getModel(), getModel().getUser().getId());
		return SUCCESS;
	}

	 /**
	  * 档案列表
	  * */
	public String index(){
		Page page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from EnterpriseExt a where 1=1");
		List<Object> args = new ArrayList<Object>();
		if(getModel()!= null && getModel().getUser() != null && getModel().getUser().getId() != null){
		sql.append(" and a.user.id =  ?");
		args.add(getModel().getUser().getId());
		}
		sql.append(" order by a.createTime desc");
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	


}
