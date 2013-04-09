package com.systop.scos.games.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.games.model.Games;

@Service
public class GamesManager extends BaseGenericsManager<Games> {

	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;

	/**
	 * 文档信息保存，第一次创建的时候保存createTime
	 */
	@Transactional
	public void save(Games games) {
		if (games != null) {
			if (games.getId() == null) {
				games.setDate(new Date());
			}
			// 当存在附件id时反向修改附件的类别信息
			fileAttchManager.updateFileType(games.getFileattchIds(), FileConstants.DOCUMENT);
			getDao().getHibernateTemplate().clear();//清除Hibernate缓存
			getDao().saveOrUpdate(games);
		}
	}
}
