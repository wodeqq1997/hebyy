package com.systop.archive;

import com.systop.core.Constants;


/**
 * 档案常量类
 * 
 * @author SongBaojie
 * 
 */
public class ArchiveConstants {

	// 状态[0:待审批, 1:未通过, 2: 已通过]

	/**
	 * 待审批：0
	 */
	public static final String STATUS_PENDING = Constants.NO;

	/**
	 * 未通过：1
	 */
	public static final String STATUS_NOPASS = Constants.YES;
	
	/**
	 * 已通过：2
	 */
	public static final String STATUS_PASS= "2";
	
}
