package com.systop.scos.attendance.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.attendance.AttendanceConstants;
import com.systop.scos.attendance.model.PeopleAtt;
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

	@Autowired
	private TimeManager timeManager;

	public String index() {
		StringBuffer hql = new StringBuffer("from PeopleAtt p where 1 = 1 ");
		List<Object> args = new ArrayList<Object>();

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
	public String save() {
		Date date = new Date();
		Date standard = new Date();
		getModel().setPersion(getLoginUser());
		getModel().setPunchTime(standard);
		String time = null;// 时间
		if (StringUtils.isNotBlank(sta)) {
			time = timeManager.getTime(sta);
		}
		int hours = Integer.parseInt(time.split(":")[0]);
		int minutes = Integer.parseInt(time.split(":")[1]);
		date.setHours(hours);
		date.setMinutes(minutes);
		if (date.after(standard)
				&& (sta.equals(AttendanceConstants.AFTWORK) || sta
						.equals(AttendanceConstants.MORWORK))) {
			getModel().setStatus(AttendanceConstants.STATUS_LATER);
		} else if (date.before(standard)
				&& (sta.equals(AttendanceConstants.AFTOVEW) || sta
						.equals(AttendanceConstants.MOROVEW))) {
			getModel().setStatus(AttendanceConstants.STATUS_LATER);
		} else {
			getModel().setStatus(AttendanceConstants.STATUS_NORMAL);
		}
		save();
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

}
