package com.systop.forum.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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

import org.hibernate.annotations.Type;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 论坛 帖子
 * 
 * @author GaoRuofan
 */

@SuppressWarnings("serial")
@Entity
@Table(name = "topics")
public class Topic extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 主题，标题 */
	private String title;

	/** 发送者 */
	private User sender;

	/** 板块 */
	private Board board;

	/** 内容 */
	private String content;

	/** 创建时间 */
	private Date createTime;

	/** 回复的主题 */
	private Topic parent;

	/** 帖子回复数量 */
	private long reCount = 0;

	/** 主题对应的回帖集合 */
	private Set<Topic> reTopics = new HashSet<Topic>(0);

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

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "sender_id")
	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "board_id")
	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
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

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id")
	public Topic getParent() {
		return parent;
	}

	public void setParent(Topic parent) {
		this.parent = parent;
	}

	@Column(name = "re_count")
	public long getReCount() {
		return reCount;
	}

	public void setReCount(long reCount) {
		this.reCount = reCount;
	}

	@OneToMany(cascade = { CascadeType.REMOVE }, fetch = FetchType.LAZY, mappedBy = "parent")
	public Set<Topic> getReTopics() {
		return reTopics;
	}

	public void setReTopics(Set<Topic> reTopics) {
		this.reTopics = reTopics;
	}

}
