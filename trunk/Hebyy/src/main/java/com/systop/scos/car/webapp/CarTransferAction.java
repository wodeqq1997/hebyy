package com.systop.scos.car.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.car.CarConstants;
import com.systop.scos.car.model.CarTransfer;
import com.systop.scos.car.service.CarTransferManager;

/**
 * 车辆交接记录
 *@author LinJie
 *@version 1.0
 *@create 2012-6-21 上午9:05:29
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings("serial")
public class CarTransferAction extends DefaultCrudAction<CarTransfer, CarTransferManager> {

	//日期
	private Date date;
	
	/**
	 * index
	 */
	public String index(){
		StringBuffer sql = new StringBuffer("from CarTransfer c where 1=1");
		List<Object> args = new ArrayList<Object>();
		if (date != null) {
			sql.append(" and c.date == ?");
			args.add(DateUtil.firstSecondOfDate(date));
		}
		sql.append(" order by c.id desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	/**
	 * 状态Map
	 */
	public Map<String, String> getStatusMap() {
		return CarConstants.CAR_STATUS_MAP;
	}
}
