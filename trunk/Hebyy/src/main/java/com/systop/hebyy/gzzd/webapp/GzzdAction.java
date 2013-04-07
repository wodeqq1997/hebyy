package com.systop.hebyy.gzzd.webapp;

import java.text.ParseException;
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
import com.systop.hebyy.gzzd.model.Gzzd;
import com.systop.hebyy.gzzd.model.Zcxx;
import com.systop.hebyy.gzzd.service.GzzdManager;
import com.systop.hebyy.gzzd.service.ZcxxManager;

/**
 * 章程目录
 * 
 * @author wangyaping
 * 
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings("serial")
public class GzzdAction extends DefaultCrudAction<Gzzd, GzzdManager> {

	// 首页显示规章条数
	private Integer viewCount;

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	private List<Gzzd> gzzds = new ArrayList<Gzzd>();

	public List<Gzzd> getGzzds() {
		return gzzds;
	}

	public void setGzzds(List<Gzzd> gzzds) {
		this.gzzds = gzzds;
	}

	private List<Gzzd> items;

	public List<Gzzd> getItems() {
		return items;
	}

	private List<String> names = new ArrayList<String>();

	public List<String> getNames() {
		return names;
	}

	private List<Zcxx> zcxxList;

	public List<Zcxx> getZcxxList() {
		return zcxxList;
	}
	
	private String zcmc;

	public String getZcmc() {
		return zcmc;
	}

	public void setZcmc(String zcmc) {
		this.zcmc = zcmc;
	}

	@Autowired
	ZcxxManager zcxxManager;

	/**
	 * 条件查询
	 * 
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	public String queryxx() throws ParseException {
		// 下拉列表数据源
		zcxxList = zcxxManager.queryAlljkjss();

		for (Zcxx kd : zcxxList) {
			String name = kd.getZcMc();
			names.add(name);
		}
		getRequest().setAttribute("names", names); // request传值
		String zcName = getModel().getZcml(); //章程名称

		// 获取输入的条件
		String zdContent = getModel().getZdContent();

		StringBuffer hql = new StringBuffer(

		"from Gzzd p where 1=1 ");
		List<Object> args = new ArrayList<Object>();
       
		//按照规章制度内容模糊查询
		if (StringUtils.isNotBlank(zdContent)) {
			hql.append(" and p.zdContent like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(zdContent));
		}
		//按照章程名称模糊查询
		if (StringUtils.isNotBlank(zcName)) {
			Zcxx zcxx = zcxxManager.getZcxxByKdname(zcName);
			hql.append("  and p.zcxx.id = ? ");
			args.add(zcxx.getId());
		}
		hql.append(" order by p.id ");

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
		StringBuffer hql = new StringBuffer(
		"from Gzzd p where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		hql.append("  and p.zcxx.id = ?  ");
		args.add(Integer.parseInt(id));
		hql.append(" order by p.id ");
		
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
	public String delete() {
		String ids = getRequest().getParameter("ids");
		String[] id = ids.split(",");
		for (String id1 : id) {
			int id2 = Integer.parseInt(id1);
			if (id2 != 0) {
				Gzzd hy = getManager().getGzzdByid(id2);
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

	public String jkjsSave() {
		// 获取输入的条件
		String name = getModel().getZcml();
		Zcxx zcxx = zcxxManager.getZcxxByKdname(name);
		// getModel().setZcxx(zcxx);
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”
		if (getModel().getId() == null || getModel().getId() == 0) {
			getModel().setZcxx(zcxx);
			addActionMessage("添加成功！");// 提示
			getManager().getDao().getHibernateTemplate().clear();
			getManager().save(getModel(), zcxx.getId());

		} else {
			addActionMessage("更新成功！");
			getManager().getDao().getHibernateTemplate().clear();
			getManager().save(getModel(), zcxx.getId());
		}

		return "success";
	}

	/**
	 * 跳转到编辑页面
	 */
	public String toEdit() {

		zcxxList = zcxxManager.queryAlljkjss();

		for (Zcxx kd : zcxxList) {
			String name = kd.getZcMc();
			names.add(name);
		}
		int zx = Integer.parseInt(getRequest().getParameter("zx"));
		if (zx == 1) {// 更新
			String zcName = getModel().getZcxx().getZcMc();// 拿到目录的名称
			getModel().setZcml(zcName);

		}
		getRequest().setAttribute("names", names); // request传值
		return "input1";
	}

	/**
	 * 页面异步请求，获得最新的通知公告
	 * 
	 * @return
	 */
	public String indexGzzds() {
		if (viewCount != null) {
			gzzds = getManager().getNotices(viewCount);
			System.out.println(gzzds.toArray().toString());
		}
		return "indexGzzds";
	}

}
