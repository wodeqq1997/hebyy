package com.systop.hebyy.rule.webapp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.rule.model.Rule;
import com.systop.hebyy.rule.model.RuleType;
import com.systop.hebyy.rule.service.RuleManager;
import com.systop.hebyy.rule.service.RuleTypeManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class RuleTypeAction extends DefaultCrudAction<RuleType, RuleTypeManager> {

	// 首页显示规章条数
	private Integer viewCount;

	private List<RuleType> ruleTypes;

	@Autowired
	RuleManager ruleManager;

	/**
	 * 条件查询
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String queryxx() {

		StringBuffer hql = new StringBuffer("from RuleType p where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		hql.append(" order by p.id ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		return "zc_index";// 跳转到第一个页面

	}

	/**
	 * 查询全部，重定向，不带值
	 * 
	 * @return
	 */
	public String getAllKd() {
		return "zc_success";
	}

	/**
	 * 删除的方法
	 * 
	 * @return
	 */
	@Override
	public String remove() {
		String ids = getRequest().getParameter("ids");
		String[] id = ids.split(",");
		String mes="";
		for (String id1 : id) {
			int id2 = Integer.parseInt(id1);
			List<Rule> jds = ruleManager.querykc(id2);
			if (jds.size() == 0) {
				RuleType ruleType = getManager().getRuleTypeByid(id2);
				getManager().remove(ruleType);// 删除的方法
				mes="删除成功！";
			} else {
				// for (Rule jd : jds) {
				// ruleManager.remove(jd);
				// }
				mes="该类别已经使用，不能删除！";
				
			}

		}
		addActionMessage(mes);
		return "zc_success";
	}

	/**
	 * 保存的方法
	 * 
	 * @return
	 */

	public String zcsave() {
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”
		if (getModel().getId() == null) {
		
			addActionMessage("添加成功！");// 提示
		} else {
			addActionMessage("更新成功！");
		}
		super.save();
		return "zc_success";
	}

	/**
	 * 页面异步请求，获得最新的通知公告
	 * 
	 * @return
	 */
	public String indexRuleTypes() {

		if (viewCount != null) {
			ruleTypes = getManager().queryAll();
		}
		return "indexRuleTypes";
	}

	public List<RuleType> getRuleTypes() {
		return ruleTypes;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	
}
