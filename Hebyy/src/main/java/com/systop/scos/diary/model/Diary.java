package com.systop.scos.diary.model;

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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 工作日志
 * 
 * @author Nice
 */
@Entity
@Table(name = "diarys")
@SuppressWarnings("serial")
public class Diary extends BaseModel {

	// 主键
	private Integer id;

	// 标题
	private String title;

	// 备注
	private String content;
	
	//待办
	private String todo;
	
	//在做
	private String doing;
	
	//完成
	private String complate;

	// 作者
	private User user;

	// 时间
	private Date createTime;

	// 最后修改时间
	private Date updateTime;


    private List<DiaryComment> diaryComments = new ArrayList<DiaryComment>(0);
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Type(type = "text")
	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "update_time")
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

    @OneToMany(cascade = {CascadeType.REMOVE}, fetch = FetchType.LAZY, mappedBy = "diary")
    @OrderBy("createTime asc")
    public List<DiaryComment> getDiaryComments() {
        return diaryComments;
    }

    public void setDiaryComments(List<DiaryComment> diaryComments) {
        this.diaryComments = diaryComments;
    }

    @Column(name = "todo")
	public String getTodo() {
		return todo;
	}

	public void setTodo(String todo) {
		this.todo = todo;
	}

	@Column(name = "doing")
	public String getDoing() {
		return doing;
	}

	public void setDoing(String doing) {
		this.doing = doing;
	}

	@Column(name = "complate")
	public String getComplate() {
		return complate;
	}

	public void setComplate(String complate) {
		this.complate = complate;
	}
    
    
}
