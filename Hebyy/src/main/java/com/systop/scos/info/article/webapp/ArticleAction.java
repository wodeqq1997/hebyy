package com.systop.scos.info.article.webapp;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.dao.support.Page;
import com.systop.core.util.DateUtil;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.core.webapp.upload.UpLoadUtil;
import com.systop.scos.info.article.model.Article;
import com.systop.scos.info.article.model.ArticleComment;
import com.systop.scos.info.article.model.ArticleType;
import com.systop.scos.info.article.service.ArticleCommentManager;
import com.systop.scos.info.article.service.ArticleManager;
import com.systop.scos.info.article.service.ArticleTypeManager;

/**
 * 文章信息Action,负责处理与之相关的各种请求
 * 
 * @author SongBaoJie
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ArticleAction extends DefaultCrudAction<Article, ArticleManager> {

	@Autowired
	private ArticleTypeManager articleTypeManager;

	@Autowired
	private ArticleCommentManager articleCommentManager;

	// 开始时间
	private Date startDate;

	// 结束时间
	private Date endDate;

	// 文章评论
	private ArticleComment articleComment;

	private List<Map<String, Object>> indexArticles;

	// 首页显示文章条数
	private Integer viewCount;
	
	//新闻文章图片
	private File photo;
	
	//新闻文章图片名称
	private String photoFileName;
	
	//新闻文章图片保存路径
	private String photoFolder = "/uploads/articles/";

	// 查看浏览是，判断是否只查看图片新闻
	private String isArticlePhotos;
	
	//新闻类别id
	private Integer articleTypeId;
	
	private int selfPageNo;
	
	/**
	 * 查询显示文章信息管理页
	 */
	public String index() {
		Page page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from Article a where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		if (StringUtils.isNotBlank(getModel().getTitle())) {
			sql.append("and a.title like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getTitle()));
		}

		if(getModel().getArticleType() != null && getModel().getArticleType().getId() != null){
			sql.append("and a.articleType.id = ? ");
			args.add(getModel().getArticleType().getId());
		}
		
		if(StringUtils.isNotBlank(isArticlePhotos)){
			sql.append("and a.articlePhoto != null ");
		}
		
		if (startDate != null) {
			sql.append("and a.createTime >= ? ");
			args.add(DateUtil.firstSecondOfDate(startDate));
		}
		
		if (endDate != null) {
			sql.append("and a.createTime <= ? ");
			args.add(DateUtil.lastSecondOfDate(endDate));
		}

		sql.append("order by a.createTime desc");
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 首页AJAX请求，最新文章
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String indexArticles() {
		StringBuffer hql = new StringBuffer("from Article a where a.id > 0 ");
		List<Object> args = new ArrayList<Object>();
		ArticleType type = getModel().getArticleType();
		if (type != null && type.getId() != null) {
			hql.append("and a.articleType.id = ? ");
			args.add(type.getId());
		}
		
		hql.append("order by a.createTime desc");
		page = PageUtil.getPage(1, viewCount);
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		indexArticles = toMapList(page.getData());
		return "indexArticles";
	}
	
	/**
	 * 首页AJAX请求，最新图片新闻 
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String indexArticlePhotos() {
		StringBuffer hql = new StringBuffer("from Article a where a.id > 0 and a.articlePhoto != null");

		hql.append(" order by a.createTime desc");
		page = PageUtil.getPage(1, viewCount);
		page = getManager().pageQuery(page, hql.toString());
		indexArticles = toMapList(page.getData());
		return "indexArticlePhotos";
	}

	
	//封装入map
	private List<Map<String,Object>> toMapList(List<Article> items){
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		for(Article a : items){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", a.getId());
			map.put("title", a.getTitle());
			map.put("createDate", a.getCreateDate());
			map.put("articleType", a.getArticleType().getName());
			map.put("articleTypeId", a.getArticleType().getId());
			map.put("articlePhoto", a.getArticlePhoto());
			list.add(map);
		}
		return list;
	}

	/**
	 * 文章信息保存
	 */
	public String save() {
		if (getModel().getId() == null) {
			getModel().setCreator(getLoginUser());
		}
		if(photoFileName != null && !photoFileName.equals("")){
			String photoPath = upLoadFile();
			getModel().setArticlePhoto(photoPath);
		}
		if(articleTypeId != null){
			ArticleType articleType = getManager().getDao().get(ArticleType.class, articleTypeId);
			getModel().setArticleType(articleType);
		}
		return super.save();
	}

	//保存图片方法
	private String upLoadFile() {
		//保存新图片
		photoFolder += DateUtil.getDateToString(new Date(), "yyyy-MM") + "/";
		String newPhotoPath = UpLoadUtil.doUpload(photo, photoFileName, photoFolder, getServletContext());
		//删除就图片
		delArticlePhoto();
		return newPhotoPath;
	}
	
	/**
	 * 删除文章图片
	 */
	private void delArticlePhoto(){
		String oldPhotoPath = getModel().getArticlePhoto();
		if(oldPhotoPath != null && !oldPhotoPath.equals("")){
		    File oldPhotoFile = new File(getServletContext().getRealPath(oldPhotoPath));
		    oldPhotoFile.delete();
		}
	}
	
	/**
	 * 保存文章评论
	 */
	public String saveArticleComment() {
		if (getModel() != null && getModel().getId() != null) {
			Article article = getManager().get(getModel().getId());
			articleComment.setArticle(article);
			articleComment.setCreateTime(new Date());
			// 发表评论
			articleCommentManager.save(articleComment);
		}
		return "save_article_comment";
	}

	/**
	 * 查看文章
	 */
	@Override
	public String view() {
		getRequest().setAttribute("author", getLoginUser().getName());
		if (getModel() != null && getModel().getId() != null) {
			// 修改浏览次数
			getManager().updateArticleHits(getModel().getId());
			
			if (selfPageNo == 0 || selfPageNo < 0){
				selfPageNo = 1;
			}
			page = PageUtil.getPage(selfPageNo, 5);
			String hql = "from ArticleComment a where 1=1 and a.article.id = ? order by a.createTime desc";
			Object[] args = new Object[] { getModel().getId()};
			page = getManager().pageQuery(page, hql, args);
			restorePageData(page);
		}
		return VIEW;
	}

	/**
	 * 删除文章
	 */
	@Override
	public String remove() {
		if (getModel() != null && getModel().getId() != null){
			getManager().remove(getModel(), getServletContext());
			// 删除图片
			delArticlePhoto();			
		}
		return SUCCESS;
	}

	/**
	 * 所有文章类型MAP
	 * 
	 * @return Map
	 */
	@SuppressWarnings("rawtypes")
	public Map getArticleTypeMap() {
		return articleTypeManager.getAllArticleType();
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

	public ArticleComment getArticleComment() {
		return articleComment;
	}

	public void setArticleComment(ArticleComment articleComment) {
		this.articleComment = articleComment;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public List<Map<String, Object>> getIndexArticles() {
		return indexArticles;
	}

	public File getPhoto() {
		return photo;
	}

	public void setPhoto(File photo) {
		this.photo = photo;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}

	public String getIsArticlePhotos() {
		return isArticlePhotos;
	}

	public void setIsArticlePhotos(String isArticlePhotos) {
		this.isArticlePhotos = isArticlePhotos;
	}

	public Integer getArticleTypeId() {
		return articleTypeId;
	}

	public void setArticleTypeId(Integer articleTypeId) {
		this.articleTypeId = articleTypeId;
	}
	
	public int getSelfPageNo() {
		return selfPageNo;
	}

	public void setSelfPageNo(int selfPageNo) {
		this.selfPageNo = selfPageNo;
	}
}
