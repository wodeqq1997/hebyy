package com.systop.hebyy.tsgl.webapp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.tsgl.model.Lbxx;
import com.systop.hebyy.tsgl.model.Tsxx;
import com.systop.hebyy.tsgl.service.LbxxManager;
import com.systop.hebyy.tsgl.service.TsglManager;

/**
 * 图书类别业务类
 * 
 * @author wangyaping
 * 
 */

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class LbxxAction extends DefaultCrudAction<Lbxx, LbxxManager> {

	private List<Lbxx> lbList;

	public List<Lbxx> getLbList() {
		return lbList;
	}

	@Autowired
	TsglManager tsglManager;

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
		StringBuffer hql = new StringBuffer("from Lbxx p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		hql.append(" order by p.id ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		lbList = page.getData();
		return "lb_index";// 跳转到第一个页面

	}

	/**
	 * 查询全部，重定向，不带值
	 * 
	 * @return
	 */
	public String getAllKd() {
		return "lb_success";
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
			List<Tsxx> jds = tsglManager.querykc(id2);
			if (jds.size() != 0) {
				addActionMessage("该类别存在书，不能删除！");
			} else {
				// for(Tsxx jd:jds){
				// tsglManager.remove(jd);
				// }
				Lbxx lbxx = getManager().getLbxxByKdid(id2);
				getManager().remove(lbxx);// 删除的方法
				addActionMessage("删除成功！");
			}
		}

		return "lb_success";
	}

	/**
	 * 保存的方法
	 * 
	 * @return
	 */

	public String lbsave() {
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”

		if (getModel().getId() == null) {
			addActionMessage("添加成功！");// 提示
		} else {
			addActionMessage("更新成功！");
		}
		super.save();

		return "lb_success";
	}
}
