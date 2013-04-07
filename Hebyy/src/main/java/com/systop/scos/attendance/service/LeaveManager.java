package com.systop.scos.attendance.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.DoubleUtil;
import com.systop.scos.attendance.model.Attendance;
import com.systop.scos.attendance.model.AttendanceItem;
import com.systop.scos.attendance.model.Leave;

/**
 * 
 * 考勤管理
 * 
 * @author SongBaoJie
 * 
 */
@Service
public class LeaveManager extends BaseGenericsManager<Leave> {

	@Autowired
	private UserManager userManager;

	/**
	 * 考勤信息保存
	 */
	@Transactional
	public void save(Attendance attendance, String[] personIds,
			String[] actualDays, String[] diseaseDays, String[] leaveDays,
			String[] lateCounts, String[] absentCounts, String[] itemIds) {
		if (attendance != null) {
			if (attendance.getId() == null) {
				attendance.setCreateTime(new Date());
			}
			getDao().saveOrUpdate(attendance);

			if (personIds == null) {
				throw new ApplicationException("考勤记录保存错误!");
			}
			// 保存考勤记录项
			for (int i = 0; i < personIds.length; i++) {
				AttendanceItem item = new AttendanceItem();
				if (itemIds != null && StringUtils.isNotBlank(itemIds[0])) {
					item.setId(Integer.valueOf(itemIds[i]));
				}
				// 得到考勤人员
				User person = userManager.get(Integer.valueOf(personIds[i]));
				item.setPerson(person);
				item.setActualDays(DoubleUtil.parseDouble(actualDays[i]));
				item.setDiseaseDays(DoubleUtil.parseDouble(diseaseDays[i]));
				item.setLeaveDays(DoubleUtil.parseDouble(leaveDays[i]));
				item.setLateCount(Integer.valueOf(lateCounts[i]));
				item.setAbsentCount(Integer.valueOf(absentCounts[i]));
				item.setAttendance(attendance);
				getDao().saveOrUpdate(item);
			}
		}
	}

	/**
	 * 根据部门ID得到员工信息
	 */
	public List<User> getUserByDeptId(Integer deptId) {
		List<User> list = userManager.query("from User u where u.dept.id=?",
				deptId);
		return list;
	}

	/**
	 * 验证考勤信息是否存在
	 * 
	 * @param attendanceDate
	 *            月份
	 * @param deptId
	 *            部门ID
	 * @return boolean
	 */
	public boolean isAttendance(Date attendanceDate, Integer deptId) {
		String hql = "select count(a.id) from Attendance a where a.attendanceDate = ? and a.dept.id = ?";
		Long count = (Long) getDao().findObject(hql, attendanceDate, deptId);
		return count > 0;
	}
}
