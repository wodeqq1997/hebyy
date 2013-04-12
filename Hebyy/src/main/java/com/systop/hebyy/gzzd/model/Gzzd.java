package com.systop.hebyy.gzzd.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.systop.core.model.BaseModel;

/**
 * 章程目录信息
 * 
 * @author WangYaping
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "GZZD")
public class Gzzd extends BaseModel {

	private Integer id;

	// 制定人(未使用)
	private String zdr;
	
	//文件号
	private String wjh;

	// 文件内容
	private String zdContent;

	// 类别
	private Zcxx zcxx;

	// 类别名称（便于查询）
	private String zcml;
	
	//上传文件
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

	public String getZdr() {
		return zdr;
	}

	public void setZdr(String zdr) {
		this.zdr = zdr;
	}

	public String getZdContent() {
		return zdContent;
	}

	public void setZdContent(String zdContent) {
		this.zdContent = zdContent;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "ZCXX_ID")
	public Zcxx getZcxx() {
		return zcxx;
	}

	public void setZcxx(Zcxx zcxx) {
		this.zcxx = zcxx;
	}

	@Transient
	public String getZcml() {
		return zcml;
	}

	public void setZcml(String zcml) {
		this.zcml = zcml;
	}
	public String getWjh() {
		return wjh;
	}

	public void setWjh(String wjh) {
		this.wjh = wjh;
	}
	
	@Column(name = "file_attach_ids")
	public String getFileAttachIds() {
		return fileAttachIds;
	}

	public void setFileAttachIds(String fileAttachIds) {
		this.fileAttachIds = fileAttachIds;
	}

}
