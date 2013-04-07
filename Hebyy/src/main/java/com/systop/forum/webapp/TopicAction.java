package com.systop.forum.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.forum.model.Board;
import com.systop.forum.model.Topic;
import com.systop.forum.service.TopicManager;

/**
 * 发帖管理Action,负责处理与之相关的各种请求
 * 
 * @author GaoRuofan
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class TopicAction extends DefaultCrudAction<Topic, TopicManager> {

	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;

	// 板块ID(页面参数)
	private Integer boardId;

	// 首页显示的话题
	private List<Map<String, Object>> topics;

	private Integer viewCount;
	
	private String loginUserName;
	
	private int selfPageNo;

	/**
	 * 编辑，添加话题
	 */
	@Override
	public String edit() {
		if (boardId != null) {
			getModel().setBoard(getBoard(boardId));
		}
		return INPUT;
	}

	// 获得板块
	private Board getBoard(Integer id) {
		return getManager().getDao().get(Board.class, id);
	}

	/**
	 * 发帖保存
	 */
	public String save() {
		if (getModel().getId() == null) {
			getModel().setSender(getLoginUser());
		}
        String returner = null;
        if (getModel().getId() == null){
            returner = "saveTopicSuccess";
        }
        else {
            returner = "editTopicSuccess";
        }
		getManager().save(getModel());
		return returner;
	}

	/**
	 * 回复保存
	 */
	public String saveReTopic() {
		getModel().setSender(getLoginUser());
		getManager().saveReTopic(getModel());
		return "reTopicSuccess";
	}

	/**
	 * 查看帖子及回复记录
	 */
	@Override
	public String view() {
		if (getModel() != null) {
			if (selfPageNo == 0 || selfPageNo < 0){
				selfPageNo = 1;
			}
			page = PageUtil.getPage(selfPageNo, 10);
			String hql = "from Topic t where t.id = ? or t.parent.id = ? order by t.createTime";
			Object[] args = new Object[] { getModel().getId(),
					getModel().getId() };
			page = getManager().pageQuery(page, hql, args);
			restorePageData(page);
		}
		loginUserName =  getLoginUser().getName();
		return VIEW;
	}

	/**
	 * 查询显示发帖信息
	 */
	public String index() {
		page = PageUtil.getPage(getPageNo(), getPageSize());

		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer(
				"from Topic t where t.parent.id is null");
		if (StringUtils.isNotBlank(getModel().getTitle())) {
			hql.append(" and t.title like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getTitle()));
		}
		if (boardId != null) {// 根据版块查询
			hql.append(" and t.board.id = ?");
			args.add(boardId);
			getModel().setBoard(getBoard(boardId));
		}
		if (startDate != null) {
			hql.append(" and t.createTime >= ?");
			args.add(startDate);
		}
		if (endDate != null) {
			hql.append(" and t.createTime <= ?");
			args.add(endDate);
		}

		hql.append(" order by t.createTime desc");
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 得到模块所有帖子
	 * */
	public String topicIndex() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		if (boardId != null) {
			String hql = "from Topic t  where t.board.id= ? order by t.createTime desc";
			getManager().pageQuery(page, hql, boardId);
			restorePageData(page);
			getModel().setBoard(getBoard(boardId));
		}
		return "topicIndex";
	}

	/**
	 * 首页AJAX调用，查看最新主题
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String indexTopics() {
		if (viewCount != null) {
			String hql = "from Topic t where t.parent is null order by t.createTime desc";
			page = PageUtil.getPage(1, viewCount);
			page = getManager().pageQuery(page, hql);
			topics = toMapList(page.getData());
		}
		return "indexTopics";
	}

	// 封装入map
	private List<Map<String, Object>> toMapList(List<Topic> items) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (Topic a : items) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", a.getId());
			map.put("title", a.getTitle());
			map.put("createDate",
					DateUtil.getDateToString(a.getCreateTime(), "MM.dd"));
			list.add(map);
		}
		return list;
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

	public Integer getBoardId() {
		return boardId;
	}

	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}

	public List<Map<String, Object>> getTopics() {
		return topics;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public String getLoginUserName() {
		return loginUserName;
	}

	public int getSelfPageNo() {
		return selfPageNo;
	}

	public void setSelfPageNo(int selfPageNo) {
		this.selfPageNo = selfPageNo;
	}
	
}
