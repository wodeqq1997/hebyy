package com.systop.scos.goods.webapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.goods.model.GoodsSupplier;
import com.systop.scos.goods.service.GoodsSupplierManager;

/**
 * 供应商管理Action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings({ "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class GoodsSupplierAction extends DefaultCrudAction<GoodsSupplier, GoodsSupplierManager> {

	private Map<String, String> titlesMap;
	
	//异步请求返回值
	private List<Map<String, String>> suppliers;
	
	/**
	 * 查询供应商信息
	 */
	@Override
	public String index() {
		StringBuffer sql = new StringBuffer("from GoodsSupplier s where 1=1");
		List<Object> args = new ArrayList<Object>();

		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append(" and s.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		

		sql.append(" order by s.name");
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 查询供应商
	 */
	public String selectSupplier(){
		this.index();
		return "selectSupplier";
	}
	/**
	 * 获取所有供应商
	 * @return
	 */
	public String allSupplier(){
		String hql = "from GoodsSupplier";
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql);
		restorePageData(page);
		return "allSupplier";
	}

	/**
	 * 保存供应商信息
	 */
	@Override
	public String save() {
		getManager().getDao().getHibernateTemplate().clear();
		getModel().setNotes(StringUtils.trimToEmpty(getModel().getNotes()));
		getModel().setAddress(StringUtils.trimToEmpty(getModel().getAddress()));
		// 分公司 update for 2013-01-21 by: wangfan
		if(getModel().getNotes().length() > 500){
			addActionError("【备注】内容应在500个字符以内");
			return INPUT;
		}
		if(getModel().getAddress().length() > 250){
			addActionError("【地址】内容应在250个字符以内");
			return INPUT;
		}
		return super.save();
	}

	@Override
	public String remove() {
		try {
			return super.remove();
		} catch (Exception e) {
			setModel(null);
			addActionError("该供应商已经存在使用，不允许删除");
			return this.index();
		}
	}

	/**
	 * 预览供应商信息
	 */
	public String view() {
		return VIEW;
	}
	
	/**
	 * 异步调用
	 * 得到所有供应商(资源)
	 */
	public String listAllSuppliers(){
		StringBuffer sql = new StringBuffer("from GoodsSupplier s where 1=1");
		List<Object> args = new ArrayList<Object>();
		
		List<GoodsSupplier> list = getManager().query(sql.toString(), args.toArray());
		suppliers = new ArrayList<Map<String, String>>();
		if(list != null){
			for(GoodsSupplier goodsSupplier : list){
				suppliers.add(convertMap(goodsSupplier));
			}
		}
		return "listAllSuppliers";
	}
	
	private Map<String, String> convertMap(GoodsSupplier goodsSupplier) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", goodsSupplier.getId().toString());
		map.put("name", goodsSupplier.getName());
		return map;
	}

	public Map<String, String> getTitlesMap() {
		return titlesMap;
	}
	
	public List<Map<String, String>> getSuppliers() {
		return suppliers;
	}
}