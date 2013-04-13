package com.systop.hebyy.rule.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.dao.support.Page;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.PageUtil;
import com.systop.hebyy.rule.model.Rule;
import com.systop.hebyy.rule.model.RuleType;

/**
 * 规章制度业务类
 * 
 * @author WangYaping
 * 
 */
@Service
public class RuleManager extends BaseGenericsManager<Rule> {

	/**
	 * 通过id获得对象的值
	 */

	@Transactional
	public Rule getRuleByid(int id) {

		String hql = "from Rule p where p.id = ? ";
		Rule rule = findObject(hql, id);
		return rule;

	}

	/**
	 * 通过类别目录id拿到一组对象
	 * 
	 * @param id
	 * @return
	 */
	public List<Rule> querykc(int id) {

		StringBuffer hql = new StringBuffer("from Rule p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (id != 0) {
			hql.append("and p.ruleType.id = ? ");
			args.add(id);
		}
		hql.append("order by p.id ");
		return query(hql.toString(), args.toArray());
	}

	/**
	 * 保存规章制度并关联指定的目录
	 * 
	 * @param Rule
	 * @param zcId
	 */
	@Transactional
	public void save(Rule rule, Integer zcId) {
		if (zcId != null) {
			rule.setRuleType(getDao().get(RuleType.class, zcId));
		}

		save(rule);
	}

	/**
	 * 查询全部的规章制度
	 * @param count
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Rule> getNotices(Integer count) {
		StringBuffer sql = new StringBuffer("from Rule p where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		sql.append("order by p.id ");
		Page page = PageUtil.getPage(1, count);
		page = pageQuery(page, sql.toString(), args.toArray());
		return page.getData();
	}

}
