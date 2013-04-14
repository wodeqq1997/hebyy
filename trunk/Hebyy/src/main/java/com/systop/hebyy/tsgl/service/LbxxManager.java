package com.systop.hebyy.tsgl.service;


import java.util.List;
import java.util.Map;


import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.tsgl.model.Lbxx;


/**
 * 图书类别业务类
 * @author WangYaping
 *
 */

@Service
public class LbxxManager extends BaseGenericsManager<Lbxx> {
	
	public List<Lbxx> queryAll() {
		String sql = "from Lbxx j";
		return query(sql);
	}
	
	/**
	 * 根据考点名称取到考点对象
	 * @param kdName
	 * @return
	 */
	@Transactional
    public Lbxx getZcxxByKdname(String lbName){
   
    	String hql="from Lbxx p where p.lbMc = ? ";
		 
    	Lbxx lbxx=findObject(hql, lbName);
    	return lbxx;
    	
    }
	/**
	 * 根据考点名称取到考点对象
	 * @param kdName
	 * @return
	 */

	@Transactional
    public Lbxx getLbxxByKdid(int id){
   
    	String hql="from Lbxx p where p.id = ? ";
		 
    	Lbxx lbxx=findObject(hql,id);
    	return lbxx;
    	
    }
	/**
	 * 用于下拉列表类型的数据源
	 */
	@SuppressWarnings("unchecked")
	public Map<Integer, String> getTypeMap(){
		List<Lbxx> lbxxItems = this.queryAll();
		Map<Integer, String> typeMap = new LinkedMap();
		for (Lbxx mt : lbxxItems) {
			typeMap.put(mt.getId(), mt.getLbMc());
		}
		return typeMap;
	}



}
