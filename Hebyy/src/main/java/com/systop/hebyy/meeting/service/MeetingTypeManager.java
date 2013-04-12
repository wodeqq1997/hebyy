package com.systop.hebyy.meeting.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;


import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.meeting.model.MeetingType;

/**
 * 会议类别
 * @author WangYaping
 *
 */
@Service
public class MeetingTypeManager  extends BaseGenericsManager<MeetingType> {
	
	/**
	 * 查询全部
	 * 
	 * @return
	 */
	public List<MeetingType> queryAll() {
		String sql = "from MeetingType j";
		return query(sql);
	}
	
	/**
	 * 用于下拉列表类型的数据源
	 */
	@SuppressWarnings("unchecked")
	public Map<Integer, String> getTypeMap(){
		List<MeetingType> meetingTypeItems = this.queryAll();
		Map<Integer, String> typeMap = new LinkedMap();
		for (MeetingType mt : meetingTypeItems) {
			typeMap.put(mt.getId(), mt.getHyLbMc());
		}
		return typeMap;
	}
	
	
	
	
}
