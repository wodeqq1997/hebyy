package com.systop.hebyy.hrm.contract.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.Constants;
import com.systop.core.dao.support.Page;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hrm.contract.model.EmpContract;
import com.systop.hebyy.hrm.contract.service.EmpContractManager;

/**
 * 员工合同管理Action
 * @author GaoRuoFan
 *
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class EmpContractAction extends DefaultCrudAction<EmpContract, EmpContractManager>{
	
	@Autowired
	private UserManager userManager;
	
	//开始日期
	private Date startDate;
	
	//结束日期
	private Date endDate;
	
	/**
	 * 编辑，修改
	 * 
	 * */
	@Override
	public String edit(){
		User u = getManager().getDao().get(User.class, getModel().getUser().getId());
		if(u != null){
			getModel().setUser(u);
		}
		return INPUT;
	} 
	
	/**
	 * 保存员工合同信息
	 */
	@Override
	public String save() {
		if(getModel() != null){
			getManager().save(getModel(), getModel().getUser().getId());
			getModel().getUser().setLastContractBegin(getModel().getStartTime());
			getModel().getUser().setLastContractEnd(getModel().getEndTime());
			getModel().setStartTime(startDate);
			getModel().setEndTime(endDate);
			userManager.update(getModel().getUser());
		}
		return SUCCESS;
	}
	
	/**
	 * 显示用户列表
	 * */
	@SuppressWarnings("unchecked")
	public String showUsers(){
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer("from User u where  u.isSys = ?");
		args.add(Constants.NO);
		if (getModel() != null && getModel().getUser() !=null && StringUtils.isNotBlank(getModel().getUser().getName())) {// 根据名称查询
			hql.append(" and u.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getUser().getName()));
		}
		if (getModel() != null && getModel().getUser() !=null &&  getModel().getUser().getDept() !=null && StringUtils.isNotBlank(getModel().getUser().getDept().getName())) {// 根据部门名称
			hql.append(" and u.dept.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getUser().getDept().getName()));
		}
		hql.append(" order by u.id desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
        List<User> list = page.getData();
        for (User u : list) {
            EmpContract contract = getManager().currentContract(u.getId());
            if(contract==null){
                //在员工信息里面输入的清除掉
                u.setLastContractBegin(null);
                u.setLastContractEnd(null);
            }
            else{
                //以合同信息的为准
                u.setLastContractBegin(contract.getStartTime());
                u.setLastContractEnd(contract.getEndTime());
            }
        }
        return "showusers";
	}
	
	//员工合同信息列表
	public String userContractView(){
		if(getModel()!= null && getModel().getUser() != null && getModel().getUser().getId() != null){
			page = PageUtil.getPage(getPageNo(), getPageSize());
			getManager().getUserContractByUid(page, getModel().getUser().getId());
			restorePageData(page);
		}
		return "usercontractview";
	}
	
	/**
	 * 员工合同信息查看
	 * */
	public String contractView(){
		return "contractview";
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

}
