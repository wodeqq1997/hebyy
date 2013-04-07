package com.systop.forum.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.systop.core.model.BaseModel;

/**
 * 论坛板块
 * 
 * @author GaoRuofan
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "boards")
public class Board extends BaseModel {

	/** 主键 */
	private Integer id;

	/** 板块名称 */
	private String name;

	/** 描述 */
	private String descn;

	/** 排序用id */
	private Integer orderId;

	/** 板块包含的帖子 */
	private List<Topic> topics;

	/** 存放最近发表帖子 */
	private List<Topic> latestTopics;

	/** 板块下帖子数量 */
	private Long topicCount;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "descn", length = 2000)
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@Column(name = "order_id")
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.LAZY, mappedBy = "board")
	public List<Topic> getTopics() {
		return topics;
	}

	public void setTopics(List<Topic> topics) {
		this.topics = topics;
	}

	@Transient
	public List<Topic> getLatestTopics() {
		return latestTopics;
	}

	public void setLatestTopics(List<Topic> latestTopics) {
		this.latestTopics = latestTopics;
	}

	@Transient
	public Long getTopicCount() {
		return topicCount;
	}

	public void setTopicCount(Long topicCount) {
		this.topicCount = topicCount;
	}
}
