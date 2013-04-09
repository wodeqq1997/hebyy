package com.systop.scos.subuser.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.ApplicationException;
import com.systop.core.Constants;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.subuser.model.SubUser;
import com.systop.scos.subuser.service.SubUserManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class SubUserAction extends DefaultCrudAction<SubUser, SubUserManager> {

	private String subUserIds;

	/**
	 * 为当前登录用户添加下属
	 */
	public String save() {
		if (StringUtils.isNotBlank(subUserIds)) {
			String[] ids = subUserIds.split(",");
			String contextPath = getServletContext().getContextPath();
			for (String id : ids) {
				if (StringUtils.isNumeric(id)) {
					try {
						getManager().save(getLoginUser(), Integer.valueOf(id),
								contextPath);
					} catch (ApplicationException e) {
						addActionError(e.getMessage());
						return index();
					}
				}
			}
		}
		return SUCCESS;
	}

	/**
	 * 查看下级用户
	 */
	public String index() {
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer(
				"from SubUser su where su.owner.id = ?");
		args.add(getLoginUser().getId());
		// 判断下属用户
		if (getModel().getUser() != null
				&& StringUtils.isNotBlank(getModel().getUser().getName())) {
			hql.append(" and su.user.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getUser()
					.getName()));
		}
		// 上级部门 下级部门 所属公司一致
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 下属关系确认
	 * 
	 * @return
	 */
	public String subUserConfirm() {
		getManager().save(getModel());
		if (Constants.YES.equals(getModel().getStatus())) {
			addActionMessage("你已经<font color='green'>同意</font>该下属关系");
		} else {
			addActionMessage("你已经<font color='red'>拒绝</font>该下属关系");
		}
		return VIEW;
	}

	public void setSubUserIds(String subUserIds) {
		this.subUserIds = subUserIds;
	}

}
