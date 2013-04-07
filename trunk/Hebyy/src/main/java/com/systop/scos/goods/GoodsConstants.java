package com.systop.scos.goods;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import com.systop.core.Constants;

/**
 * 办公用品常量类
 * 
 * @author SongBaojie
 * 
 */
public final class GoodsConstants {
	
	/**
	 * 办公用品申请常量：0=未审核 
	 */
	public static final String GOODS_APPLY_NOT_EXAMINE = Constants.NO;

	/**
	 * 办公用品申请常量：1=通过
	 */
	public static final String GOODS_APPLY_PASS = Constants.YES;
	
	/**
	 * 办公用品申请常量：2=未通过
	 */
	public static final String GOODS_APPLY_NOT_PASS = "2";
	
	/**
	 * 办公用品申请状态常量Map
	 */
	public static final Map<String, String> GOODS_APPLY_STATUS_MAP = Collections
			.synchronizedMap(new LinkedHashMap<String, String>());
	
	static {
		GOODS_APPLY_STATUS_MAP.put(GOODS_APPLY_NOT_EXAMINE, "未审核");
		GOODS_APPLY_STATUS_MAP.put(GOODS_APPLY_NOT_PASS, "未通过");
		GOODS_APPLY_STATUS_MAP.put(GOODS_APPLY_PASS, "通过");
	}


}
