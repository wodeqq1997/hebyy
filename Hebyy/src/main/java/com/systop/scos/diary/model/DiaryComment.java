package com.systop.scos.diary.model;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

import javax.persistence.*;
import java.util.Date;

/**
 * 项目日志评论
 * @author SongBaojie
 */
@Entity
@Table(name = "diary_comments")
@SuppressWarnings("serial")
public class DiaryComment extends BaseModel {
	
	// 主键
	private Integer id;

	// 内容
	private String content;
	
	// 评论人
	private User user;
	
	// 创建时间
	private Date createTime;
	
	// 新闻
	private Diary diary;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "content", length = 500)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "diary_id")
	public Diary getDiary() {
		return diary;
	}

	public void setDiary(Diary diary) {
		this.diary = diary;
	}
}
