package com.systop.scos.survey.webapp;

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
import com.systop.scos.survey.SurveyConstants;
import com.systop.scos.survey.model.Survey;
import com.systop.scos.survey.service.SurveyManager;
import com.systop.scos.survey.service.VoterManager;

/**
 * 问卷调查主题管理
 * 
 * @author LinJie
 */

@SuppressWarnings("serial")
@Controller
@Scope(value = BeanDefinition.SCOPE_PROTOTYPE)
public class SurveyAction extends DefaultCrudAction<Survey, SurveyManager> {

	@Autowired
	private VoterManager voterManager;

	// 是否参加过问卷调查
	private String isJoin;

	// 该问卷调查是否过期
	private String isExpiration;

	/**
	 * 查询问卷调查的主题
	 */
	public String index() {
		StringBuffer hql = new StringBuffer("from Survey s where 1 = 1");
		List<Object> args = new ArrayList<Object>();
		if (StringUtils.isNotBlank(getModel().getReleaseStatus())) {
			hql.append( " and s.releaseStatus = ?");
			args.add(getModel().getReleaseStatus());
		}
		hql.append(" order by s.id desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 查看问卷调查的主题
	 */
	public String view() {
		String hql = "from Survey s where s.releaseStatus = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(SurveyConstants.SURVEY_AVAILABLE);
		if (StringUtils.isNotBlank(getModel().getTitle())) {
			hql = hql + " and s.title like ?";
			args.add(MatchMode.ANYWHERE.toMatchString(getModel()
					.getTitle()));
		}
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql, args.toArray());
		restorePageData(page);
		return VIEW;
	}

	/**
	 * 创建和编辑问卷调查的主题
	 */
	public String save() {
		if (getModel().getId() == null) {
			getModel().setCreateDate(new Date());
			getModel().setReleaseStatus(SurveyConstants.SURVEY_UNPOSTED);
			getManager().save(getModel());
		} else {
			getManager().save(getModel());
		}
		return SUCCESS;
	}

	/**
	 *设置为过期问卷调查主题
	 */
	public String rollback() {
		getModel().setEndDate(null);
		getModel().setReleaseStatus(SurveyConstants.SURVEY_DISABLED);
		getManager().save(getModel());
		return SUCCESS;
	}

	/**
	 * 发布问卷调查主题
	 */
	public String release() {
		getModel().setReleaseStatus(SurveyConstants.SURVEY_AVAILABLE);
		getManager().save(getModel());
		return SUCCESS;
	}

	/**
	 * 参加问卷调查
	 */
	public String joinSurvey() {
		isJoin = voterManager
				.isJoin(getModel().getId(), getLoginUser().getId());
		if (SurveyConstants.OVERSURVEY.equals(isJoin)) {
			this.addActionError("您已参加过，请不要重复参加");
			return "error";
		} else {
			return "joinSurvey";
		}
	}

	/**
	 * 跳转到添加结束日期页面
	 */
	public String releasePage() {
		return "release";
	}

	/**
	 * 查看投票结构
	 */
	public String showResult() {
		if (isExpiration != null
				&& SurveyConstants.SURVEY_DISABLED.equals(isExpiration)) {
			return "showResult";
		} else {
			isJoin = voterManager.isJoin(getModel().getId(), getLoginUser()
					.getId());
			if (SurveyConstants.UNFINISHED.equals(isJoin)) {
				this.addActionError("请先参加问卷调查");
				return "error";
			} else {
				return "showResult";
			}
		}
	}

	public String getIsJoin() {
		return isJoin;
	}

	public void setIsJoin(String isJoin) {
		this.isJoin = isJoin;
	}

	public String getIsExpiration() {
		return isExpiration;
	}

	public void setIsExpiration(String isExpiration) {
		this.isExpiration = isExpiration;
	}

}
