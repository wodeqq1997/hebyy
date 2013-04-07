package com.systop.scos.document.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.Constants;
import com.systop.core.model.BaseModel;

/**
 * 文档实体类
 * 
 * @author Nice
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "documents")
public class Document extends BaseModel {
	
	//主键
	private Integer id;
	
	//标题
	private String title;

	//关键字
	private String keyWord;

	//描述
	private String descn;

	//创建时间
	private Date createTime;

	//作者
	private User owner;

	//附件文档主键
	private String fileattchIds;

	/*是否共享*/
	private String isPublic = Constants.NO;
	/**
	 * 文档类别
	 */
	private DocType docType;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "title", length = 255)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "key_word", length = 255)
	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	@Column(name = "descn", length = 2000)
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "owner_id")
	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	@Column(name = "file_attch_ids")
	public String getFileattchIds() {
		return fileattchIds;
	}

	public void setFileattchIds(String fileattchIds) {
		this.fileattchIds = fileattchIds;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "doc_type_id")
	public DocType getDocType() {
		return docType;
	}

	public void setDocType(DocType docType) {
		this.docType = docType;
	}

	@Column(name = "is_pubilc")
	public String getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}
}