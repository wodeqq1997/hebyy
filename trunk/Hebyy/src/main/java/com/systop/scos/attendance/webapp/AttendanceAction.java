package com.systop.scos.attendance.webapp;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.dept.service.DeptManager;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.Constants;
import com.systop.core.util.DoubleUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.attendance.model.Attendance;
import com.systop.scos.attendance.model.AttendanceItem;
import com.systop.scos.attendance.service.AttendanceManager;
import com.systop.scos.attendance.service.ReportedAtteManager;

/**
 * 考勤管理Action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AttendanceAction extends
		DefaultCrudAction<Attendance, AttendanceManager> {

	@Autowired
	private DeptManager deptManager;

	@Autowired
	private ReportedAtteManager reporteManager;
	// 部门ID
	private String deptId;

	private Integer dateYear;

	private Date dateMonth;
	
	private Map<String, Object> result;

	/**
	 * 显示考勤信息
	 */
	public String index() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from Attendance a where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (getModel().getDept() != null
				&& getModel().getDept().getId() != null) {
			sql.append("and a.dept.id = ?");
			args.add(getModel().getDept().getId());
			getModel().setDept(deptManager.get(getModel().getDept().getId()));
		}

		if (dateYear != null) {
			sql.append("and year(a.attendanceDate) = ? ");
			args.add(dateYear);
		}

		sql.append("order by a.createTime desc");
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 考勤编辑
	 */
	public String edit() {
		if (getModel().getId() == null) {
			// 得到默认缺省出勤天数
			getModel().setShouldDays(
					DoubleUtil.parseDouble(Constants.DEFAULT_ATTENDANCE_DAY));
		}
		return INPUT;
	}

	/**
	 * 异步验证考勤是否存在
	 */
	public String isAttendance() {
		result = new HashMap<String, Object>();
		if (getModel() != null) {
			// 根据日期和部门ID判断考勤是否存在
			boolean b = getManager().isAttendance(
					getModel().getAttendanceDate(),
					getModel().getDept().getId());
			result.put("success", b);
		} else {
			result.put("error", true);
		}
		return "attendanceJson";
	}

	/**
	 * 选择部门后添加员工
	 */
	public String showPerson() {
		if (getModel() != null) {
			List<AttendanceItem> itemList = new ArrayList<AttendanceItem>();
			// 得到该部门下所有员工
			List<User> list = getManager().getUserByDeptId(
					getModel().getDept().getId());
			// 设置部门
			getModel().setDept(
					getManager().getDao().get(Dept.class,
							getModel().getDept().getId()));
			for (User u : list) {
				AttendanceItem item = new AttendanceItem();
				Object[] objs = reporteManager.getTotal(u.getId(), getModel()
						.getAttendanceDate());
				Double lessDays = 0D;
				if(objs[0] != null){
					item.setAbsentCount(Integer.valueOf(objs[0].toString()));
				}
				if(objs[1] != null){
					item.setDiseaseDays(DoubleUtil.parseDouble (objs[1].toString()));
					lessDays = lessDays + DoubleUtil.parseDouble (objs[1].toString());
				}
				if(objs[2] != null){
					item.setLateCount(Integer.valueOf(objs[2].toString()));
				}
				if(objs[3] != null){
					item.setLeaveDays(DoubleUtil.parseDouble (objs[3].toString()));
					lessDays = lessDays + DoubleUtil.parseDouble (objs[3].toString());
				}
				item.setActualDays(getModel().getShouldDays() - lessDays);
				// 员工
				item.setPerson(u);
				itemList.add(item);
			}
			getModel().setItems(itemList);
			// 保存员工人员数量，用于页面判断输出
			getRequest().setAttribute("itemsSize", itemList.size());
		}
		return INPUT;
	}

	/**
	 * 考勤保存
	 */
	public String save() {
		if (getModel().getId() == null) {
			getModel().setUser(getLoginUser());
		}
		String[] personIds = getRequest().getParameterValues("personIds");
		String[] actualDays = getRequest().getParameterValues("actualDays");
		String[] diseaseDays = getRequest().getParameterValues("diseaseDays");
		String[] leaveDays = getRequest().getParameterValues("leaveDays");
		String[] lateCounts = getRequest().getParameterValues("lateCounts");
		String[] absentCounts = getRequest().getParameterValues("absentCounts");
		String[] itemIds = getRequest().getParameterValues("itemIds");
        String[] notes = getRequest().getParameterValues("remark");
        String[] outDays = getRequest().getParameterValues("outDays");
        String[] inDays = getRequest().getParameterValues("inDays");
		getManager().save(getModel(), personIds, actualDays, diseaseDays,
				leaveDays, lateCounts, absentCounts, itemIds,notes,outDays,inDays);
		// return INPUT;
		return SUCCESS;
	}
	
	/**
	 * 工资上传：导出模板(导出的是根据月份得到所有员工考勤信息)
	 * @author SongBaojie
	 */
	public String wageTemplate(){
		if(dateMonth == null){
			return "wageTemplate";
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateMonth);
		
		StringBuffer sql = new StringBuffer("from AttendanceItem a where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		sql.append("and year(a.attendance.attendanceDate) = ? and month(a.attendance.attendanceDate) = ? ");
		args.add(cal.get(Calendar.YEAR));
		args.add(cal.get(Calendar.MONTH) + 1);

		sql.append("order by a.attendance.dept.serialNo");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return "wageTemplate";
	}
	

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public Integer getDateYear() {
		return dateYear;
	}

	public void setDateYear(Integer dateYear) {
		this.dateYear = dateYear;
	}

	public Date getDateMonth() {
		return dateMonth;
	}

	public void setDateMonth(Date dateMonth) {
		this.dateMonth = dateMonth;
	}
	
}
