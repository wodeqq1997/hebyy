package com.systop.hebyy.library.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.library.model.Jhsxx;
import com.systop.hebyy.library.model.Tsxx;
import com.systop.hebyy.library.service.JhsxxManager;
import com.systop.hebyy.library.service.TsglManager;

/**
 * 图书借阅业务
 * 
 * @author WangYaping
 * 
 */

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class JhsxxAction extends DefaultCrudAction<Jhsxx, JhsxxManager> {

	private List<Jhsxx> jhList;

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

		StringBuffer hql = new StringBuffer("from Jhsxx p where 1=1  ");
		List<Object> args = new ArrayList<Object>();
		// 图书名称和借阅人进行查询

		String lbmc = getModel().getBookMc();// 图书名称
		String jsr = getModel().getJsr();// 借书人
		String isgh = getModel().getIsgh();// 是否归还

		if (isgh != null && isgh.equals("已归还")) {
			hql.append("and p.hsr is not null ");
		} else if (isgh != null && isgh.equals("未归还")) {
			hql.append("and p.hsr is null ");
		}

		// 图书名称
		if (StringUtils.isNotBlank(lbmc)) {
			hql.append("and p.bookMc like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(lbmc));
		}

		// 借阅人
		if (StringUtils.isNotBlank(jsr)) {
			hql.append("and p.jsr = ? ");
			args.add(jsr);
		}

		hql.append("order by p.id  ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		jhList = page.getData();
		return "jh_index";// 跳转到第一个页面

	}

	/**
	 * 条件查询（用于普通用户查询）
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String queryxx1() {

		// 获取输入的条件
		StringBuffer hql = new StringBuffer("from Jhsxx p where 1=1  ");
		List<Object> args = new ArrayList<Object>();
		// 图书名称和借阅人进行查询

		String lbmc = getModel().getBookMc();// 图书名称
		String jsr = getModel().getJsr();// 借书人
		String isgh = getModel().getIsgh();// 是否归还

		if (isgh != null && isgh.equals("已归还")) {
			hql.append("and p.hsr is not null ");
		} else if (isgh != null && isgh.equals("未归还")) {
			hql.append("and p.hsr is null ");
		}

		// 图书名称
		if (StringUtils.isNotBlank(lbmc)) {
			hql.append("and p.bookMc like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(lbmc));
		}
		// 借阅人
		if (StringUtils.isNotBlank(jsr)) {
			hql.append("and p.jsr = ? ");
			args.add(jsr);
		}
		hql.append("order by p.id  ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		jhList = page.getData();
		return "cxhsxx";// 跳转到第一个页面

	}

	/**
	 * 查询全部，重定向，不带值
	 * 
	 * @return
	 */
	public String getAllKd() {
		return "jh_success";
	}

	/**
	 * 查询全部，重定向，不带值
	 * 
	 * @return
	 */
	public String getAllKd1() {
		return "jh_success1";
	}

	/**
	 * 跳转到还书的方法
	 */
	@Transactional(readOnly = true)
	public String toHs() {
		String bookid = getRequest().getParameter("item.bookId");
		int id = Integer.parseInt(getRequest().getParameter("item.id"));
		setModel(getManager().get(id));
		if (StringUtils.isNotBlank(bookid)) {
			Tsxx ts = tsglManager.get(Integer.parseInt(bookid));
			String zz = ts.getAuthor();
			getRequest().setAttribute("zz", zz); // request传值
			getRequest().setAttribute("bookid", Integer.parseInt(bookid)); // request传值
		}
		return "hsInput";
	}

	/**
	 * 还书方法
	 * 
	 * @return
	 * @throws ParseException
	 */
	@Transactional
	public String hs() {
		if (!getModel().getBookId().equals("0")) {
			Tsxx ts = tsglManager.getTsxxByid(getModel().getBookId());// 根据bookid拿到图书信息
			ts.setSyNum((Integer.parseInt(ts.getSyNum()) + 1) + "");// 变更库存数量，多一本
			tsglManager.save(ts); // 保存图书信息
		}
		super.save();// 保存还书记录
		return "jh_success";// 跳转到借还书查询页面
	}

	public List<Jhsxx> getJhList() {
		return jhList;
	}

}
