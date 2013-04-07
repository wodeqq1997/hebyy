package com.systop.scos.asset.webapp;

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
import com.systop.scos.asset.model.AssetCheck;
import com.systop.scos.asset.service.AssetCheckManager;

/**
 * 设备物资检测记录
 * 
 * @author LinJie
 * @version 1.0
 * @create 2012-6-21 下午3:49:34
 */
@SuppressWarnings({ "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AssetCheckAction extends
		DefaultCrudAction<AssetCheck, AssetCheckManager> {

	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;

	/**
	 * 查询显示车辆维修记录
	 */
	public String index() {
		StringBuffer sql = new StringBuffer("from AssetCheck a where 1=1");
		List<Object> args = new ArrayList<Object>();

		if (getModel().getAsset() != null
				&& StringUtils.isNotBlank(getModel().getAsset().getName())) {
			sql.append(" and a.asset.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getAsset().getName()));
		}

		if (startDate != null) {
			sql.append(" and a.checkDate >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if (endDate != null) {
			sql.append(" and a.checkDate <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}

		sql.append(" order by a.checkDate desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	@Override
	public String save() {
		getManager().getDao().getHibernateTemplate().clear();
		return super.save();
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
}
