package com.systop.scos.asset.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.asset.model.AssetType;

/**
 * 物资类型管理，涉及相关业务及数据库操作等
 * 
 * @author SongBaoJie
 */
@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class AssetTypeManager extends BaseGenericsManager<AssetType> {
	/**
	 * 得到所有物资类型
	 * 
	 * @return
	 */
	public Map getAllAssetType() {
		StringBuffer sql = new StringBuffer("from AssetType a where 1=1 ");
		List<Object> args = new ArrayList<Object>(); 
		
		// 分公司 update for 2013-01-21 by: wangfan
		
		Map typeMap = new LinkedMap();
		List<AssetType> list = query(sql.toString(), args.toArray());
		for (AssetType a : list) {
			typeMap.put(a.getId(), a.getName());
		}
		return typeMap;
	}
}
