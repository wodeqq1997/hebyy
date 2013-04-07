package com.systop.scos.info.article.webapp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.dao.support.Page;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.info.article.model.Article;
import com.systop.scos.info.article.model.ArticleComment;
import com.systop.scos.info.article.service.ArticleCommentManager;
import com.systop.scos.info.article.service.ArticleManager;

/**
 * 文章评论信息Action,负责处理与之相关的各种请求
 * 
 * @author SongBaoJie
 */
@SuppressWarnings({ "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ArticleCommentAction extends DefaultCrudAction<ArticleComment, ArticleCommentManager> {
	
	@Autowired
	private ArticleManager articleManager;
	
	//文章ID
	private Integer articleId;
	
	// 开始时间
	private String startDate;

	// 结束时间
	private String endDate;
	
	public String commentIndex(){
		if(articleId != null){
			Page page = PageUtil.getPage(getPageNo(), getPageSize());
			StringBuffer sql = new StringBuffer("from ArticleComment a where 1=1 ");
			List<Object> args = new ArrayList<Object>();
			
			sql.append("and a.article.id = ? ");
			args.add(articleId);
			
			sql.append("order by a.createTime desc");
			page = getManager().pageQuery(page, sql.toString(), args.toArray());
			restorePageData(page);
		}
		return "commentIndex";
	}
	
	/**
	 * 查询显示文章评论信息
	 */
	public String index() {
		Page page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from ArticleComment a where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		if(getModel().getArticle() != null && getModel().getArticle().getId() != null){
			sql.append("and a.article.id = ? ");
			args.add(getModel().getArticle().getId());
		}
		
		try {
			if (StringUtils.isNotBlank(startDate)) {
				sql.append(" and a.createTime >= ? ");
				args.add(DateUtil.firstSecondOfDate(DateUtil
						.convertStringToDate("yyyy-MM-dd", startDate)));
			}
			if (StringUtils.isNotBlank(endDate)) {
				sql.append(" and a.createTime <= ?");
				args.add(DateUtil.lastSecondOfDate(DateUtil
						.convertStringToDate("yyyy-MM-dd", endDate)));
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		sql.append("order by a.createTime desc");
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	@Override
	public String save() {
		if(getModel() != null){
			getModel().setCreateTime(new Date());
		}
		if(articleId != null){
			Article article = articleManager.get(articleId);
			getModel().setArticle(article);
		}
		return super.save();
	}

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
