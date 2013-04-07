package com.systop.zjimis.flow;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 客户管理常量类
 * 
 * @author SongBaojie
 * 
 */
public final class FlowConstants {

	/**
	 * 字段名【档案文件借阅】：archiveFileLend
	 */
	public static final String FIELD_ARCHIVEFILELEND = "archiveFileLend";

	/**
	 * 流程状态常量，结束
	 */
	public static final String FLOW_STATUS_END = "end";

	/**
	 * 流程状态常量，开始
	 */
	public static final String FLOW_STATUS_START = "start";

	/**
	 * 流程状态常量，停止
	 */
	public static final String FLOW_STATUS_STOP = "stop";

	/**
	 * 流程节点状态常量，未通过
	 */
	public static final String STATUS_NOPASS = "noPass";

	/**
	 * 流程节点状态常量，通过
	 */
	public static final String STATUS_PASS = "pass";

	/**
	 * 流程节点状态常量，待审核
	 */
	public static final String STATUS_PENDING = "pending";

	/**
	 * 流程节点常量Map
	 */
	public static final Map<String, String> STATUS_MAP = Collections
			.synchronizedMap(new LinkedHashMap<String, String>());

	static {
		STATUS_MAP.put(STATUS_PASS, "通过");
		STATUS_MAP.put(STATUS_NOPASS, "未通过");
		STATUS_MAP.put(STATUS_PENDING, "待审核");

	}

	/**
	 * 流程节点title常量Map
	 */
	public final static Map<String, String> TITLE_MAP = Collections
			.synchronizedMap(new LinkedHashMap<String, String>());
	static {
		TITLE_MAP.put(FIELD_ARCHIVEFILELEND, "文件借阅审批");
	}
}
