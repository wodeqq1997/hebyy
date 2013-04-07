package com.systop.scos.info.notice.model;

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
import javax.persistence.Transient;

import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.Type;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;
import com.systop.core.util.DateUtil;

/**
 * 通知公告
 * 
 * @author SongBaoJie
 */
@Entity
@Table(name = "notices")
@SuppressWarnings("serial")
public class Notice extends BaseModel {

	// 主键
	private Integer id;

	// 标题
	private String title;

	// 内容
	private String content;

	// 创建时间
	private Date createTime;

	// 发布人
	private User creator;

	// 附件
	private String fileAttchIds;
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "title")
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@JSON(serialize = false)
	@Type(type = "text")
	@Column(name = "Content")
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	@Transient
	public String getCreateDate(){
		return DateUtil.getDateToString(createTime, "MM.dd");
	}

	@JSON(serialize = false)
	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "creator_id")
	public User getCreator() {
		return this.creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	@Column(name = "file_Attch_Ids")
	public String getFileAttchIds() {
		return fileAttchIds;
	}

	public void setFileAttchIds(String fileAttchIds) {
		this.fileAttchIds = fileAttchIds;
	}
	

	/**
	 * 根据发布日期比较，如果是今天发布的，则为最新
	 * @return
	 */
	@Transient
	public boolean getNoticeIsNew(){
		String nowDate = DateUtil.getDateToString(new Date(), "yyyy-MM-dd");
		String createDate= DateUtil.getDateToString(createTime, "yyyy-MM-dd");
		return nowDate.equals(createDate);
	}
}
