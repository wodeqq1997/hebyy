package com.systop.scos.document;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import com.systop.core.Constants;

/**
 * 文档类型管理及相关模块的常量类
 * 
 * @author SongBaojie
 * 
 */
public final class DocumentConstants {
	/**
	 * 状态常量，1-可用
	 */
	public static final String RUN = Constants.STATUS_AVAILABLE;

	/**
	 * 状态常量，0-禁止
	 */
	public static final String STOP = Constants.STATUS_UNAVAILABLE;

	/**
	 * 状态常量Map
	 */
	public static final Map<String, String> STATUS_MAP = Collections
			.synchronizedMap(new LinkedHashMap<String, String>());
	static {
		STATUS_MAP.put(RUN, "可用");
		STATUS_MAP.put(STOP, "禁用");
	}

	/**
	 * 顶级商品类型名称
	 */
	public static final String TOP_DEPT_NAME = "文档类型";

	/**
	 * 顶级商品类型ID
	 */
	public static final Integer TOP_PROSORT_ID = 0;

	/**
	 * 第一个商品的编号
	 */
	public static final String FIRST_SERIAL_NO = "01";

}
