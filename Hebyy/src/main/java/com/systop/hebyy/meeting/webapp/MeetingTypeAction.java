package com.systop.hebyy.meeting.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.gzzd.model.Gzzd;
import com.systop.hebyy.gzzd.model.Zcxx;
import com.systop.hebyy.meeting.model.Meeting;
import com.systop.hebyy.meeting.model.MeetingType;
import com.systop.hebyy.meeting.service.MeetingManager;
import com.systop.hebyy.meeting.service.MeetingTypeManager;

/**
 * 会议类别信息
 * 
 * @author WangYaping
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class MeetingTypeAction extends DefaultCrudAction<MeetingType, MeetingTypeManager> {


	@Autowired
	private MeetingManager meetingManager;
	/**
	 * 查询
	 * 
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	public String index() {

		StringBuffer hql = new StringBuffer("from MeetingType p ");
		List<Object> args = new ArrayList<Object>();

		hql.append(" order by p.id ");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		items = page.getData();
		return "index";// 跳转到第一个页面

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
			
			List<Meeting> jds = meetingManager.queryByTypeId(id2);
			if (jds.size() != 0) {
				addActionMessage(getManager().get(id2).getHyLbMc()+",该类别已经使用，不能删除！");
			} else {
				MeetingType hy = getManager().get(id2);
				getManager().remove(hy);// 删除的方法
				addActionMessage("删除成功！");
			}	
		}
	
		return "success";
	}

	/**
	 * 保存的方法
	 * 
	 * @return
	 */
	@Override
	public String save() {
		// 主键为hilo策略，会自动的生成id。不需要手动给id赋值，当取得的id是空时，提示“添加成功”
		if (getModel().getId() == null) {
			addActionMessage("添加成功！");// 提示
		} else {
			addActionMessage("更新成功！");
		}
		super.save();

		return "success";
	}

}
