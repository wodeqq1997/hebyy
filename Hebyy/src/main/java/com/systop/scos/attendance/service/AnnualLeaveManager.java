package com.systop.scos.attendance.service;

import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.attendance.model.AnnualLeave;

/**
 * 
 * 年假管理
 * 
 * @author SongBaoJie
 *
 */
@Service
public class AnnualLeaveManager extends BaseGenericsManager<AnnualLeave> {
	/**
	 * 生成年假<br>
	 * 初始化年假数据，将用户表中用户添加到年假表中，默认年假均为0<br>
	 * 如果年假表中用户存已在，则不添加
	 */
	public void generateAnnualLeave(){
		
	}
}
