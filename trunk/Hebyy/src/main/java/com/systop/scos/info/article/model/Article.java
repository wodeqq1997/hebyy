package com.systop.scos.info.article.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Type;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;
import com.systop.core.util.DateUtil;

/**
 * 文章内容
 * @author Nice
 */
@Entity
@Table(name = "articles")
@SuppressWarnings("serial")
public class Article extends BaseModel {

	// 主键
	private Integer id;

	// 标题
	private String title;

	// 文章来源
	private String source;

	// 内容
	private String content;

	// 创建时间
	private Date createTime;

	// 录入者
	private User creator;

	// 点击数
	private Integer hits = 0;

	// 附件
	private String fileAttchIds;
	
	//文章类型 
	private ArticleType articleType;
	
	//图片存储路径（首页显示滚动图片）
	private String articlePhoto;

	private List<ArticleComment> articleComments = new ArrayList<ArticleComment>(0);
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "source")
	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	
	@Type(type = "text")
	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	@Transient
	public String getCreateDate(){
		return DateUtil.getDateToString(createTime, "MM.dd");
	}

	
	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "creator_id")
	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public Integer getHits() {
		return hits;
	}

	public void setHits(Integer hits) {
		this.hits = hits;
	}

	@Column(name = "file_Attch_Ids")
	public String getFileAttchIds() {
		return fileAttchIds;
	}

	public void setFileAttchIds(String fileAttchIds) {
		this.fileAttchIds = fileAttchIds;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "article_type_id")
	public ArticleType getArticleType() {
		return articleType;
	}

	public void setArticleType(ArticleType articleType) {
		this.articleType = articleType;
	}

	@Column(name = "article_photo")
	public String getArticlePhoto() {
		return articlePhoto;
	}

	public void setArticlePhoto(String articlePhoto) {
		this.articlePhoto = articlePhoto;
	}

	@OneToMany(cascade = {CascadeType.REMOVE}, fetch = FetchType.LAZY, mappedBy = "article")
	public List<ArticleComment> getArticleComments() {
		return articleComments;
	}

	public void setArticleComments(List<ArticleComment> articleComments) {
		this.articleComments = articleComments;
	}
}
