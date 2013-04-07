package com.systop.scos.goods.service;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.goods.model.Goods;

/**
 * 
 * @author XuRan
 *
 */
@Service

public class GoodsManager extends BaseGenericsManager<Goods>{

	/**
	 * 保存物品
	 */
	@Transactional
	public void save(Goods goods) {
		if (getDao().exists(goods, "name", "specifications")) {
			throw new ApplicationException("该物品已经存在,请您查证后再次录入");
		}
		if(goods != null && goods.getId() != null){
			goods.setCreateTime(new Date());
		}
		getDao().getHibernateTemplate().clear();
		getDao().saveOrUpdate(goods);
	}
	
	/**
	 * 查询所有物品
	 */
	@SuppressWarnings("unchecked")
	public Map<Integer,String> getGoodsMap() {
		StringBuffer sql = new StringBuffer("from Goods g where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		
		Map<Integer,String> goodsMap = new LinkedMap();
		List<Goods> list = query(sql.toString(), args.toArray());
		for(Goods g : list) {
			goodsMap.put(g.getId(),g.getName());
		}
		return goodsMap;
	}
	
	/**
	 * 根据物品类型ID，判断是否有该物品 
	 */
	public boolean isGoodsByType(Integer typeId){
		Long count = (Long)getDao().findObject("select count(g.id) from Goods g where g.goodsType.id = ?", typeId) ;
		System.out.println(count);
		return count > 0l;
	}
	
	/**
	 * 生成办公用品编号
	 * 组成：两位年份两位月份两位日期+（流水号，不够8位前面补零），如：201106230001
	 * 
	 * @param date
	 * @return
	 */

	@SuppressWarnings("rawtypes")
	public String getGoodsNo(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		StringBuilder sb = new StringBuilder(dateFormat.format(date));
		List list = null;
		// dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			list = query("select max(g.goodsNo) from Goods g where DATE_FORMAT(g.createTime, '%Y%m%d')>= DATE_FORMAT(now(), '%Y%m%d')");
			long count = 1l;
			if (list != null && list.size() > 0 && list.get(0) != null) {
				String s = list.get(0).toString();
				count = new Long(s.substring(s.length() - 4)) + 1;
			}
			sb.append(fillZero(4, String.valueOf(count)));
		} catch (Exception e) {
			throw new ApplicationException("生成单号失败");
		}
		return sb.toString();
	}

	/**
	 * 补零
	 * 
	 * @param length
	 *            补零后的长度
	 * @param source
	 *            需要补零的字符串
	 * @return
	 */
	private String fillZero(int length, String source) {
		StringBuilder result = new StringBuilder(source);
		for (int i = result.length(); i < length; i++) {
			result.insert(0, '0');
		}
		return result.toString();
	}
}
