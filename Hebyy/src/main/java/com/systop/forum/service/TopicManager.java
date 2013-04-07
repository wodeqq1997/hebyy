package com.systop.forum.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.dao.support.Page;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.PageUtil;
import com.systop.forum.model.Board;
import com.systop.forum.model.Topic;

/**
 * 发帖信息管理，涉及相关业务及数据库操作等
 * 
 * @author GaoRuofan
 */
@Service
public class TopicManager extends BaseGenericsManager<Topic> {

	/**
	 * 按照时间排序，获得某板块count给定长度的最新话题
	 */
	@SuppressWarnings("unchecked")
	public List<Topic> getTopTopic(Board board, Integer count) {
		Page page = PageUtil.getPage(1, count);
		String hql = "from Topic t where t.board.id = ? order by t.createTime";
		return pageQuery(page, hql, board.getId()).getData();
	}

	/**
	 * 统计某帖子的回帖数量
	 * 
	 * @param topicId
	 * @return
	 */
	public Long getTopicCommentCount(Integer topicId) {
		Long count = Long.valueOf(0);
		if (topicId != null) {
			String hql = "select count(t.id) from TopicComment t where t.topic.id = ?";
			count = (Long) getDao().findObject(hql, topicId);
		}
		return count;
	}

	/**
	 * 保存
	 */
	@Transactional
	public void save(Topic topic) {
		if (topic != null) {
			if (topic.getId() == null) {
				topic.setCreateTime(new Date());
			}
			getDao().saveOrUpdate(topic);
		}
	}

	/**
	 * 保存回复
	 */
	@Transactional
	public void saveReTopic(Topic topic) {
		save(topic);
		if(topic != null){
			Topic parent = topic.getParent();
			if (parent != null){
				parent = get(parent.getId());
				parent.setReCount(parent.getReCount() + 1);
				save(parent);
			}
		}
	}
}
