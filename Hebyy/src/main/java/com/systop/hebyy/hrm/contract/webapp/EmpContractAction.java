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

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hrm.contract.model.EmpContract;
import com.systop.hebyy.hrm.contract.service.EmpContractManager;
import com.systop.hebyy.hrm.employee.model.Employee;
import com.systop.hebyy.hrm.employee.service.EmployeeManager;

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
	private EmployeeManager employeeManager;
	
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
		Employee e = getManager().getDao().get(Employee.class, getModel().getEmployee().getId());
		if(e != null){
			getModel().setEmployee(e);
		}
		return INPUT;
	} 
	
	/**
	 * 保存员工合同信息
	 */
	@Override
	public String save() {
		if(getModel() != null){
			getManager().save(getModel(), getModel().getEmployee().getId());
			getModel().getEmployee().setLastContractBegin(getModel().getStartTime());
			getModel().getEmployee().setLastContractEnd(getModel().getEndTime());
			getModel().setStartTime(startDate);
			getModel().setEndTime(endDate);
			employeeManager.update(getModel().getEmployee());
		}
		return SUCCESS;
	}
	
	/**
	 * 显示用户列表
	 * */
	@SuppressWarnings("unchecked")
	public String showUsers(){
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer("from Employee e where 1=1 ");
		if (getModel() != null && getModel().getEmployee() !=null && StringUtils.isNotBlank(getModel().getEmployee().getName())) {// 根据名称查询
			hql.append(" and e.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getEmployee().getName()));
		}
		if (getModel() != null && getModel().getEmployee() !=null &&  getModel().getEmployee().getDept() !=null && StringUtils.isNotBlank(getModel().getEmployee().getDept().getName())) {// 根据部门名称
			hql.append(" and e.dept.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getEmployee().getDept().getName()));
		}
		hql.append(" order by e.id desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
        List<Employee> list = page.getData();
        for (Employee e : list) {
            EmpContract contract = getManager().currentContract(e.getId());
            if(contract==null){
                //在员工信息里面输入的清除掉
                e.setLastContractBegin(null);
                e.setLastContractEnd(null);
            }
            else{
                //以合同信息的为准
                e.setLastContractBegin(contract.getStartTime());
                e.setLastContractEnd(contract.getEndTime());
            }
        }
        return "showusers";
	}
	
	//员工合同信息列表
	public String userContractView(){
		if(getModel()!= null && getModel().getEmployee() != null && getModel().getEmployee().getId() != null){
			page = PageUtil.getPage(getPageNo(), getPageSize());
			getManager().getUserContractByUid(page, getModel().getEmployee().getId());
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
