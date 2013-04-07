package com.systop.scos.survey.webapp;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.survey.model.Voter;
import com.systop.scos.survey.service.VoterManager;

/**
 * 问卷调查参与人管理
 * 
 * @author LinJie
 */
@SuppressWarnings("serial")
@Controller
@Scope(value = BeanDefinition.SCOPE_PROTOTYPE)
public class VoterAction extends DefaultCrudAction<Voter, VoterManager> {
	
	// 异步请求返回值
	private Map<String, Object> result;
	
	/**
	 * 保存问卷调查人
	 */
	public String save(){
		result = new HashMap<String, Object>();
		getModel().setUser(getLoginUser());
		List<Voter> list = getManager().query(
				"from Voter v where v.user.id = ? and v.survey.id = ?" 
				,getLoginUser().getId(),getModel().getSurvey().getId());
		if(list.size() != 0){
			result.put("success",false);
		}else{
			result.put("success",true);
			getManager().save(getModel());
		}
		return "save";
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}
	
}
