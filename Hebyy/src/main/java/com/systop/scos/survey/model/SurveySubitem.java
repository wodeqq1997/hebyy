package com.systop.scos.survey.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.systop.core.model.BaseModel;

/**
 * 调查项目的选项
 * 
 * @author LinJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "survey_subitems")
public class SurveySubitem extends BaseModel {
	
	//选项id
	private Integer id;
	
	//调查项目
	private SurveyItem surveyItem;
	
	//选项内容
	private String title;
	
	//投票人数
	private int votesCount;
	
	//投票百分比
	private int percent;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false )
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "survey_item_id")
	public SurveyItem getSurveyItem() {
		return surveyItem;
	}

	public void setSurveyItem(SurveyItem surveyItem) {
		this.surveyItem = surveyItem;
	}
	
	@Column(name="title" , length = 500)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name="votes_count", length = 11)
	public int getVotesCount() {
		return votesCount;
	}

	public void setVotesCount(int votesCount) {
		this.votesCount = votesCount;
	}
	
	@Column(name="percent")
	public int getPercent() {
		return percent;
	}

	public void setPercent(int percent) {
		this.percent = percent;
	}
	
	
}
