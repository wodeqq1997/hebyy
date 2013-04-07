package com.systop.common.modules.security.user.webapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.dept.service.DeptManager;
import com.systop.common.modules.security.user.UserConstants;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.Constants;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.JsonCrudAction;

/**
 * 用于用户选择器
 * 
 * @author Nice
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class UserSelectAction extends JsonCrudAction<User, UserManager> {

	// 查询时用到的部门id
	private Integer deptId;

	// 每次请求checkUser()时候，复选框是否选中
	private boolean selected;

	private static String selectedUserInSession = "selected_users";

	private List<Map<String, String>> selectedUsersMap;

	private Map<String, String> optionMsg;

	@Autowired
	private DeptManager deptManager;

	private String authoritys;
	
	/**
	 * 选择用户列表
	 * 
	 * @return
	 */
	public String index() {
		// 存放查询参数
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer(
				"from User u where u.isSys = ? and u.status = ?");
		args.add(Constants.NO);
		args.add(UserConstants.USER_STATUS_USABLE);
		if (deptId != null && deptId != 0) {// 根据部门ID查询
			hql.append(" and u.dept.id = ?");
			args.add(deptId);
		}
		
		if(StringUtils.isNotBlank(authoritys)){
			hql.append(" and u.position.authority = ?");
			args.add(authoritys);
		}
		
		
		hql.append(" order by u.orderId");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return "index";
	}

	/**
	 * 查看配置了SKYPE帐号的用户
	 * 
	 * @return
	 */
	public String showSkypeUser() {
		// 存放查询参数
		List<Object> args = new ArrayList<Object>();
        //issue 740
		StringBuffer hql = new StringBuffer(
				"from User u where u.isSys = ? and u.status = ?");
		args.add(Constants.NO);
		args.add(UserConstants.USER_STATUS_USABLE);
		if (deptId != null && deptId != 0) {// 根据部门ID查询
			hql.append(" and u.dept.id = ?");
			args.add(deptId);
		}
		
		if (StringUtils.isNotBlank(getModel().getName())){
			hql.append(" and u.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		hql.append(" order by u.orderId");
		items = getManager().query(hql.toString(), args.toArray());
		return "showSkypeUser";
	}

	/**
	 * 选择/取消选择用户
	 * 
	 * @return
	 */
	public String checkUser() {
		List<User> selectedUsers = getSelectedUsersInSession();
		if (selectedUsers == null) {
			selectedUsers = new ArrayList<User>();
		}
		optionMsg = new HashMap<String, String>();
		if (getModel() != null && getModel().getId() != null) {
			if (selected) {
				selectedUsers.add(getModel());
				optionMsg.put("optType", "选择");
				logger.debug("用户被选择：" + getModel());
			} else {
				selectedUsers.remove(getModel());
				optionMsg.put("optType", "取消");
				logger.debug("取消用户选择：" + getModel());
			}
			optionMsg.put("id", getModel().getId().toString());
		}
		getSession().setAttribute(selectedUserInSession, selectedUsers);
		return "checkuser";
	}

	/**
	 * AJAX请求获得session中的已选择用户
	 * 
	 * @return
	 */
	public String selectedUsers() {
		List<User> selectedUsers = getSelectedUsersInSession();
		selectedUsersMap = new ArrayList<Map<String, String>>();
		if (selectedUsers != null) {
			for (User user : selectedUsers) {
				selectedUsersMap.add(convertMap(user));
			}
		}
		return "selected_users";
	}

	private Map<String, String> convertMap(User user) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", user.getId().toString());
		map.put("name", user.getName());
		if (user.getDept() != null && user.getDept().getId() != null) {
			Dept dept = deptManager.get(user.getDept().getId());
			if (dept != null) {
				map.put("deptName", dept.getName());
			}
		}
		return map;
	}

	// session中获得已选择用户
	@SuppressWarnings("unchecked")
	private List<User> getSelectedUsersInSession() {
		return (List<User>) getSession().getAttribute(selectedUserInSession);
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public void setSelected(boolean selected) {
		this.selected = selected;
	}

	public List<Map<String, String>> getSelectedUsersMap() {
		return selectedUsersMap;
	}

	public Map<String, String> getOptionMsg() {
		return optionMsg;
	}

	public String getAuthoritys() {
		return authoritys;
	}

	public void setAuthoritys(String authoritys) {
		this.authoritys = authoritys;
	}
}
