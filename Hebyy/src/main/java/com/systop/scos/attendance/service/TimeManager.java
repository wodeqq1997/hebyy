package com.systop.scos.attendance.service;

import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.attendance.AttendanceConstants;
import com.systop.scos.attendance.model.Time;

@Service
public class TimeManager extends BaseGenericsManager<Time> {

	public String getTime(String time) {
		String hql = "from Time t ";
		Time time2 = findObject(hql);
		if (time.equals(AttendanceConstants.AFTOVEW)) {
			return time2.getAfOver();
		}else if(time.equals(AttendanceConstants.AFTWORK)){
			return time2.getAfWork();
		}else if(time.equals(AttendanceConstants.MOROVEW)){
			return time2.getMorOver();
		}else {
			return time2.getMorWork();
		}
	}

}
