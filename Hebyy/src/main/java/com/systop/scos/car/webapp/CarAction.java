package com.systop.scos.car.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.car.CarConstants;
import com.systop.scos.car.model.Car;
import com.systop.scos.car.service.CarManager;

/**
 * 车辆信息管理
 * 
 * @author SongBaoJie
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings({ "unchecked", "rawtypes", "serial" })
public class CarAction extends DefaultCrudAction<Car, CarManager> {
	
	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;

	/**
	 * 查询显示车辆信息
	 */
	public String index() {
		StringBuffer sql = new StringBuffer("from Car c where 1=1");
		List args = new ArrayList();
		if (StringUtils.isNotBlank(getModel().getCarNo())) {
			sql.append(" and c.carNo like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getCarNo()));
		}
		
		if(StringUtils.isNotBlank(getModel().getEngineNo())){
			sql.append(" and c.engineNo like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getEngineNo()));
		}
		
		if(StringUtils.isNotBlank(getModel().getCarType())){
			sql.append(" and c.carType like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getCarType()));
		}
		
		if (startDate != null) {
			sql.append(" and c.buyDate >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		
		if (endDate != null) {
			sql.append(" and c.buyDate <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}
		
		sql.append(" order by c.buyDate desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 选择车辆信息列表 	
	 */
	public String showIndex(){
		this.index();
		super.edit();
		return "showIndex";
	}
	
	/**
	 * 删除车辆图片
	 */
	public String removeCarPhoto(){
		if(getModel() != null && getModel().getId() != null){
			Car car = getManager().get(getModel().getId());
			if(car != null){
				setModel(car);
				getManager().removeCarPhoto(getModel(), getServletContext());		
			}
		}
		return super.edit();
	}
	
	@Override
	public String remove() {
		try {
			return super.remove();
		} catch (Exception e) {
			setModel(null);
			addActionError("该车辆已经开始使用，不允许删除");
			return this.index();
		}
	}

	/**
	 * 状态Map
	 */
	public Map<String, String> getStatusMap() {
		return CarConstants.CAR_STATUS_MAP;
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
