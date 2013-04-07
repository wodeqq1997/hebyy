package com.systop.scos.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.goods.model.GoodsType;

/**
 * 
 * @author XuRan
 */
@Service
public class GoodsTypeManager extends BaseGenericsManager<GoodsType> {
	
	@Override
    @Transactional
	public void save(GoodsType entity) {
		if (getDao().exists(entity, "name")) {
			throw new ApplicationException("该物品类别名称已经存在,请您查证后再次录入");
		}
		super.save(entity);
	}
	
	/**
	 * 查询物品类别
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<Integer, String> getGoodsTypeMap() {
		StringBuffer sql = new StringBuffer("from GoodsType gt where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		
		List<GoodsType> goodsTypes = query(sql.toString(), args.toArray());
		Map<Integer, String> typeMap = new LinkedMap();
		for (GoodsType gt : goodsTypes) {
			typeMap.put(gt.getId(), gt.getName());
		}
		return typeMap;
	}
}
