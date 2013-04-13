package com.systop.hebyy.rule.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
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

/**
 * 章程目录
 * 
 * @author WangYaping
 * 
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings("serial")
public class RuleAction extends DefaultCrudAction<Rule, RuleManager> {

	// 首页显示规章条数
	private Integer viewCount;

	// 规章制度集合
	private List<Rule> rules;

	// 类别名称
	private List<String> names;

	// 类别名称
	private List<RuleType> ruleTypeList;

	// 类别名称
	private String zcmc;

	@Autowired
	RuleTypeManager ruleTypeManager;

	/**
	 * 条件查询
	 * 
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	public String queryxx() throws ParseException {
		
		String zdContent = getModel().getWjh(); //文件号
		StringBuffer hql = new StringBuffer("from Rule p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		// 按照文件号模糊查询
		if (StringUtils.isNotBlank(zdContent)) {
			hql.append("and p.wjh like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(zdContent));
		}
		// 章程名称
		if (getModel().getRuleType()!=null&&getModel().getRuleType().getId()!=null) {
			hql.append("and p.ruleType.id = ? ");
			args.add(getModel().getRuleType().getId());
		}
		hql.append("order by p.id ");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		return "index";// 跳转到第一个页面

	}

	/**
	 * 条件查询(用于桌面查询)
	 * 
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	public String queryxx3() {

		String id = getRequest().getParameter("id");
		StringBuffer hql = new StringBuffer("from Rule p where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		hql.append("and p.ruleType.id = ? ");
		args.add(Integer.parseInt(id));
		hql.append("order by p.id ");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		return "index1";// 跳转到第一个页面

	}

	/**
	 * 查询全部，重定向，不带值
	 * 
	 * @return
	 */
	public String toAll() {
		return "success";
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
		for (String id1 : id) {
			int id2 = Integer.parseInt(id1);
			if (id2 != 0) {
				Rule hy = getManager().getRuleByid(id2);
				getManager().remove(hy);// 删除的方法
			}
		}
		addActionMessage("删除成功！");
		return "success";
	}

	/**
	 * 保存的方法
	 * 
	 * @return
	 */
	@Override
	public String save() {
		
		// getModel().setRuleType(ruleType);
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”
		if (getModel().getId() == null || getModel().getId() == 0) {
			
			addActionMessage("添加成功！");// 提示
			getManager().getDao().getHibernateTemplate().clear();
			getManager().save(getModel(),getModel().getRuleType().getId());

		} else {
			addActionMessage("更新成功！");
			getManager().getDao().getHibernateTemplate().clear();
			getManager().save(getModel(), getModel().getRuleType().getId());
		}

		return "success";
	}

	
	/**
	 * 页面异步请求，获得最新的通知公告
	 * 
	 * @return
	 */
	public String indexGzzds() {
		if (viewCount != null) {
			rules = getManager().getNotices(viewCount);
			System.out.println(rules.toArray().toString());
		}
		return "indexGzzds";
	}

	/**
	 * 获得类型下拉列表数据源
	 * @return
	 */
	public Map<Integer, String> getTypeMap() {
		return ruleTypeManager.getTypeMap();
	}

	
	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	
	public List<Rule> getRules() {
		return rules;
	}

	public List<String> getNames() {
		return names;
	}

	public List<RuleType> getZcxxList() {
		return ruleTypeList;
	}

	public String getZcmc() {
		return zcmc;
	}

	public void setZcmc(String zcmc) {
		this.zcmc = zcmc;
	}

}
