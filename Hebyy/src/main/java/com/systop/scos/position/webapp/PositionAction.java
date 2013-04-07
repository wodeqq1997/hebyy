package com.systop.scos.position.webapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.position.model.Position;
import com.systop.scos.position.service.PositionManager;

/**
 * 职位
 *@author LinJie
 *@version 1.0
 *@create 2012-5-25 下午4:24:03
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class PositionAction extends DefaultCrudAction<Position, PositionManager> {
	
	//部门Id
	private Integer deptId;
	
	//用户名称
	private String userName;
	
	//部门对应的职位列表
	private Map<Integer, String> positionMap ;
	/*
	 * (non-Javadoc)
	 * @see com.systop.core.webapp.struts2.action.AbstractCrudAction#index()
	 */
	public String index(){
		
		return INDEX;
	}

	/*
	 * 职位显示
	 */
	public String showPosition(){
		StringBuffer hql = new StringBuffer("from Position p where 1=1");
		List<Object> args = new ArrayList<Object>();
		if(deptId != null){
			if(deptId != 0){
				hql.append(" and p.dept.id = ?");
				args.add(deptId);
			}
		}
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(),args.toArray());
		restorePageData(page);
		return "showPosition";
	}
	
	/**
	 * 删除职位
	 */
	public String remove(){
		getManager().remove(getModel());
		return "remove";
	}
	
	/**
	 * 保存
	 */
	public String save(){
		getManager().getDao().getHibernateTemplate().clear();
		super.save();
		return "save";
	}
	
	public String queryPosition(){
		positionMap = new HashMap<Integer, String>();
		positionMap = getManager().queryPosition(deptId);
		return "queryPosition";
	}

	/**
	 * 用户职责
	 * @return
	 */
	public String viewUserPosition(){
		userName = getLoginUser().getName();
		return "viewUserPosition";
	}
	
	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public Map<Integer, String> getPositionMap() {
		return positionMap;
	}

	public void setPositionMap(Map<Integer, String> positionMap) {
		this.positionMap = positionMap;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
