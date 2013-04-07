package com.systop.common.modules.dept.webapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.interceptor.validation.SkipValidation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.dept.DeptConstants;
import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.dept.service.DeptManager;
import com.systop.common.modules.dept.service.DeptSerialNoManager;
import com.systop.core.ApplicationException;
import com.systop.core.util.RequestUtil;
import com.systop.core.webapp.struts2.action.ExtJsCrudAction;

/**
 * 部门管理Action
 * 
 * @author Sam Lee, NiceLunch
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class DeptAction extends ExtJsCrudAction<Dept, DeptManager> {

	// 当前上级部门ID
	private Integer parentId;

	// 部门序列号管理器
	@Autowired
	private DeptSerialNoManager serialNoManager;

	// 用于查询的部门名称
	private String deptName = StringUtils.EMPTY;

	// 封装属性部门数据
	private List<Map<String, Object>> depts = null;

	/**
	 * 部门查询。根据指定的上级部门id(通过{@link #parentId}属性)，查询下级部门。 如果{@link #parentId}
	 * 为null,则查询顶级部门（没有上级部门的）
	 */
	@Override
	@SkipValidation
	public String index() {
		return INDEX;
	}

	/**
	 * Build a tree as json format.
	 */
	public String deptTree() {
		if (RequestUtil.isJsonRequest(getRequest())) {
			List<Dept> tops = getManager().getDeptsByParentId(null);
			depts = new ArrayList<Map<String, Object>>();
			for (Dept dept : tops) {
				Map<String, Object> top = toMap(dept);
				top = buildTreeByParent(top, true);
				depts.add(top);
			}
			return JSON;
		}
		return INDEX;
	}

	/**
	 * 返回部门树形列表，每一个部门用一个Map表示，子部门用Map的'childNodes'key挂接一个List
	 * 
	 * @param parent
	 * @param nested
	 *            是否递归
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> buildTreeByParent(Map<String, Object> parent,
			boolean nested) {
		if (parent != null) {
			List<Dept> subs = getManager().getDeptsByParentId((Integer) parent.get("id"));
			List childs = new ArrayList();
			for (Dept dept : subs) {
				Map<String, Object> child = toMap(dept);
				if (nested) { // 递归查询子部门
					child = buildTreeByParent(child, nested);
				}
				childs.add(child);
			}
			if (!childs.isEmpty()) {
				parent.put("children", childs);
				parent.put("leaf", false);
			} else {
				parent.put("leaf", true);
			}
		}
		return parent;
	}

	// 封装到Map中
	private Map<String, Object> toMap(Dept dept) {
		Map<String, Object> map = null;
		if (dept != null) {
			map = new HashMap<String, Object>();
			map.put("id", dept.getId());
			map.put("text", dept.getName());
			map.put("descn", dept.getDescn());
		}
		return map;
	}

	/**
	 * 得到当前部门（通过{@link #parentId}指定）的上级部门.
	 */
	public Dept getParent() {
		if (parentId == null || parentId.equals(DeptConstants.TOP_DEPT_ID)) {
			Dept dept = new Dept();
			dept.setName(DeptConstants.TOP_DEPT_NAME);
			return dept;
		}

		return getManager().get(parentId);
	}

	/**
	 * 覆盖父类，处理父部门ID为{@link DeptConstants#TOP_DEPT_ID}的情况。
	 */
	@Override
	public String save() {
		try {
			if (parentId != null) {
				getModel().setParentDept(getManager().get(parentId));
			}
			
			
			getManager().save(getModel());
				return SUCCESS;
		} catch (ApplicationException e) {
			addActionError(e.getMessage());
			return INPUT;
		}
	}

	/**
	 * 处理parentDept为null的情况
	 */
	@Override
	@SkipValidation
	public String edit() {
		if (getModel().getId() != null) {
			setModel(getManager().get(getModel().getId()));
			if (getModel().getParentDept() == null) {
				Dept dept = new Dept(); // 构建一个父部门
				dept.setId(DeptConstants.TOP_DEPT_ID);
				dept.setName(DeptConstants.TOP_DEPT_NAME);
				getModel().setParentDept(dept);
				getManager().getDao().evict(getModel()); // 将dept脱离hibernate
				logger.debug("编辑第一级部门");
			}
		}
		
		return INPUT;
	}

	/**
	 * 重置所有部门编号
	 */
	@SkipValidation
	public String updateSerialNo() {
		serialNoManager.updateAllSerialNo();
		return SUCCESS;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public List<Map<String, Object>> getDepts() {
		return depts;
	}

	public void setDepts(List<Map<String, Object>> depts) {
		this.depts = depts;
	}
}
