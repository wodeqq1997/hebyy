package com.systop.scos.asset.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.asset.model.AssetInStock;
import com.systop.scos.asset.service.AssetInStockManager;
import com.systop.scos.asset.service.AssetManager;

/**
 * @Date 2012-8-31
 * @author LinJie
 * 
 */
@SuppressWarnings({"serial","unchecked"})
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AssetInStockAction extends DefaultCrudAction<AssetInStock, AssetInStockManager> {

	@Autowired
	private AssetManager assetManager;
	// 入库日期（根据入库日期查询）
	private String cDate;

	/*入库单查询*/
	public String index() {
		page = PageUtil.getPage(getPageNo(),getPageSize());
		StringBuffer sql = new StringBuffer("from AssetInStock i where 1=1");
		List<Object> args = new ArrayList<Object>();
	
		if(StringUtils.isNotBlank(getModel().getStockNo())) {//按单号查询
			sql.append(" and i.stockNo = ?");
			args.add(getModel().getStockNo());
		}
		
		if(getModel().getAsset() != null && StringUtils.isNotBlank(getModel().getAsset().getName())){ //按物品名称查询
			sql.append(" and i.asset.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getAsset().getName()));
		}
		
		if(StringUtils.isNotBlank(cDate)) {//按入库日期查询
			sql.append(" and i.inDate = ?");
			try {
				args.add(DateUtil.firstSecondOfDate(DateUtil
						.convertStringToDate("yyyy-MM-dd", cDate)));
			} catch (ParseException e) {
			}
		}
		
		sql.append(" order by i.inDate desc");
		page = getManager().pageQuery(page, sql.toString(),args.toArray());
		restorePageData(page);
		
		List<AssetInStock> list = page.getData();
		if(list != null && list.size() > 0){
			//统计总入库数量
			int totalInCounts = 0;
			//统计总价钱
			double totalAmount = 0;
			for(AssetInStock i : list){
				// 入库数
				Integer inCounts = i.getInCounts() == null ? 0 : i.getInCounts();
				// 此单库存价钱
				Double amount = i.getAmount() == null ? 0d : i.getAmount();
				totalInCounts += inCounts;
				totalAmount += amount;
			}
			getRequest().setAttribute("totalAmount", totalAmount);
			getRequest().setAttribute("totalInCounts", totalInCounts);
		}
		
		return INDEX;
	}

	public String save() {
		// 修改入库商品需要clear
		getManager().getDao().getHibernateTemplate().clear();
		getModel().setNowCounts(getModel().getInCounts());
		return super.save();
	}
	
	@Override
	public String edit() {
		if(getModel() != null && getModel().getId() == null){
			String stockNo = getManager().getStockNo(new Date());
			getModel().setStockNo(stockNo);
		}
		return super.edit();
	}

	@Override
	public String remove() {
		return super.remove();
	}

	/*获得物品map*/
	@SuppressWarnings("rawtypes")
	public Map getGoodsMap() {
		return assetManager.getGoodsMap();
	}

	public String getCDate() {
		return cDate;
	}

	public void setCDate(String cDate) {
		this.cDate = cDate;
	}
}
