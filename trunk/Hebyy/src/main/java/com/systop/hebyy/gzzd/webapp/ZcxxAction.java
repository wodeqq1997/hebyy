package com.systop.hebyy.gzzd.webapp;

import java.util.ArrayList;
import java.util.List;

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

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ZcxxAction extends DefaultCrudAction<Zcxx, ZcxxManager> {

	// 首页显示规章条数
	private Integer viewCount;

	private List<Zcxx> zcxxs;

	private List<Zcxx> zcList;

	@Autowired
	GzzdManager gzzdManager;

	/**
	 * 条件查询
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String queryxx() {

		// 获取输入的条件
		// String name = getModel().getKdMc();
		// kdList = getManager().queryKd(name, sex);// 通过条件赋值
		StringBuffer hql = new StringBuffer(

		"from Zcxx p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		hql.append(" order by p.id ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		zcList = page.getData();
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
	public String delete() {

		String ids = getRequest().getParameter("ids");
		String[] id = ids.split(",");

		for (String id1 : id) {
			int id2 = Integer.parseInt(id1);
			List<Gzzd> jds = gzzdManager.querykc(id2);
			if (jds.size() != 0) {
				addActionMessage("该类已经使用，不能删除！");
			} else {
				// for (Gzzd jd : jds) {
				// gzzdManager.remove(jd);
				// }
				Zcxx zcxx = getManager().getZcxxByKdid(id2);
				getManager().remove(zcxx);// 删除的方法
				addActionMessage("删除成功！");
			}

		}
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
			getModel().setZcxh("第" + getModel().getZcxh() + "章");
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
	public String indexZcxxs() {

		if (viewCount != null) {
			zcxxs = getManager().queryAlljkjss();
		}
		return "indexZcxxs";
	}

	public List<Zcxx> getZcxxs() {
		return zcxxs;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public List<Zcxx> getZcList() {
		return zcList;
	}
}
