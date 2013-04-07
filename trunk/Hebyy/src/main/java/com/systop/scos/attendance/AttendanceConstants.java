package com.systop.scos.attendance;


/**
 *@author LinJie
 *@version 1.0
 *@create 2012-6-13 上午9:52:09
 */
public class AttendanceConstants {

	//未上报
	public static final String STATUS_NOREPORTED = "0";
	
	//以上报
	public static final String STATUS_REPORTED = "1";
	
	/**
	 * 迟到
	 */
	public static final String STATUS_LATER = "later";
	
	public static final String STATUS_NORMAL = "normal";
	
	/**
	 * 早退
	 */
	public static final String STATUS_EARLY = "early";
	
	/**
	 * 上午上班
	 */
	public static final String MORWORK = "0";
	
	/**
	 * 上午下班
	 */
	public static final String MOROVEW = "1";
	
	/**
	 * 下午上班
	 */
	public static final String AFTWORK = "1";

	/**
	 * 下午下班
	 */
	public static final String AFTOVEW = "1";
}
