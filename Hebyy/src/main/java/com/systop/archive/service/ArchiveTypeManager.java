package com.systop.archive.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.archive.model.ArchiveType;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;

/**
 * 档案类型Service
 * 
 * @author SongBaoJie
 */
@Service
public class ArchiveTypeManager extends BaseGenericsManager<ArchiveType> {
	
	
	
	@Override
	@Transactional
	public void save(ArchiveType entity) {
		if (getDao().exists(entity, "name")) {
			throw new ApplicationException("该档案类别名称已经存在,请您查证后再次录入");
		}
		super.save(entity);
	}

	/**
	 * 得到所有档案类型
	 * 
	 * @return
	 */
	public Map<Integer, String> getAllArchiveType() {
		StringBuffer sql = new StringBuffer("from ArchiveType at where 1=1");
		List<Object> args = new ArrayList<Object>();
		
		
		Map<Integer, String> typeMap = new HashMap<Integer, String>();
		List<ArchiveType> list = query(sql.toString(), args.toArray());
		for (ArchiveType p : list) {
			typeMap.put(p.getId(), p.getName());
		}
		return typeMap;
	}

//    public Map<Integer, String> getAll(){
//        List<ArchiveType> list = new ArrayList<ArchiveType>();
//        Map<Integer, String> map = new HashMap<Integer, String>();
//        list = get();//all
//        for (ArchiveType a : list) {
//            map.put(a.getId(), a.getName());
//        }
//        return map ;
//    }
}
