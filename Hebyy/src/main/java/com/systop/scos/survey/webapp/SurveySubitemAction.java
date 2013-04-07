package com.systop.scos.survey.webapp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.survey.model.Survey;
import com.systop.scos.survey.model.SurveySubitem;
import com.systop.scos.survey.service.SurveySubitemManager;
import com.systop.scos.survey.service.VoterManager;

/**
 * 调查项目选项管理
 * 
 * @author LinJie
 */
@SuppressWarnings("serial")
@Controller
@Scope(value = BeanDefinition.SCOPE_PROTOTYPE)
public class SurveySubitemAction extends DefaultCrudAction<SurveySubitem, SurveySubitemManager> {
	
	//被选中调查项的选项
	private String selectedSubitemId;
	
	//问卷调查Id
	private Integer surveyId;
	
	@Autowired
	private VoterManager voterManager;
	
	/**
	 * 查询调查项目选项
	 */
	public String index(){
		page = PageUtil.getPage(getPageNo(), getPageSize());
		List<Object> args = new ArrayList<Object>();
		String hql = "from SurveySubitem s where s.surveyItem.id = ?";
		args.add(getModel().getSurveyItem().getId());
		page = getManager().pageQuery(page, hql, args.toArray());
		restorePageData(page);
		return INDEX;
		}
	
	/**
	 * 创建和编辑调查项目选项
	 */
	public String save() {
		getManager().save(getModel());
		return SUCCESS;
	}
	
	/**
	 * 选项投票统计并保存
	 * 
	 * @return 
	 */
	public String vote() {
		String[] val = selectedSubitemId.split(",");
		voterManager.save(getSurvey(surveyId), getLoginUser());
		int count = voterManager.count(surveyId);
		for(int i = 0;i<val.length;i++){
			if(val[i] != null){
				Integer id=Integer.parseInt(val[i]);
				getManager().save(id , count);
			}
		}
		return "vote";
	}

	/**
	 * 删除选项
	 */
	public String remove(){
		getManager().remove(getModel());
		return SUCCESS;
	}
	
	/**
	 * 获取Survey的实体类
	 * @param id
	 * @return Survey
	 */
	public Survey getSurvey(Integer id){
		return getManager().getDao().get(Survey.class, id);
	}

	public String getSelectedSubitemId() {
		return selectedSubitemId;
	}

	public void setSelectedSubitemId(String selectedSubitemId) {
		this.selectedSubitemId = selectedSubitemId;
	}

	public Integer getSurveyId() {
		return surveyId;
	}

	public void setSurveyId(Integer surveyId) {
		this.surveyId = surveyId;
	}
	
}
