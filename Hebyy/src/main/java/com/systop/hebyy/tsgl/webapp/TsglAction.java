package com.systop.hebyy.tsgl.webapp;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;


import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.tsgl.model.Jhsxx;
import com.systop.hebyy.tsgl.model.Lbxx;
import com.systop.hebyy.tsgl.model.Tsxx;
import com.systop.hebyy.tsgl.service.JhsxxManager;
import com.systop.hebyy.tsgl.service.LbxxManager;
import com.systop.hebyy.tsgl.service.TsglManager;



/**
 * 图书维护
 * @author WangYaping
 *
 */

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class TsglAction extends DefaultCrudAction<Tsxx, TsglManager> {


	private List<Lbxx> lbxxList;

	@Autowired
	LbxxManager lbxxManager;
	
	@Autowired
	JhsxxManager jhsxxManager;

	/**
	 * 条件查询（用于图书管理查询页面）
	 * 
	 * @return
	 * @throws ParseException
	 */
	public String queryxx() throws ParseException {
		this.queryBook();
		return "index";// 跳转到第一个页面

	}
	
	/**
	 * 条件查询（用于借书查询页面）
	 * 
	 * @return
	 * @throws ParseException
	 */
	public String queryxx1() throws ParseException {

		this.queryBook();
		return "index1";// 跳转到第一个页面

	}
	/**
	 * 条件查询（用于普通用户查询页面）
	 * 
	 * @return
	 * @throws ParseException
	 */

	public String queryxx2() throws ParseException {
		
		this.queryBook();
		return "index2";// 跳转到第一个页面

	}
	/**
	 * 条件查询
	 */
	@SuppressWarnings("unchecked")
	private void queryBook(){
		// 获取输入的条件
		String tsMc = getModel().getTsMc();// 按图书名称查询
		String author = getModel().getAuthor();// 按作者查询

		StringBuffer hql = new StringBuffer("from Tsxx p where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		// 图书名称
		if (tsMc != null && !tsMc.equals("")) {
			hql.append("and p.tsMc like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(tsMc));
		}
		// 图书类别
		if (getModel().getLbxx()!=null&&getModel().getLbxx().getId()!=null) {
			hql.append("and p.lbxx.id = ? ");
			args.add(getModel().getLbxx().getId());
		}
		// 作者
		if (author != null && !author.equals("")) {
			hql.append("and p.author = ?  ");
			args.add(author);
		}
		hql.append("order by p.id ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
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
	 * 查询全部，重定向，不带值
	 * 
	 * @return
	 */
	public String toAll2() {
		return "success2";
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
				Tsxx hy = getManager().getTsxxByid(id2);
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
		
		// getModel().setZcxx(zcxx);
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”
		if (getModel().getId() == null || getModel().getId() == 0) {
			getModel().setSyNum(getModel().getTotalNum());// 剩余数量等于入库数量
			
			addActionMessage("添加成功！");// 提示
			getManager().getDao().getHibernateTemplate().clear();
			getManager().save(getModel(), getModel().getLbxx().getId());

		} else {
			// 剩余数量 为总数量减去借出去的数量
			int totalnum=Integer.parseInt(getModel().getTotalNum());//总数
			int noghNum=jhsxxManager.getNogh(getModel().getId());//没有归还的书目
			//剩余数目
			int syNum=totalnum-noghNum;
			getModel().setSyNum(syNum+"");
			
			addActionMessage("更新成功！");
			getManager().getDao().getHibernateTemplate().clear();
			getManager().save(getModel(), getModel().getLbxx().getId());
		}

		return "success";
	}

	/**
	 * 跳转到编辑页面
	 */
	public String toEdit() {
		return "input1";
	}
	/**
	 * 跳转到借书页面
	 */
	@Transactional(readOnly = true)
	public String toJs() {
		return "js";
	}
	/**
	 * 借书方法
	 * @return
	 * @throws ParseException
	 */

	public String js() throws ParseException{
		
		Jhsxx jhsxx=new Jhsxx();//借还书信息
	    setModel(getManager().get(getModel().getId()));//图书信息
	    /**给借还书信息里赋值*/
		jhsxx.setBookId(getModel().getId());//图书id
		jhsxx.setJsr(getRequest().getParameter("jsr"));//借书人姓名
		jhsxx.setJsbz(getRequest().getParameter("bzxx"));//借书备注信息
		jhsxx.setBookMc(getModel().getTsMc());//图书名称
		jhsxx.setJsrId(getRequest().getParameter("jsrId"));//还书人id
		/**获得Date类型的借书时间*/
		DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
		String s=getRequest().getParameter("jytime");    
		Date date = fmt.parse(s);
		jhsxx.setJsTime(date);
		jhsxxManager.savexx(jhsxx);//添加一条借书信息记录
	    getModel().setSyNum((Integer.parseInt(getModel().getSyNum())-1)+"");//图书库存数量减一
	    super.save();    //保存图书信息
		
		return "success1";
	}
	/**
	 * 删除图片
	 */
	public String removeBookPhoto(){
		if(getModel() != null && getModel().getId() != null){
			Tsxx tsxx = getManager().get(getModel().getId());
			if(tsxx != null){
				setModel(tsxx);
				getManager().removeBookPhoto(getModel(), getServletContext());		
			}
		}
		return "input1";
	}
	
	/**
	 * 获得类型下拉列表数据源
	 * @return
	 */
	public Map<Integer, String> getTypeMap() {
		return lbxxManager.getTypeMap();
	}
	
	public List<Lbxx> getlbxxList() {
		return lbxxList;
	}


}
