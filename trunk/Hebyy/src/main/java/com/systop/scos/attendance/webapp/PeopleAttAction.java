package com.systop.scos.attendance.webapp;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.attendance.AttendanceConstants;
import com.systop.scos.attendance.model.PeopleAtt;
import com.systop.scos.attendance.model.Time;
import com.systop.scos.attendance.service.PeopleAttManager;
import com.systop.scos.attendance.service.TimeManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class PeopleAttAction extends
		DefaultCrudAction<PeopleAtt, PeopleAttManager> {

	// 开始日期
	private Date startDate;

	// 结束日期
	private Date endDate;

	// 打卡标识
	private String sta;

	private boolean morWork;

	private boolean morOver;

	private boolean afWork;

	private boolean afOver;
	
	private Time time;
	@Autowired
	private TimeManager timeManager;

	public String index() {
		StringBuffer hql = new StringBuffer(
				"from PeopleAtt p where p.persion.id = ? ");
		List<Object> args = new ArrayList<Object>();

		args.add(getLoginUser().getId());
		if (startDate != null) {
			hql.append(" and p.punchTime > ? ");
			args.add(startDate);
		}

		if (endDate != null) {
			hql.append(" and p.punchTime < ? ");
			args.add(endDate);
		}

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	@SuppressWarnings("deprecation")
	public String edit() {
		Date date = new Date();
		PeopleAtt peopleAtt = getManager().findObject(
				"from PeopleAtt p where p.date >=? and p.date <=?",
				DateUtil.firstSecondOfDate(date),
				DateUtil.lastSecondOfDate(date));
		if (peopleAtt == null) {
			PeopleAtt people = new PeopleAtt();
			people.setPersion(getLoginUser());
			people.setDate(date);
			getManager().save(people);
			setModel(people);
		} else {
			setModel(peopleAtt);
		}
		Date standard = new Date();
		time = timeManager.findObject("from Time");
		standard.setHours(Integer.parseInt(time.getMorWork().split(":")[0]));
		standard.setMinutes(Integer.parseInt(time.getMorWork().split(":")[1]));
		if (date.after(DateUtil.add(standard, Calendar.HOUR,
				-Integer.parseInt(AttendanceConstants.TIME)))
				&& date.before(DateUtil.add(standard, Calendar.HOUR,
						Integer.parseInt(AttendanceConstants.TIME)))) {
			morWork = true;
			morOver = false;
			afWork = false;
			afOver = false;
		}
		standard.setHours(Integer.parseInt(time.getMorOver().split(":")[0]));
		standard.setMinutes(Integer.parseInt(time.getMorOver().split(":")[1]));
		if (date.after(DateUtil.add(standard, Calendar.HOUR,
				-Integer.parseInt(AttendanceConstants.TIME)))
				&& date.before(DateUtil.add(standard, Calendar.HOUR,
						Integer.parseInt(AttendanceConstants.TIME)))) {

			morWork = false;
			morOver = true;
			afWork = false;
			afOver = false;

		}
		standard.setHours(Integer.parseInt(time.getAfWork().split(":")[0]));
		standard.setMinutes(Integer.parseInt(time.getAfWork().split(":")[1]));
		if (date.after(DateUtil.add(standard, Calendar.HOUR,
				-Integer.parseInt(AttendanceConstants.TIME)))
				&& date.before(DateUtil.add(standard, Calendar.HOUR,
						Integer.parseInt(AttendanceConstants.TIME)))) {

			morWork = false;
			morOver = false;
			afWork = true;
			afOver = false;

		}
		standard.setHours(Integer.parseInt(time.getAfOver().split(":")[0]));
		standard.setMinutes(Integer.parseInt(time.getAfOver().split(":")[1]));
		if (date.after(DateUtil.add(standard, Calendar.HOUR,
				-Integer.parseInt(AttendanceConstants.TIME)))
				&& date.before(DateUtil.add(standard, Calendar.HOUR,
						Integer.parseInt(AttendanceConstants.TIME)))) {

			morWork = false;
			morOver = false;
			afWork = false;
			afOver = true;
		}
		return INPUT;
	}

	@SuppressWarnings("deprecation")
	public String save() {
		Date date = new Date();
		Date standard = new Date();
		getModel().setPersion(getLoginUser());
		String time = null;// 时间
		if (StringUtils.isNotBlank(sta)) {
			time = timeManager.getTime(sta);
		}
		int hours = Integer.parseInt(time.split(":")[0]);
		int minutes = Integer.parseInt(time.split(":")[1]);
		standard.setHours(hours);
		standard.setMinutes(minutes);
		if (sta.equals(AttendanceConstants.MORWORK)) {
			getModel().setMorWorkPunch(date);
			if (date.after(standard)) {
				getModel().setMorWorkStatus(AttendanceConstants.STATUS_LATER);
			} else {
				getModel().setMorWorkStatus(AttendanceConstants.STATUS_NORMAL);
			}
		} else if (sta.equals(AttendanceConstants.MOROVEW)) {
			getModel().setMorOverPunch(date);
			if (date.before(standard)) {
				getModel().setMorOverStatus(AttendanceConstants.STATUS_EARLY);
			} else {
				getModel().setMorOverStatus(AttendanceConstants.STATUS_NORMAL);
			}
		} else if (sta.equals(AttendanceConstants.AFTWORK)) {
			getModel().setAftWorkPunch(date);
			if (date.after(standard)) {
				getModel().setAftOverStatus(AttendanceConstants.STATUS_LATER);
			} else {
				getModel().setAftOverStatus(AttendanceConstants.STATUS_NORMAL);
			}
		} else {
			getModel().setAftOverPunch(date);
			if (date.before(standard)) {
				getModel().setAftOverStatus(AttendanceConstants.STATUS_EARLY);
			} else {
				getModel().setAftOverStatus(AttendanceConstants.STATUS_NORMAL);
			}
		}
		getModel().setDate(new Date());
		getManager().save(getModel());
		return SUCCESS;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getSta() {
		return sta;
	}

	public void setSta(String sta) {
		this.sta = sta;
	}

	public Time getTime() {
		return time;
	}

	public void setTime(Time time) {
		this.time = time;
	}

	public boolean isMorWork() {
		return morWork;
	}

	public void setMorWork(boolean morWork) {
		this.morWork = morWork;
	}

	public boolean isMorOver() {
		return morOver;
	}

	public void setMorOver(boolean morOver) {
		this.morOver = morOver;
	}

	public boolean isAfWork() {
		return afWork;
	}

	public void setAfWork(boolean afWork) {
		this.afWork = afWork;
	}

	public boolean isAfOver() {
		return afOver;
	}

	public void setAfOver(boolean afOver) {
		this.afOver = afOver;
	}

}
