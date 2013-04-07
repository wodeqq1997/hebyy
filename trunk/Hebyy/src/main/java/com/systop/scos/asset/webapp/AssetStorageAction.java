package com.systop.scos.asset.webapp;

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

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.asset.model.AssetStorage;
import com.systop.scos.asset.service.AssetStorageManager;
import com.systop.scos.asset.service.AssetTypeManager;

@SuppressWarnings({ "rawtypes", "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AssetStorageAction 
	extends DefaultCrudAction<AssetStorage, AssetStorageManager>  {

	// 开始时间
	private Date startDate;
	// 结束时间
	private Date endDate;
	// 进出标示
	private String inOrOut;
	
	@Autowired
	private AssetTypeManager assetTypeManager;
	
	public String editBringInput(){
		return "inputBring";
	}
	
	public String editTakeInput(){
		return "inputTake";
	}
	
	public String index(){
		StringBuffer sql = new StringBuffer("from AssetStorage s where 1=1");
		List<Object> args = new ArrayList<Object>();
		// 物资名称
		if (getModel().getAsset() != null 
				&& StringUtils.isNotBlank(getModel().getAsset().getName())) {
			sql.append(" and s.asset.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getAsset().getName()));
		}
		
		
		// 物资状态
		if(StringUtils.isNotBlank(getModel().getStatus())){
			sql.append(" and s.status = ?");
			args.add(getModel().getStatus());
		}
		
		// 物资类型
		if (getModel().getAsset() != null 
				&& getModel().getAsset().getAssetType() != null 
				&& getModel().getAsset().getAssetType().getId() != null){
			sql.append(" and s.asset.assetType.id = ?");
			args.add(getModel().getAsset().getAssetType().getId());
		}
		if(StringUtils.isNotBlank(getModel().getStatus())){
			if("已归还".equals(getModel().getStatus())){
				if(startDate != null && endDate != null){
					sql.append(" and s.bringTime between ? and ?");
					args.add(DateUtil.firstSecondOfDate(startDate));
					args.add(DateUtil.lastSecondOfDate(endDate));
				}
			} else {
				if(startDate != null && endDate != null){
					sql.append(" and s.takeTime between ? and ?");
					args.add(DateUtil.firstSecondOfDate(startDate));
					args.add(DateUtil.lastSecondOfDate(endDate));
				}
			}
		}
		sql.append(" order by s.takeTime desc ,s.status");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	/**
	 * 保存
	 */
	public String save(){
		if(StringUtils.isNotBlank(inOrOut)){
			
			if("in".equals(inOrOut)){
				getModel().setBringPerson(StringUtils.trimToEmpty(getModel().getBringPerson()));
				getModel().setBringDetail(StringUtils.trimToEmpty(getModel().getBringDetail()));
				getModel().setBringOperator(getLoginUser());
				//getModel().setBringTime(new Date());
				getModel().setStatus("已归还");
			}else{
				List<AssetStorage>  list = getManager().findAssetStorageByAssetId("出库", getModel().getAsset().getId());
				if(list != null && list.size() > 0){
					addActionError("该物资已出库");
					return "inputTake";
				}
				getModel().setTakeDetail(StringUtils.trimToEmpty(getModel().getTakeDetail()));
				getModel().setTakePerson(StringUtils.trimToEmpty(getModel().getTakePerson()));
				getModel().setTakeOperator(getLoginUser());
				getModel().setTakeTime(new Date());
				getModel().setStatus("出库");
			}
			super.save();
		}
		return SUCCESS;
	}

	/**
	 * 所有物资类型MAP
	 * 
	 * @return Map
	 */
	public Map getAssetTypeMap() {
		return assetTypeManager.getAllAssetType();
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

	public String getInOrOut() {
		return inOrOut;
	}

	public void setInOrOut(String inOrOut) {
		this.inOrOut = inOrOut;
	}
}
