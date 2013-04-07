package com.systop.scos.survey.model;

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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import com.systop.core.model.BaseModel;

/**
 * 问卷调查主题
 * 
 * @author LinJie
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "surveys")
public class Survey extends BaseModel {
	
	//问卷调查主题id
	private Integer id;
	
	//问卷调查主题
	private String title;
	
	//问卷调查主题描述
	private String descn;
	
	//问卷调查创建日期
	private Date createDate;
	
	//问卷调查结束日期
	private Date endDate;
	
	//问卷调查主题发布状态(0--未发布,1--正在进行,2--已过期)
	private String releaseStatus;
	
	//存放调查项目的List
	private List<SurveyItem> surveyItems = new ArrayList<SurveyItem>();
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "title", length = 200)
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name = "descn")
	@Type(type = "text")
	public String getDescn() {
		return descn;
	}
	public void setDescn(String descn) {
		this.descn = descn;
	}
	
	@Column(name="create_Date")
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	@Column(name="end_Date")
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Column(name="release_status")
	public String getReleaseStatus() {
		return releaseStatus;
	}
	public void setReleaseStatus(String releaseStatus) {
		this.releaseStatus = releaseStatus;
	}
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="survey",cascade={CascadeType.REMOVE})  
    @JoinColumn(name = "survey_id")
	public List<SurveyItem> getSurveyItems() {
		return surveyItems;
	}
	public void setSurveyItems(List<SurveyItem> surveyItems) {
		this.surveyItems = surveyItems;
	}

}
