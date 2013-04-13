package com.systop.hebyy.rule.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.meeting.model.MeetingType;
import com.systop.hebyy.rule.model.RuleType;

/**
 * 章程目录业务类
 * 
 * @author WangYaping
 * 
 */
@Service
public class RuleTypeManager extends BaseGenericsManager<RuleType> {

	/**
	 * 查询全部
	 * 
	 * @return
	 */
	public List<RuleType> queryAll() {
		String sql = "from RuleType j";
		return query(sql);
	}

	/**
	 * 根据名称取到对象
	 * 
	 * @param zcName目录名称
	 * @return
	 */
	@Transactional
	public RuleType getRuleTypeByKdname(String zcName) {

		String hql = "from RuleType p where p.zcMc = ? ";
		RuleType ruleType = findObject(hql, zcName);
		return ruleType;

	}

	/**
	 * 根据id取到对象
	 * 
	 * @param
	 * @return
	 */
	@Transactional
	public RuleType getRuleTypeByid(int id) {

		String hql = "from RuleType p where p.id = ? ";

		RuleType ruleType = findObject(hql, id);
		return ruleType;

	}
	
	/**
	 * 用于下拉列表类型的数据源
	 */
	@SuppressWarnings("unchecked")
	public Map<Integer, String> getTypeMap(){
		List<RuleType> ruleTypeItems = this.queryAll();
		Map<Integer, String> typeMap = new LinkedMap();
		for (RuleType mt : ruleTypeItems) {
			typeMap.put(mt.getId(), mt.getZcMc());
		}
		return typeMap;
	}

}
