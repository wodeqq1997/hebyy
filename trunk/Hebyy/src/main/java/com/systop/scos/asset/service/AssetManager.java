package com.systop.scos.asset.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.asset.model.Asset;

/**
 * 文章信息管理，涉及相关业务及数据库操作等
 * 
 * @author SongBaoJie
 */
@Service
public class AssetManager extends BaseGenericsManager<Asset> {
	

	/**
	 * 查询所有物品
	 */
	@SuppressWarnings("unchecked")
	public Map<Integer,String> getGoodsMap() {
		StringBuffer sql = new StringBuffer("from Asset g ");
		List<Object> args = new ArrayList<Object>();
		
		
		Map<Integer,String> goodsMap = new LinkedMap();
		List<Asset> list = getDao().query(sql.toString(), args.toArray());
		for(Asset g : list) {
			goodsMap.put(g.getId(),g.getName());
		}
		return goodsMap;
	}
}
