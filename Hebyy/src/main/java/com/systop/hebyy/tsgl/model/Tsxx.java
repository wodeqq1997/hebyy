package com.systop.hebyy.tsgl.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.systop.common.modules.fileattch.model.FileAttch;
import com.systop.core.model.BaseModel;

/**
 * 图书信息
 * 
 * @author wangyaping
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "TSXX")
public class Tsxx extends BaseModel {

	private Integer id;

	// 书名
	private String tsMc;

	// 作者
	private String author;

	// 图书类别
	private Lbxx lbxx;

	// 图书总数量
	private String totalNum;

	// 图书剩余量
	private String syNum;
	
	// 入库日期
	private Date rkTime;

	// 类别名称，不需要在数据库里做维护
	private String lbmc;
	
	//图书备注
	private String  descn;
	
	// 图书照片
	private String bookPhoto;

	//上传文件
	private FileAttch fileAttch;
	

	@Id
	@GeneratedValue(generator = "hibseq")
	@GenericGenerator(name = "hibseq", strategy = "hilo")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTsMc() {
		return tsMc;
	}

	public void setTsMc(String tsMc) {
		this.tsMc = tsMc;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "LBXX_ID")
	public Lbxx getLbxx() {
		return lbxx;
	}

	public void setLbxx(Lbxx lbxx) {
		this.lbxx = lbxx;
	}



	public Date getRkTime() {
		return rkTime;
	}

	public void setRkTime(Date rkTime) {
		this.rkTime = rkTime;
	}

	@Transient
	public String getLbmc() {
		return lbmc;
	}

	public void setLbmc(String lbmc) {
		this.lbmc = lbmc;
	}

	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}
	public String getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(String totalNum) {
		this.totalNum = totalNum;
	}

	public String getSyNum() {
		return syNum;
	}

	public void setSyNum(String syNum) {
		this.syNum = syNum;
	}

	public String getBookPhoto() {
		return bookPhoto;
	}

	public void setBookPhoto(String bookPhoto) {
		this.bookPhoto = bookPhoto;
	}
   
	@Transient
	public FileAttch getFileAttch() {
		return fileAttch;
	}

	public void setFileAttch(FileAttch fileAttch) {
		this.fileAttch = fileAttch;
	}
}
