package com.systop.scos.attendance.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.DoubleUtil;
import com.systop.scos.attendance.AttendanceConstants;
import com.systop.scos.attendance.model.ReportedAtte;

/**
 * @author LinJie
 * @version 1.0
 * @create 2012-6-11 下午3:55:03
 */
@Service
public class ReportedAtteManager extends BaseGenericsManager<ReportedAtte> {

	@Autowired
	private UserManager userManager;

	/**
	 * 保存
	 * 
	 * @param id
	 * @param diseaseDays
	 * @param leaveDays
	 * @param lateCounts
	 * @param absentCounts
	 * @param marks
	 * @param ?
	 */
	@Transactional
	public void save(String[] id, String[] diseaseDays, String[] leaveDays,
			String[] lateCounts, String[] absentCounts, String[] marks,
			Date date) {
		for (int i = 1; i < id.length; i++) {
			ReportedAtte reported = new ReportedAtte();
			User user = userManager.get(Integer.valueOf(id[i]));
			reported.setUser(user);
			reported.setDept(user.getDept());
			reported.setAbsentCount(Integer.valueOf(absentCounts[i]));
			reported.setDiseaseDay(DoubleUtil.parseDouble(diseaseDays[i]));
			reported.setLateCount(Integer.valueOf(lateCounts[i]));
			reported.setLeaveDay(DoubleUtil.parseDouble(leaveDays[i]));
			reported.setDate(date);
			reported.setMark(marks[i]);
			reported.setStatus(AttendanceConstants.STATUS_NOREPORTED);
			save(reported);
		}
	}

	@SuppressWarnings("unchecked")
	public Object[] getTotal(Integer id, Date date) {
		String hql = "select sum(r.absentCount),sum(r.diseaseDay),sum(r.lateCount),sum(r.leaveDay) " +
				"from ReportedAtte r where r.user.id = ? and r.date >= ? and r.date <= ?";
		List<Object> args = new ArrayList<Object>();
		args.add(id);
		args.add(date);
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.set(Calendar.DATE, calendar
		        .getActualMaximum(Calendar.DATE));
		args.add(calendar.getTime());
		List<Object> list  = getDao().query(hql, args.toArray());
		return (Object[])list.get(0);
	}

}
