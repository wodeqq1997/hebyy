package com.systop.scos.goods.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.dao.support.Page;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.goods.model.GoodsInquiry;
import com.systop.scos.goods.service.GoodsInquiryManager;
import com.systop.scos.goods.service.GoodsManager;

/**
 * 供应商类别管理Action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings({ "serial"})
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class GoodsInquiryAction extends DefaultCrudAction<GoodsInquiry, GoodsInquiryManager> {

	// 开始时间
	private String startDate;

	// 结束时间
	private String endDate;
	
	@Autowired
	private GoodsManager goodsManager;
	/**
	 * 查询供应商类别
	 */
	@Override
	public String index() {
		Page page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from GoodsInquiry s where 1=1");
		List<Object> args = new ArrayList<Object>();
		
		//询价商品
		if (getModel().getGoods() != null && getModel().getGoods().getId() != null) { 
			sql.append(" and s.goods.id = ?");
			args.add(getModel().getGoods().getId());
		}
		
		
		// 供应商
		if (getModel().getGoodsSupplier() != null && StringUtils.isNotBlank(getModel().getGoodsSupplier().getName())) {
			sql.append(" and s.goodsSupplier.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getGoodsSupplier().getName()));
		}

		try {
			if (StringUtils.isNotBlank(startDate)) {
				sql.append(" and s.createTime >= ?");
				args.add(DateUtil.firstSecondOfDate(DateUtil
						.convertStringToDate("yyyy-MM-dd", startDate)));
			}
			if (StringUtils.isNotBlank(endDate)) {
				sql.append(" and s.createTime <= ?");
				args.add(DateUtil.lastSecondOfDate(DateUtil
						.convertStringToDate("yyyy-MM-dd", endDate)));
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		sql.append(" order by s.createTime desc");

		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	/**
	 * 得到所有商品 
	 */
	public Map<Integer, String> getGoodsMap(){
		return goodsManager.getGoodsMap();
	}

	@Override
	public String save() {
		getManager().getDao().getHibernateTemplate().clear();
		getModel().setNotes(StringUtils.trimToEmpty(getModel().getNotes()));
		getModel().setPrice(StringUtils.trimToEmpty(getModel().getPrice()));
		if(getModel().getNotes().length() > 500){
			addActionError("【备注】内容应在500个字符以内");
		}
		return super.save();
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
}