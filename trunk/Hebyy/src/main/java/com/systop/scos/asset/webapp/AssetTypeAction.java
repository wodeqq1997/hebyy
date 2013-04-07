package com.systop.scos.asset.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.asset.model.AssetType;
import com.systop.scos.asset.service.AssetTypeManager;

/**
 * 物资类型信息Action,负责处理与之相关的各种请求
 * 
 * @author SongBaoJie
 */
@SuppressWarnings({ "serial"})
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AssetTypeAction extends DefaultCrudAction<AssetType, AssetTypeManager> {
	/**
	 * 查询显示物资类型信息
	 */
	public String index() {
		StringBuffer sql = new StringBuffer("from AssetType a where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		
		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append("and a.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	@Override
	public String remove() {
		if(getModel() != null){
			try {
				return super.remove();						
			} catch (Exception e) {
				setModel(null);
				addActionError("该类别已经使用，不允许删除");
				return this.index();				
			}
		}else{
			setModel(null);
			addActionError("该类别不存在，删除失败");
			return this.index();
		}		
	}
	
	@Override
	public String save(){
		return super.save();
	}
}
