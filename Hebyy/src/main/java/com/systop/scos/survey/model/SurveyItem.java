package com.systop.scos.survey.model;

import java.util.ArrayList;
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

import com.systop.core.model.BaseModel;

/**
 * 调查项目
 * 
 * @author LinJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "survey_items")
public class SurveyItem extends BaseModel {
	
	//调查项目id
	private Integer id;
	
	//问卷调查主题
	private Survey survey;
	
	//调查项目
	private String title;
	
	//是否可以多选(1--可以多选，0--不可以多选)
	private int multiple;
	
	//存放选项的List
	private List<SurveySubitem> subitems = new ArrayList<SurveySubitem>();  
	  
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false )
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@ManyToOne(cascade={}, fetch = FetchType.LAZY)
	@JoinColumn(name = "survey_id")
	public Survey getSurvey() {
		return survey;
	}
	public void setSurvey(Survey survey) {
		this.survey = survey;
	}
	
	@Column(name = "title", length = 500)
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name = "multiple", length = 1)
	public int getMultiple() {
		return multiple;
	}
	public void setMultiple(int multiple) {
		this.multiple = multiple;
	}
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="surveyItem",cascade={CascadeType.REMOVE})
	@JoinColumn(name = "survey_item_id")
    public List<SurveySubitem> getSubitems() {
		return subitems;
	}
	public void setSubitems(List<SurveySubitem> subitems) {
		this.subitems = subitems;
	}
}
