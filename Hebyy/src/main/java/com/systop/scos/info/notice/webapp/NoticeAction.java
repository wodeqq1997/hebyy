package com.systop.scos.info.notice.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.dao.support.Page;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.info.notice.model.Notice;
import com.systop.scos.info.notice.service.NoticeManager;

/**
 * 通知公告管理
 * 
 * @author SongBaoJie
 */
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
@SuppressWarnings("serial")
public class NoticeAction extends DefaultCrudAction<Notice, NoticeManager> {

	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;

	// 首页显示通知公告条数
	private Integer viewCount;

	private List<Notice> notices;

	/**
	 * 查询显示通知公告管理
	 */
	public String index() {
		Page page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from Notice n where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		if (StringUtils.isNotBlank(getModel().getTitle())) {
			sql.append("and n.title like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getTitle()));
		}

		if (startDate != null) {
			sql.append(" and n.createTime >= ?");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		if (endDate != null) {
			sql.append(" and n.createTime <= ?");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}

		sql.append("order by n.createTime desc");
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 页面异步请求，获得最新的通知公告
	 * 
	 * @return
	 */
	public String indexNotices() {
		if (viewCount != null) {
			notices = getManager().getNotices(viewCount);
		}
		return "indexNotices";
	}

	/**
	 * 通知公告保存
	 */
	public String save() {
		if (getModel().getId() == null) {
			getModel().setCreator(getLoginUser());
		}
		return super.save();
	}

	/**
	 * 删除通知公告
	 */
	@Override
	public String remove() {
		if (getModel() != null && getModel().getId() != null)
			getManager().remove(getModel(), getServletContext());
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

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public List<Notice> getNotices() {
		return notices;
	}
}
