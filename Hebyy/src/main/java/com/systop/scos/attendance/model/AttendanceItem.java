package com.systop.scos.attendance.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.model.BaseModel;

/**
 * 考勤
 * 
 * @author SongBaoJie
 */
@Entity
@Table(name = "attendance_items")
@SuppressWarnings("serial")
public class AttendanceItem extends BaseModel {

	/**主键*/
	private Integer id;
	
	/**实际出勤天数*/
	private Double actualDays; 
	
	/**事假天数*/
	private Double leaveDays;

	/**旷工次数*/
	private Integer absentCount;
	
	/**病假天数*/
	private Double diseaseDays;
	
	/**迟到次数*/
	private Integer lateCount;
	
	/**员工*/
	private User person;
	
	/**
	 * 录入时间
	 */
	private Date createTime;
	
	/** 
	 * 备注
	 */
	private String remark;
	
	/**
	 * 考勤
	 */
	private Attendance attendance;

    /**
     * 外业和内业天数
     */
    private Double outDays=0.0,inDays=0.0;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	public User getPerson() {
		return person;
	}
	
	public void setPerson(User person) {
		this.person = person;
	}

	@Column(name = "actual_days")
	public Double getActualDays() {
		return actualDays;
	}

	public void setActualDays(Double actualDays) {
		this.actualDays = actualDays;
	}

	@Column(name = "leave_days")
	public Double getLeaveDays() {
		return leaveDays == null ? 0 : leaveDays;
	}

	public void setLeaveDays(Double leaveDays) {
		this.leaveDays = leaveDays;
	}

	@Column(name = "absent_count")
	public Integer getAbsentCount() {
		return absentCount == null ? 0 : absentCount;
	}

	public void setAbsentCount(Integer absentCount) {
		this.absentCount = absentCount;
	}

	@Column(name = "disease_days")
	public Double getDiseaseDays() {
		return diseaseDays == null ? 0 : diseaseDays;
	}

	public void setDiseaseDays(Double diseaseDays) {
		this.diseaseDays = diseaseDays;
	}

	@Column(name = "late_count")
	public Integer getLateCount() {
		return lateCount == null ? 0 : lateCount;
	}

	public void setLateCount(Integer lateCount) {
		this.lateCount = lateCount;
	}

	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	@Column(name = "remark", length = 500)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	public Attendance getAttendance() {
		return attendance;
	}

	public void setAttendance(Attendance attendance) {
		this.attendance = attendance;
	}

    public Double getOutDays() {
        return outDays;
    }

    public void setOutDays(Double outDays) {
        this.outDays = outDays;
    }

    @Column(name = "out_days")
    public Double getInDays() {
        return inDays;
    }

    @Column(name="in_days")
    public void setInDays(Double inDays) {
        this.inDays = inDays;
    }
}
