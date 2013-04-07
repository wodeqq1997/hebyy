package com.systop.scos.info.article.service;

import java.util.Date;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.info.article.model.Article;

/**
 * 文章信息管理，涉及相关业务及数据库操作等
 * 
 * @author SongBaoJie
 */
@Service
public class ArticleManager extends BaseGenericsManager<Article> {
	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;
	
	/**
	 * 文章信息保存，第一次创建的时候保存createTime
	 */
	@Transactional
	public void save(Article article) {
		if (article != null) {
			if (article.getId() == null) {
				article.setCreateTime(new Date());
			}
			// 当存在附件id时反向修改附件的类别信息
			fileAttchManager.updateFileType(article.getFileAttchIds(),
					FileConstants.ARTICLE);
			getDao().saveOrUpdate(article);
		}
	}

	/**
	 * 删除文章的同时删除附件以及评论
	 * @param entity
	 * @param context
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void remove(Article entity, ServletContext context) {
		if(entity.getFileAttchIds() != null && entity.getFileAttchIds().length() > 0){
			fileAttchManager.removeByIds(entity.getFileAttchIds(), context);					
		}
		super.remove(entity);
	}
	
	/**
	 * 修改浏览次数累加1
	 * @param articleId
	 */
	@Transactional
	public void updateArticleHits(int id){
		Article article = this.get(id);
		if(article != null){
			article.setHits(article.getHits() + 1);	
		}
		this.save(article);
	}
}
