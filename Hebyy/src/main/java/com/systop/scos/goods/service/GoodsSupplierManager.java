package com.systop.scos.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.goods.model.GoodsSupplier;

/**
 * 供应商Service
 * 
 * @author SongBaoJie
 */
@Service
@SuppressWarnings({ "unchecked", "rawtypes" })
public class GoodsSupplierManager extends BaseGenericsManager<GoodsSupplier> {
	
	@Override
	@Transactional
	public void save(GoodsSupplier entity) {
		if (getDao().exists(entity, "name")) {// 验证重复的供应商类别的供应商
			throw new ApplicationException("供应商已经存在:" + entity.getName());
		}
		super.save(entity);
	}

	/**
	 * 得到所有供应商
	 * @return
	 */
	public Map<Integer, String> getAllSupplier() {
		List<GoodsSupplier> list = new ArrayList<GoodsSupplier>();
		Map typeMap = new LinkedMap();
		list = get();
		for (GoodsSupplier s : list) {
			typeMap.put(s.getId(), s.getName());
		}
		return typeMap;
	}
}
