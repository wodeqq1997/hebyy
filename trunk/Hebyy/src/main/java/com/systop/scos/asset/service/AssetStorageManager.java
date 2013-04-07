package com.systop.scos.asset.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.asset.model.AssetStorage;

@Service
public class AssetStorageManager 
	extends BaseGenericsManager<AssetStorage>  {

	/**
	 * 根据 状态 和 物资 id 查询物资信息
	 * @param status
	 * @param assetId
	 * @return
	 */
	public List<AssetStorage> findAssetStorageByAssetId(String status, Integer assetId){
		List<Object> args = new ArrayList<Object>();
		StringBuffer  hql = new StringBuffer("from AssetStorage s where s.status=? and s.asset.id=? ");
		args.add(status);
		args.add(assetId);
		
		return query(hql.toString(), args.toArray());
	}
}
