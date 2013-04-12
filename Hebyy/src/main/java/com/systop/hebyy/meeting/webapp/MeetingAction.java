package com.systop.hebyy.meeting.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.meeting.model.Meeting;
import com.systop.hebyy.meeting.model.MeetingType;
import com.systop.hebyy.meeting.service.MeetingManager;
import com.systop.hebyy.meeting.service.MeetingTypeManager;

/**
 * 会议信息
 * 
 * @author WangYaping
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class MeetingAction extends DefaultCrudAction<Meeting, MeetingManager> {

	

	@Autowired
	MeetingTypeManager meetingTypeManager;

	/**
	 * 条件查询
	 * 
	 * @return
	 * @throws ParseException
	 */
	public String queryxx() throws ParseException {

	    this.queryMeeting();//调用私有的查询方法
		return "index";// 跳转到第一个页面

	}

	/**
	 * 条件查询（用于普通用户的条件查询）
	 * 
	 * @return
	 * @throws ParseException
	 */

	public String queryxx1() throws ParseException {

	    this.queryMeeting();//调用私有的查询方法	
		return "index1";// 跳转到第一个页面

	}
	
	@SuppressWarnings("unchecked")
	private void queryMeeting(){
		
	
		// 获取输入的条件
		String hymc = getModel().getHyMc();//会议名称
		Date startTime = getModel().getStartTime();//开始日期
		Date endTime = getModel().getEndTime();//结束日期

		StringBuffer hql = new StringBuffer("from Meeting p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		//按会议文件名称模糊查询
		if (StringUtils.isNotBlank(hymc)) {
			hql.append("and p.hyMc like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(hymc));
		}
       
		// 按类别进行查询
		if ( getModel().getMeetingType()!=null&&getModel().getMeetingType().getId()!=null) {
			hql.append("and p.meetingType.id = ?  ");
			args.add(getModel().getMeetingType().getId());
		}
		
        //开始日期
		if (startTime != null) {
			hql.append("and p.hyTime >= ?  ");
			args.add(DateUtil.firstSecondOfDate(startTime));
		}
		
        //终止日期
		if (endTime != null) {
			hql.append("and p.hyTime <= ?  ");
			args.add(DateUtil.lastSecondOfDate(endTime));
		}

		hql.append("order by p.hyTime ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		
	}

	/**
	 * 查询全部，重定向，不带值（管理用户查询用）
	 * @return
	 */
	public String toAll() {
		return "success";//跳转的首页
	}

	/**
	 * 查询全部，重定向，不带值（普通用户查询用）
	 * @return
	 */
	public String toAll1() {
		return "success1";//跳转的首页
	}

	/**
	 * 删除的方法
	 * 
	 * @return
	 */
	@Override
	public String remove() {
		String ids = getRequest().getParameter("ids");
		String[] id = ids.split(",");

		for (String id1 : id) {
			int id2 = Integer.parseInt(id1);
			Meeting hy = getManager().getMeetingByid(id2);
			getManager().remove(hy);// 删除的方法
		}
		addActionMessage("删除成功！");
		return "success";
	}

	/**
	 * 保存的方法
	 * 
	 * @return
	 */
	@Override
	public String save() {
		
		
		getManager().getDao().getHibernateTemplate().clear();
		getManager().save(getModel(), getModel().getMeetingType().getId());
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”
		if (getModel().getId() == null) {

			addActionMessage("添加成功！");// 提示
		} else {
			addActionMessage("更新成功！");
		}
		return "success";
	}

	/**
	 * 跳转到编辑页面
	 */
	@Transactional
	public String toEdit() {

		return "input";
	}

	/**
	 * 获得类型下拉列表数据源
	 * @return
	 */
	public Map<Integer, String> getTypeMap() {
		return meetingTypeManager.getTypeMap();
	}

	
}
