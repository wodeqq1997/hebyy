package com.systop.hebyy.hybl.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.systop.core.model.BaseModel;

/**
 * 会议信息
 * 
 * @author wyp
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "HYXX")
public class Hyxx extends BaseModel {

	private Integer id;

	// 会议文件名称
	private String hyMc;

	// 会议参与人
	private String hycyr;

	// 会议时间
	private Date hyTime;

	// 会议内容（备注）
	private String hyContent;

	// 文件号
	private String wjh;

	// 份数
	private String pageNum;

	// 会议纪要类别
	private String hytype;

	// 起止时间 用于查询 不维护
	private Date startTime;

	// 截止时间 用于查询 不维护
	private Date endTime;

	// 上传的文件
	private String fileAttachIds;

	@Id
	@GeneratedValue(generator = "hibseq")
	@GenericGenerator(name = "hibseq", strategy = "hilo")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getHyMc() {
		return hyMc;
	}

	public void setHyMc(String hyMc) {
		this.hyMc = hyMc;
	}

	public String getHycyr() {
		return hycyr;
	}

	public void setHycyr(String hycyr) {
		this.hycyr = hycyr;
	}

	public Date getHyTime() {
		return hyTime;
	}

	public void setHyTime(Date hyTime) {
		this.hyTime = hyTime;
	}

	public String getHyContent() {
		return hyContent;
	}

	public void setHyContent(String hyContent) {
		this.hyContent = hyContent;
	}

	@Transient
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	@Transient
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getWjh() {
		return wjh;
	}

	public void setWjh(String wjh) {
		this.wjh = wjh;
	}

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	public String getHytype() {
		return hytype;
	}

	public void setHytype(String hytype) {
		this.hytype = hytype;
	}

	@Column(name = "file_attach_ids")
	public String getFileAttachIds() {
		return fileAttachIds;
	}

	public void setFileAttachIds(String fileAttchIds) {
		this.fileAttachIds = fileAttchIds;
	}

}
