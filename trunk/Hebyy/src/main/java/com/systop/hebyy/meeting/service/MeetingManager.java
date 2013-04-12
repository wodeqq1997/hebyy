package com.systop.hebyy.meeting.service;


import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.gzzd.model.Gzzd;
import com.systop.hebyy.gzzd.model.Zcxx;
import com.systop.hebyy.meeting.model.Meeting;
import com.systop.hebyy.meeting.model.MeetingType;

/**
 * 会议信息业务页面
 * 
 * @author WangYaping
 * 
 */
@Service
public class MeetingManager extends BaseGenericsManager<Meeting> {

	

	/**
	 * 通过id获得对象的值
	 */

	@Transactional
	public Meeting getMeetingByid(int id) {

		String hql = "from Meeting p where p.id = ? ";
		Meeting Meeting = findObject(hql, id);
		return Meeting;

	}
	@Transactional
	public void save(Meeting meeting, Integer typeId) {

		if (typeId != null) {
			meeting.setMeetingType(getDao().get(MeetingType.class, typeId));
		}

		save(meeting);

	}
	/**
	 * 通过类别目录id拿到一组对象
	 * 
	 * @param id
	 * @return
	 */
	public List<Meeting> queryByTypeId(Integer id) {

		StringBuffer hql = new StringBuffer("from Meeting p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (id != 0) {
			hql.append("and p.meetingType.id = ? ");
			args.add(id);
		}

		hql.append("order by p.id ");
		return query(hql.toString(), args.toArray());
	}

}
