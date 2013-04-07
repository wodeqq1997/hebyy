package com.systop.forum.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.forum.model.Board;

/**
 * 论坛模块管理
 * 
 * @author GaoRuofan
 */
@Service
public class BoardManager extends BaseGenericsManager<Board> {

	@Autowired
	private TopicManager topicManager;

	/**
	 * 根据orderId排序,获得全部板块
	 * 
	 * @param count
	 * @return
	 */
	public List<Board> getOrberBoards() {
		String hql = "from Board b order by b.orderId";
		List<Board> boards = query(hql);
		for (Board board : boards) {
			loadLatestData(board);
		}
		return boards;
	}

	/**
	 * 为页面加在板块的最新显示数据
	 * 
	 * @param board
	 */
	public void loadLatestData(Board board) {
		if (board != null) {
			// 加载最新5条话题
			board.setLatestTopics(topicManager.getTopTopic(board, 5));
			// 统计板块话题数量
			board.setTopicCount(getTopicCount(board.getId()));
		}
	}

	/**
	 * 统计某板块的话题数量
	 * 
	 * @param boardId
	 * @return
	 */
	public Long getTopicCount(Integer boardId) {
		Long count = Long.valueOf(0);
		if (boardId != null) {
			String hql = "select count(t.id) from Topic t where t.board.id = ?";
			count = (Long) getDao().findObject(hql, boardId);
		}
		return count;
	}

}