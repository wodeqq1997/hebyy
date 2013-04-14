package com.systop.hebyy.library.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import com.systop.core.model.BaseModel;

/**
 * 借还书信息
 * 
 * @author WangYaping
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "JHSXX")
public class Jhsxx extends BaseModel {

	private Integer id;

	// 所图书信息id
	private Integer bookId;
	
	//图书名称
	private String bookMc;

	//借书人id
	private String jsrId;
	
	// 借书人
	private String jsr;

	// 借书日期
	private Date jsTime;

	// 还书人
	private String hsr;

	// 借书日期
	private Date hsTime;
	
	//借书备注
	private String jsbz;
	
	//还书备注
	private String hsbz;
	
	//是否归还（数据库里不维护）
	private String isgh;
	
	
	

	@Id
	@GeneratedValue(generator = "hibseq")
	@GenericGenerator(name = "hibseq", strategy = "hilo")
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}


	public Integer getBookId() {
		return bookId;
	}

	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}

	public String getJsr() {
		return jsr;
	}

	public void setJsr(String jsr) {
		this.jsr = jsr;
	}

	public Date getJsTime() {
		return jsTime;
	}

	public void setJsTime(Date jsTime) {
		this.jsTime = jsTime;
	}

	public String getHsr() {
		return hsr;
	}

	public void setHsr(String hsr) {
		this.hsr = hsr;
	}

	public Date getHsTime() {
		return hsTime;
	}

	public void setHsTime(Date hsTime) {
		this.hsTime = hsTime;
	}

	public String getJsbz() {
		return jsbz;
	}

	public void setJsbz(String jsbz) {
		this.jsbz = jsbz;
	}

	public String getHsbz() {
		return hsbz;
	}

	public void setHsbz(String hsbz) {
		this.hsbz = hsbz;
	}
	public String getBookMc() {
		return bookMc;
	}

	public void setBookMc(String bookMc) {
		this.bookMc = bookMc;
	}
	
	public String getJsrId() {
		return jsrId;
	}

	public void setJsrId(String jsrId) {
		this.jsrId = jsrId;
	}
	
	@Transient
	public String getIsgh() {
		return isgh;
	}

	public void setIsgh(String isgh) {
		this.isgh = isgh;
	}
}
