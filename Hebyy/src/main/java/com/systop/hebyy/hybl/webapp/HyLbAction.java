package com.systop.hebyy.hybl.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hybl.model.HyLb;
import com.systop.hebyy.hybl.model.Hyxx;
import com.systop.hebyy.hybl.service.HyLbManager;

/**
 * 会议类别信息
 * 
 * @author wangyaping
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class HyLbAction extends DefaultCrudAction<HyLb, HyLbManager> {
	
	private List<HyLb> items;

	public List<HyLb> getItems() {
		return items;
	}

	/**
	 * 查询
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	public String index(){

		StringBuffer hql = new StringBuffer(
		"from HyLb p ");
		List<Object> args = new ArrayList<Object>();

		
		hql.append(" order by p.id ");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		return "index";// 跳转到第一个页面

	}
	
	/**
	 * 删除的方法
	 * 
	 * @return
	 */
	public String delete() {
		String ids = getRequest().getParameter("ids");
		String[] id = ids.split(",");

		for (String id1 : id) {
			int id2 = Integer.parseInt(id1);
			HyLb hy = getManager().get(id2);
			getManager().remove(hy);// 删除的方法
		}
		addActionMessage("删除成功！");
		return "success";
	}

	/**
	 * 保存的方法
	 * 
	 * @return
	 */
	public String jkjsSave() {
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”
		if (getModel().getId() == null) {
			addActionMessage("添加成功！");// 提示
		} else {
			addActionMessage("更新成功！");
		}
		super.save();

		return "success";
	}
	

}
