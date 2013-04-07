package com.systop.scos.car;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import com.systop.core.Constants;

/**
 * 车辆常量类
 * 
 * @author SongBaojie
 * 
 */
public final class CarConstants {

	/**
	 * 车辆状态常量：1=可用
	 */
	public static final String CAR_AVAILABLE = Constants.YES;
	
	/**
	 * 车辆状态常量：2=维修中
	 */
	public static final String CAR_REPAIR_OFF = "2";
	
	/**
	 * 车辆状态常量：0=报废
	 */
	public static final String CAR_SCRAP = Constants.NO;
	
	/**
	 * 车辆状态常量Map
	 */
	public static final Map<String, String> CAR_STATUS_MAP = Collections
			.synchronizedMap(new LinkedHashMap<String, String>());
	
	static {
		CAR_STATUS_MAP.put(CAR_AVAILABLE, "可用");
		CAR_STATUS_MAP.put(CAR_REPAIR_OFF, "维修中");
		CAR_STATUS_MAP.put(CAR_SCRAP, "报废");
	}
	
	/**
	 * 汽车使用申请常量：1=通过
	 */
	public static final String CAR_APPLY_PASS = Constants.YES;
	
	/**
	 * 汽车使用申请常量：2=未通过
	 */
	public static final String CAR_APPLY_NOT_PASS = "2";
	
	/**
	 * 汽车使用申请常量：0=未审核 
	 */
	public static final String CAR_APPLY_NOT_EXAMINE = Constants.NO;
	
	/**
	 * 汽车使用申请状态常量Map
	 */
	public static final Map<String, String> CAR_APPLY_STATUS_MAP = Collections
			.synchronizedMap(new LinkedHashMap<String, String>());
	
	static {
		CAR_APPLY_STATUS_MAP.put(CAR_APPLY_NOT_EXAMINE, "未审核");
		CAR_APPLY_STATUS_MAP.put(CAR_APPLY_NOT_PASS, "未通过");
		CAR_APPLY_STATUS_MAP.put(CAR_APPLY_PASS, "通过");
	}


}
