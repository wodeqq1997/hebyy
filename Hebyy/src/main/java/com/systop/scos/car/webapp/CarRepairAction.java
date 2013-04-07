package com.systop.scos.car.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.car.model.CarRepair;
import com.systop.scos.car.service.CarRepairManager;

/**
 * 车辆维修记录管理
 * 
 * @author SongBaoJie
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings("serial")
public class CarRepairAction extends DefaultCrudAction<CarRepair, CarRepairManager> {
	
	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;
	
	/**
	 * 查询显示车辆维修记录
	 */
	public String index() {
		StringBuffer sql = new StringBuffer("from CarRepair c where 1=1");
		List<Object> args = new ArrayList<Object>();
		
		if (getModel() != null && getModel().getCar() != null) {
			if(StringUtils.isNotBlank(getModel().getCar().getCarNo())){
				sql.append(" and c.car.carNo like ?");
				args.add(MatchMode.ANYWHERE.toMatchString(getModel().getCar().getCarNo()));
			}
			if(StringUtils.isNotBlank(getModel().getCar().getEngineNo())){
				sql.append(" and c.car.engineNo like ?");
				args.add(MatchMode.ANYWHERE.toMatchString(getModel().getCar().getEngineNo()));
			}
		}
		
		if(StringUtils.isNotBlank(getModel().getRepairType())){
			sql.append(" and c.repairType = ?");
			args.add(getModel().getRepairType());
		}
		
		if (startDate != null) {
			sql.append(" and c.repairDate >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if (endDate != null) {
			sql.append(" and c.repairDate <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}

		
		sql.append(" order by c.repairDate desc");
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
