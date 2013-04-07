package com.systop.zjimis.flow.webapp;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.zjimis.flow.model.Flow;
import com.systop.zjimis.flow.service.FlowManager;

/**
 * 流程管理Action
 * 
 * @author Nice,SongBaojie
 * 
 */

@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings({ "serial" })
public class FlowAction extends DefaultCrudAction<Flow, FlowManager> {

	private Map<String, Object> result;

	/**
	 * 异步请求创建flow
	 */
	public String saveFlow() {
		User user = getLoginUser();

		String field = getRequest().getParameter("field");
		String fieldId = getRequest().getParameter("fieldId");
		String auditor = getRequest().getParameter("auditorId");

		getManager().saveFlowByField(field, fieldId, auditor, user);

		result = new HashMap<String, Object>();
		result.put("success", true);
		// result.put("info", "保存完成");

		return "saveSuccess";
	}

	public Map<String, Object> getResult() {
		return result;
	}
}