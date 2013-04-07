package com.systop.scos.info.article.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.systop.core.dao.support.Page;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.info.article.model.ArticleComment;

/**
 * 文章评论管理
 * 
 * @author SongBaoJie
 */
@Service
@SuppressWarnings("unchecked")
public class ArticleCommentManager extends BaseGenericsManager<ArticleComment> {
	/**
	 * 得到最新评论
	 * 
	 * @param page 分页对象
	 * @param articleId 文章ID
	 * @return
	 * List<ArticleComment>
	 */
	public List<ArticleComment> getByArticleId(Page page,int articleId){
		page = getDao().pagedQuery(page, "from ArticleComment a where a.article.id = ? order by a.createTime asc", articleId);
		return page.getData();
	}
	
	/**
	 * 根据新闻ID删除所有评论 
	 * @param id
	 */
	public void removeCommentByArticleId(Integer id){
		//getDao().
	}
}
