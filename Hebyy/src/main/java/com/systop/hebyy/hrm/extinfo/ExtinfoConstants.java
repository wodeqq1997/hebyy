package com.systop.hebyy.hrm.extinfo;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 企业档案常量类
 * 
 * @author SongBaojie
 * 
 */
public final class ExtinfoConstants {
	
	/**
	 * 保险：养老保险 
	 */
	public static final String EXTINFO_INSURANCE_PENSION = "p";

	/**
	 * 保险：医疗保险 
	 */
	public static final String EXTINFO_INSURANCE_MEDICAL = "m";
	
	/**
	 * 保险：失业保险 
	 */
	public static final String EXTINFO_INSURANCE_UNEMPLOYMENT = "u";
	
	/**
	 * 保险：工伤保险 
	 */
	public static final String EXTINFO_INSURANCE_INJURIES = "i";
	
	/**
	 * 保险：生育保险 
	 */
	public static final String EXTINFO_INSURANCE_FERTILITY = "f";
	
	/**
	 * 保险：住房公积金
	 */
	public static final String EXTINFO_INSURANCE_HOUSING_FUND = "h";
	
	/**
	 * 企业档案保险状态常量Map
	 */
	public static final Map<String, String> EXTINFO_INSURANCE_MAP = Collections
			.synchronizedMap(new LinkedHashMap<String, String>());
	
	static {
		EXTINFO_INSURANCE_MAP.put(EXTINFO_INSURANCE_PENSION, "养老保险");
		EXTINFO_INSURANCE_MAP.put(EXTINFO_INSURANCE_MEDICAL, "医疗保险");
		EXTINFO_INSURANCE_MAP.put(EXTINFO_INSURANCE_UNEMPLOYMENT, "失业保险");
		EXTINFO_INSURANCE_MAP.put(EXTINFO_INSURANCE_INJURIES, "工伤保险");
		EXTINFO_INSURANCE_MAP.put(EXTINFO_INSURANCE_FERTILITY, "生育保险");
		EXTINFO_INSURANCE_MAP.put(EXTINFO_INSURANCE_HOUSING_FUND, "住房公积金");
	}


}
