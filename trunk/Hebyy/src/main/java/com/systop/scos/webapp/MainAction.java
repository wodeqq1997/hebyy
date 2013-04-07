package com.systop.scos.webapp;

import com.systop.common.modules.security.user.UserUtil;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.webapp.struts2.action.BaseAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.Map;

/**
 * 后台首页显示各个功能模块列表信息
 * 
 * @author ShangHua
 */
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@Controller
@SuppressWarnings("serial")
public class MainAction extends BaseAction {

	@Autowired
	private UserManager userManager;

	private User loginUser;
	private Map<Integer, String>  archiveMap;

	public String main() {
		loginUser = UserUtil.getLoginUser(getRequest());
		loginUser = userManager.get(loginUser.getId());
		if (redirectMobile())
			return "mobile-main";
		return "main";
	}

	public String nodes() {
		loginUser = UserUtil.getLoginUser(getRequest());
		loginUser = userManager.get(loginUser.getId());
		return "nodes";
	}

	public User getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(User loginUser) {
		this.loginUser = loginUser;
	}

	public Map<Integer, String> getArchiveMap() {
		return archiveMap;
	}
}
