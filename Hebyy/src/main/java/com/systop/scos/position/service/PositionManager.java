package com.systop.scos.position.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.position.model.Position;

/**
 *@author LinJie
 *@version 1.0
 *@create 2012-5-25 下午4:23:22
 */
@Service
public class PositionManager extends BaseGenericsManager<Position> {

	public Map<Integer, String> queryPosition(Integer deptId){
		String hql = "from Position p where p.dept.id = ?";
		List<Position> list = query(hql,deptId);
		Map<Integer, String> map = new HashMap<Integer, String>();
		for(Position position :list){
			map.put(position.getId(), position.getName());
		}
		return map;
	}
}
