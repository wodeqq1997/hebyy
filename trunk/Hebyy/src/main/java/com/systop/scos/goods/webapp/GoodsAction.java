package com.systop.scos.goods.webapp;

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

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.goods.model.Goods;
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
public class GoodsAction extends DefaultCrudAction<Goods,GoodsManager>{

	@Autowired
	private GoodsTypeManager goodsTypeManager;

	/*显示物品信息*/
	public String index() {
		StringBuffer sql = new StringBuffer("from Goods g where 1=1");
		List<Object> args = new ArrayList<Object>();
		if(StringUtils.isNotBlank(getModel().getName())) {
			sql.append(" and g.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		if(getModel().getGoodsType() != null && getModel().getGoodsType().getId() != null){
			sql.append(" and g.goodsType.id = ?");
			args.add(getModel().getGoodsType().getId());
		}
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(),args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	@Override
	public String edit() {
		if(getModel()!= null && getModel().getId() == null){
			getModel().setGoodsNo(getManager().getGoodsNo(new Date()));
		}
		return super.edit();
	}



	/*保存物品信息*/
	public String save() {
		if(getModel() != null && getModel().getId() == null){
			getModel().setCreateTime(new Date());
		}
		return super.save();
	}

	@Override
	public String remove() {
		if(getModel() != null){
			try {
				return super.remove();						
			} catch (Exception e) {
				setModel(null);
				addActionError("该物品已经使用，不允许删除");
				return this.index();
			}
		}else{
			setModel(null);
			addActionError("该物品不存在，删除失败");
			return this.index();
		}
	}

	public String showIndex(){
		this.index();
		return "showIndex";
	}
	
	/**
	 * 查询获取物品类别
	 * 
	 * @return
	 */
	public Map<Integer, String> getGoodsTypeMap() {
		return goodsTypeManager.getGoodsTypeMap();
	}


}
