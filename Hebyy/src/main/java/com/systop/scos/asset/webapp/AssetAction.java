package com.systop.scos.asset.webapp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.asset.model.Asset;
import com.systop.scos.asset.service.AssetManager;
import com.systop.scos.asset.service.AssetTypeManager;

/**
 * 物资信息Action,负责处理与之相关的各种请求
 * 
 * @author SongBaoJie
 */
@SuppressWarnings({ "rawtypes", "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AssetAction extends DefaultCrudAction<Asset, AssetManager> {
	@Autowired
	private AssetTypeManager assetTypeManager;
	@Autowired
	private UserManager userManager;
	/**
	 * 查询显示物资信息
	 */
	public String index() {
		StringBuffer sql = new StringBuffer("from Asset a where 1=1");
		List<Object> args = new ArrayList<Object>();
		
		if(getLoginUser() != null){
			sql.append(" and a.proposer.id = ?");
			args.add(getLoginUser().getId());
		}
		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append(" and a.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}

		if(StringUtils.isNotBlank(getModel().getStatus())){
			sql.append(" and a.status = ?");
			args.add(getModel().getStatus());
		}
		
		
		if (getModel().getAssetType() != null 
				&& getModel().getAssetType().getId() != null){
			sql.append(" and a.assetType.id = ?");
			args.add(getModel().getAssetType().getId());
		}
		if (getLoginUser().getDept() != null){
			sql.append(" and a.dept.id = ?");
			args.add(getLoginUser().getDept().getId());
		}
		sql.append(" order by a.buyDate desc");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	@Override
	public String save() {
		getManager().getDao().getHibernateTemplate().clear();
		getModel().setDept(getLoginUser().getDept());
	    int csrid=getModel().getDepter().getId();
	    User user=userManager.get(csrid);
	    getModel().setDepter(user);
	    
		return super.save();
	}

   /**
    * 跳转到申购页面
    * wangyaping
    */
	@Override
	public String edit() {
		if(getModel() != null  && getModel().getId() == null){
			User u = getLoginUser();
			getModel().setProposer(u);
			Dept dept=u.getDept();
			getModel().setDept(dept);
		}
		return super.edit();
	}
	/**
	 * 所有物资类型MAP
	 * 
	 * @return Map
	 */
	public Map getAssetTypeMap() {
		return assetTypeManager.getAllAssetType();
	}
	
	public String showIndex(){
		this.index();
		return "showIndex";
	}
}
