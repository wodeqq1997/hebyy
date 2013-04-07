package com.systop.scos.goods.service;

import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.goods.model.GoodsInquiry;

/**
 * 供应商询价Service
 * 
 * @author SongBaoJie
 */
@Service
public class GoodsInquiryManager extends BaseGenericsManager<GoodsInquiry> {

	
	@Override
	@Transactional(readOnly = false)
	public void save(GoodsInquiry entity) {
		if(entity != null && entity.getId() == null){
			entity.setCreateTime(new Date());
		}
		getDao().saveOrUpdate(entity);
	}
		
}

