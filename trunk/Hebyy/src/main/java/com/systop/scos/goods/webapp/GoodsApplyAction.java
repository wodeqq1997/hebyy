package com.systop.scos.goods.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.Constants;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.goods.GoodsConstants;
import com.systop.scos.goods.model.GoodsApply;
import com.systop.scos.goods.model.InStock;
import com.systop.scos.goods.service.GoodsApplyManager;

/**
 * 办公用品使用登记单
 * 
 * @author SongBaoJie
 * 
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings({ "serial", "unchecked" })
public class GoodsApplyAction extends
		DefaultCrudAction<GoodsApply, GoodsApplyManager> {

	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;

	// 查询条件
	private String hql;

	// 查询条件所需参数
	private Object[] args;
	
	//用户的业务类
	@Autowired
	UserManager userManager;

	/**
	 * 查看所有办公用品使用登记记录
	 */
	public String index() {
		Map<String, Object> queryMap = buildQuery(null);

		hql = queryMap.get(Constants.HQL_KEY).toString();
		args = (Object[]) queryMap.get(Constants.ARGS_KEY);

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql, args);
		restorePageData(page);

		List<GoodsApply> list = page.getData();
		if (list != null && list.size() > 0) {
			int totalUseCount = 0;
			for (GoodsApply g : list) {
				totalUseCount += g.getUseCount();
			}
			getRequest().setAttribute("totalUseCount", totalUseCount);
		}
		return INDEX;
	}

	/**
	 * 查询显示【我的(个人登记记录)】办公用品使用登记单
	 */
	public String myIndex() {
		Map<String, Object> queryMap = buildQuery(getLoginUser());

		hql = queryMap.get(Constants.HQL_KEY).toString();
		args = (Object[]) queryMap.get(Constants.ARGS_KEY);

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql, args);
		restorePageData(page);
		List<GoodsApply> list = page.getData();
		if (list != null && list.size() > 0) {
			int totalUseCount = 0;
			for (GoodsApply g : list) {
				totalUseCount += g.getUseCount();
			}
			getRequest().setAttribute("totalUseCount", totalUseCount);
		}
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
		StringBuffer sql = new StringBuffer("from GoodsApply g where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (user != null) {
			sql.append("and g.proposer.id = ?");
			args.add(user.getId());
		}

		if (getModel().getGoods() != null
				&& StringUtils.isNotBlank(getModel().getGoods().getName())) {
			sql.append("and g.goods.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getGoods()
					.getName()));
		}
		

		if (getModel() != null
				&& StringUtils.isNotBlank(getModel().getApplyNo())) {
			sql.append("and g.applyNo like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getApplyNo()));
		}

		if (startDate != null) {
			sql.append(" and g.applyDate >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if (endDate != null) {
			sql.append(" and g.applyDate <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}

		sql.append(" order by g.applyDate desc");

		query.put(Constants.HQL_KEY, sql.toString());
		query.put(Constants.ARGS_KEY, args.toArray());
		return query;
	}

	@Override
	public String save() {
	    
	    String drawid = getRequest().getParameter("jsrId");//拿到领用人id
	    User user=userManager.get(Integer.parseInt(drawid));
	    getModel().setProposer(user);
	    super.save();
	    getManager().updateCountByPass(getModel());
		return "toIndexDraw";
	}
	
   /**
    *跳转到首页 
    */
	public String indexDraw() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from InStock i where 1=1");
		sql.append(" order by i.inDate desc");
		page = getManager().pageQuery(page, sql.toString());
		restorePageData(page);

		items = page.getData();
		return "indexDraw";
	}


	@Override
	public String edit() {
		if (getModel() != null && getModel().getId() == null) {
			getModel().setApplyNo(getManager().getApplyNo(new Date()));
		}
		return super.edit();
	}

	
	/**
	 * 办公用品申请记录状态Map
	 */
	public Map<String, String> getStatusMap() {
		return GoodsConstants.GOODS_APPLY_STATUS_MAP;
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