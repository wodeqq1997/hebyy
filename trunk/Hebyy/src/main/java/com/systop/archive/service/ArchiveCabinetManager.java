package com.systop.archive.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.archive.model.ArchiveCabinet;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;

/**
 * 档案柜Service
 * 
 * @author SongBaoJie
 */
@Service
public class ArchiveCabinetManager extends BaseGenericsManager<ArchiveCabinet> {
	
	
	
	@Override
	@Transactional
	public void save(ArchiveCabinet entity) {
		if (getDao().exists(entity, "name")) {
			throw new ApplicationException("该【档案柜名称】已经存在,请您查证后再次录入");
		}
		super.save(entity);
	}

	/**
	 * 得到所有档案柜
	 * 
	 * @return
	 */
	public Map<Integer, String> getAllArchiveCabinet() {
		StringBuffer sql = new StringBuffer("from ArchiveCabinet a where 1=1");
		List<Object> args = new ArrayList<Object>();
		
		Map<Integer, String> typeMap = new HashMap<Integer, String>();
		List<ArchiveCabinet> list = query(sql.toString(), args.toArray());
		for (ArchiveCabinet ac : list) {
			typeMap.put(ac.getId(), ac.getName());
		}
		return typeMap;
	}
}
