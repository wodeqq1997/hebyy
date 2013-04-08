package com.systop.hebyy.hrm.resume.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hrm.resume.model.Resume;
import com.systop.hebyy.hrm.resume.model.ResumeTemplate;
import com.systop.hebyy.hrm.resume.service.ResumeManager;
import com.systop.hebyy.hrm.resume.service.ResumeTemplateManager;


/**
 * 简历管理Action
 * @author GaoRuoFan
 *
 */
@SuppressWarnings({ "serial"})
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ResumeAction extends DefaultCrudAction<Resume,ResumeManager>{

	@Autowired
	private  ResumeTemplateManager resumeTemplateManager;
	
	/**
	 * 简历检索管理
	 * */
	public String index(){
		StringBuffer sql = new StringBuffer("from Resume r where 1=1");
		List<Object> args = new ArrayList<Object>();
		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append(" and r.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		if (StringUtils.isNotBlank(getModel().getDegree())) {// 学位
			sql.append(" and r.degree like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getDegree()));
		}
		if (StringUtils.isNotBlank(getModel().getMajor())) {// 专业
			sql.append(" and r.major like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getMajor()));
		}
		if (StringUtils.isNotBlank(getModel().getGraduatCollege())) {// 毕业院校
			sql.append(" and r.graduatCollege like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getGraduatCollege()));
		}
		if (StringUtils.isNotBlank(getModel().getGraduationTime())) {// 现居住地
			sql.append(" and r.graduationTime = ?");
			args.add(getModel().getGraduationTime());
		}
		sql.append(" order by r.createTime desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	/**
	 * 添加、编辑请求
	 */
	@Override
	public String edit(){
		ResumeTemplate t = resumeTemplateManager.getResumeTemplate();
			if (t != null  && getModel().getId() == null){
				getModel().setOtherExp(t.getOtherExpTemp());
			}
		return INPUT;
	}
}
