package com.systop.hebyy.hybl.webapp;

import java.text.ParseException;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hybl.model.HyLb;
import com.systop.hebyy.hybl.model.Hyxx;
import com.systop.hebyy.hybl.service.HyLbManager;
import com.systop.hebyy.hybl.service.HyxxManager;

/**
 * 会议信息
 * 
 * @author wangyaping
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class HyxxAction extends DefaultCrudAction<Hyxx, HyxxManager> {

	private List<Hyxx> items;

	public List<Hyxx> getItems() {
		return items;
	}

	private List<String> names = new ArrayList<String>();

	public List<String> getNames() {
		return names;
	}

	@Autowired
	HyLbManager hyLbManager;

	private List<HyLb> hylbItems;

	public List<HyLb> getHylbItems() {
		return hylbItems;
	}

	/**
	 * 条件查询
	 * 
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	public String queryxx() throws ParseException {

		// 下拉列表数据源
		hylbItems = hyLbManager.queryAll();

		for (HyLb kd : hylbItems) {
			String name = kd.getHyLbMc();
			names.add(name);
		}
		getRequest().setAttribute("names", names); // request传值
		// 获取输入的条件
		String hymc = getModel().getHyMc();
		String hyType = getModel().getHytype(); // 会议类别
		Date startTime = getModel().getStartTime();
		Date endTime = getModel().getEndTime();

		StringBuffer hql = new StringBuffer("from Hyxx p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (StringUtils.isNotBlank(hymc)) {
			hql.append(" and p.hyMc like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(hymc));
		}

		if (StringUtils.isNotBlank(hyType)) {
			HyLb hyLb = hyLbManager.getHyLbByName(hyType);

			hql.append(" and p.typeId = ?  ");
			args.add(hyLb.getId() + "");
		}

		if (startTime != null) {
			hql.append(" and p.hyTime >= ?  ");
			args.add(DateUtil.firstSecondOfDate(startTime));
		}

		if (endTime != null) {
			hql.append(" and p.hyTime <= ?  ");
			args.add(DateUtil.lastSecondOfDate(endTime));
		}

		hql.append(" order by p.hyTime ");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		for (Hyxx hyxx : items) {

			String id = hyxx.getTypeId();
			if (StringUtils.isNotBlank(id)) {
				HyLb hyLb = hyLbManager.getHyLbByid(Integer.parseInt(id));
				hyxx.setHytype(hyLb.getHyLbMc());
			}

		}

		return "index";// 跳转到第一个页面

	}

	/**
	 * 条件查询（用于普通用户的查询）
	 * 
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	public String queryxx1() throws ParseException {

		// 下拉列表数据源
		hylbItems = hyLbManager.queryAll();

		for (HyLb kd : hylbItems) {
			String name = kd.getHyLbMc();
			names.add(name);
		}
		getRequest().setAttribute("names", names); // request传值

		// 获取输入的条件
		String hymc = getModel().getHyMc();
		String hyType = getModel().getHytype(); // 会议类别
		Date startTime = getModel().getStartTime();
		Date endTime = getModel().getEndTime();

		StringBuffer hql = new StringBuffer(

		"from Hyxx p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (hymc != null && !hymc.equals("")) {
			hql.append(" and p.hyMc like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(hymc));
		}

		if (StringUtils.isNotBlank(hyType)) {
			HyLb hyLb = hyLbManager.getHyLbByName(hyType);

			hql.append(" and p.typeId = ?  ");
			args.add(hyLb.getId() + "");
		}

		if (startTime != null) {
			hql.append(" and p.hyTime >= ?  ");
			args.add(DateUtil.firstSecondOfDate(startTime));

		}

		if (endTime != null) {
			hql.append(" and p.hyTime <= ?  ");
			args.add(DateUtil.lastSecondOfDate(endTime));
		}

		hql.append(" order by p.hyTime ");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		for (Hyxx hyxx : items) {
			String id = hyxx.getTypeId();
			if (StringUtils.isNotBlank(id)) {
				HyLb hyLb = hyLbManager.getHyLbByid(Integer.parseInt(id));
				hyxx.setHytype(hyLb.getHyLbMc());
			}

		}
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
	 * 查询全部，重定向，不带值
	 * 
	 * @return
	 */
	public String toAll1() {
		return "success1";
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
			Hyxx hy = getManager().getHyxxByid(id2);
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
		HyLb hylb = hyLbManager.getHyLbByName(getModel().getHytype());
		getModel().setTypeId(hylb.getId() + "");
		super.save();

		return "success";
	}

	/**
	 * 跳转到编辑页面
	 */
	@Transactional
	public String toEdit() {

		hylbItems = hyLbManager.queryAll();

		for (HyLb kd : hylbItems) {
			String name = kd.getHyLbMc();
			names.add(name);
		}
		int zx = Integer.parseInt(getRequest().getParameter("zx"));
		if (zx == 1) {// 更新
			String typeid = getModel().getTypeId();
			HyLb hyLb = hyLbManager.getHyLbByid(Integer.parseInt(typeid));// 拿到目录的名称
			getModel().setHytype(hyLb.getHyLbMc());

		}
		getRequest().setAttribute("names", names); // request传值
		return "input";
	}

	/**
	 * 跳转到查看详细页面
	 */
	@Transactional
	public String toView() {
		String typeid = getModel().getTypeId();
		HyLb hyLb = hyLbManager.getHyLbByid(Integer.parseInt(typeid));// 拿到目录的名称
		getModel().setHytype(hyLb.getHyLbMc());
		return "view";
	}

}
