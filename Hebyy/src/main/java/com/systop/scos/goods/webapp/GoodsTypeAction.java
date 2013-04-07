package com.systop.scos.goods.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.goods.model.GoodsType;
import com.systop.scos.goods.service.GoodsManager;
import com.systop.scos.goods.service.GoodsTypeManager;
/**
 * 
 * @author XuRan
 *
 */

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class GoodsTypeAction extends DefaultCrudAction<GoodsType,GoodsTypeManager>{
	
	@Autowired
	private GoodsManager goodsManager;
	
	/*显示物品类型信息*/
	public String index() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from GoodsType gt where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		
		if(StringUtils.isNotBlank(getModel().getName())) {
			sql.append("and gt.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		page = getManager().pageQuery(page, sql.toString(),args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	/*保存物品类型信息*/
	public String save() {
		return super.save();
	}

	@Override
	public String remove() {
		if(getModel() != null){
			if(!goodsManager.isGoodsByType(getModel().getId())){
				return super.remove();						
			}else{
				setModel(null);
				addActionError("该类别已经使用，不允许删除");
				return this.index();
			}
		}else{
			setModel(null);
			addActionError("该物品类别不存在，删除失败");
			return this.index();
		}		
	}
	
}
