package com.systop.hebyy.meeting.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.systop.core.model.BaseModel;

/**
 * 会议类别信息
 * 
 * @author WangYaping
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "MEETINGTYPE")
public class MeetingType extends BaseModel {

	private Integer id;

	// 会议类别
	private String hyLbMc;

	// 备注
	private String remark;
	
	//会议集合
	private List<Meeting> meetingList;

	
	@Id
	@GeneratedValue(generator = "hibseq")
	@GenericGenerator(name = "hibseq", strategy = "hilo")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getHyLbMc() {
		return hyLbMc;
	}

	public void setHyLbMc(String hyLbMc) {
		this.hyLbMc = hyLbMc;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@OneToMany(cascade = {}, mappedBy = "meetingType")
	public List<Meeting> getMeetingList() {
		return meetingList;
	}

	public void setMeetingList(List<Meeting> meetingList) {
		this.meetingList = meetingList;
	}

}
