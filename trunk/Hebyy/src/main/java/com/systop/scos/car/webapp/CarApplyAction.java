package com.systop.scos.car.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.Constants;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.car.CarConstants;
import com.systop.scos.car.model.CarApply;
import com.systop.scos.car.service.CarApplyManager;

/**
 * 汽车使用记录管理
 * 
 * @author SongBaoJie
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings( "serial" )
public class CarApplyAction extends DefaultCrudAction<CarApply, CarApplyManager> {
	
	
	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;
	
	// 查询条件
	private String hql;

	// 查询条件所需参数
	private Object[] args;
	
	/**
	 * 查询显示汽车使用申请记录
	 */
	public String index() {
		Map<String, Object> queryMap = buildQuery(null);

		hql = queryMap.get(Constants.HQL_KEY).toString();
		args = (Object[]) queryMap.get(Constants.ARGS_KEY);
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql, args);
		restorePageData(page);
		return INDEX;
	}
	
	/**
	 * 查询显示【我的(个人申请记录)】汽车使用申请记录
	 */
	public String myIndex() {
		Map<String, Object> queryMap = buildQuery(getLoginUser());

		hql = queryMap.get(Constants.HQL_KEY).toString();
		args = (Object[]) queryMap.get(Constants.ARGS_KEY);
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql, args);
		restorePageData(page);
		return "myIndex";
	}	
	
	/**
	 * 组合查询条件
	 * 
	 * @param user
	 *            可为null
	 * @return
	 */
	private Map<String, Object> buildQuery(User user) {
		Map<String, Object> query = new HashMap<String, Object>();
		//StringBuffer sql = new StringBuffer("from CarApply c where c.car.id is not null");
		StringBuffer sql = new StringBuffer("from CarApply c where 1=1");
		List<Object> args = new ArrayList<Object>();
		
		if(user != null){
			sql.append(" and c.proposer.id = ?");
			args.add(user.getId());
		}
		
		if (getModel().getCar() != null && StringUtils.isNotBlank(getModel().getCar().getCarNo())) {
			sql.append(" and c.car.carNo like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getCar().getCarNo()));
		}
		
		if(getModel() != null && StringUtils.isNotBlank(getModel().getStatus())){
			sql.append(" and c.status = ?");
			args.add(getModel().getStatus());
		}
		
		if (startDate != null) {
			sql.append(" and c.applyDate >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if (endDate != null) {
			sql.append(" and c.applyDate <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}
		
		sql.append(" order by c.applyDate desc");

		query.put(Constants.HQL_KEY, sql.toString());
		query.put(Constants.ARGS_KEY, args.toArray());
		return query;
	}
	
	@Override
	public String save() {
		getManager().getDao().getHibernateTemplate().clear();
		getManager().save(getModel());
		return "myIndexSuccess";
	}

	@Override
	public String edit() {
		if(getModel() != null  && getModel().getId() == null){
			User u = getLoginUser();
			getModel().setProposer(u);
		}
		return super.edit();
	}

	/**
	 * 审核通过
	 * @return
	 */
	public String passCarApply() {
		if (getModel() != null) {
			try {
				getManager().passCarApply(getModel());
			} catch (Exception e) {
				setModel(new CarApply());
				return this.index();
			}
		} else {
			logger.debug("该车辆申请记录不存在。");
		}
		return SUCCESS;
	}
	
	/**
	 * 审核未通过
	 * @return
	 */
	public String noPassCarApply() {
		if (getModel() != null) {
			getModel().setStatus(CarConstants.CAR_APPLY_NOT_PASS);
			getManager().update(getModel());
		} else {
			logger.debug("该车辆申请记录不存在。");
		}
		return SUCCESS;
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
	
	/**
	 * 汽车使用申请记录状态Map
	 */
	public Map<String, String> getStatusMap() {
		return CarConstants.CAR_APPLY_STATUS_MAP;
	}

}
