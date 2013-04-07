package com.systop.hebyy.hrm.job.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.hrm.job.model.Job;

/**
 * 干什么用的。。。。
 * @author LinJie
 */
@Service
public class JobManager extends BaseGenericsManager<Job> {
	
	/**
	 * 根据部门或的职位信息
	 * @param dept
	 * @return
	 */
	public List<Job> getJobsBydDept(Integer deptId){
		List<Job> jobs = new ArrayList<Job>();
		if (deptId != null){
			String hql = "from Job j where j.dept.id = ? order by j.orderId desc";
			jobs = query(hql, deptId);
		}
		return jobs;
	}
	
	

}
