package com.systop.scos.goods.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.goods.model.Goods;
import com.systop.scos.goods.model.InStock;

/**
 * 
 * @author XuRan
 *
 */
@Service
public class InStockManager extends BaseGenericsManager<InStock>{
	
	@Autowired
	private GoodsManager goodsManager;
	/**
	 * 保存入库单物品信息
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void save(InStock inStock) {
		if (getDao().exists(inStock, "stockNo")) {
			throw new ApplicationException("该入库单编号已经存在,请您查证后再次录入");
		}
		if(inStock.getId() == null){
			inStock.setCreateTime(new Date());
		}
		// 修改实际库存量
		if(inStock.getGoods() != null && inStock.getGoods().getId() != null) {
			Goods goods = goodsManager.get(inStock.getGoods().getId());
			// 入库是改变原有数量（原有库存 + 入库数量）
			// 原库存
			Integer stockCounts = goods.getStockCounts() == null ? 0 : goods.getStockCounts(); 
			// 入库数
			Integer inCounts = inStock.getInCounts() == null ? 0 : inStock.getInCounts();
			
			goods.setStockCounts(stockCounts + inCounts);
			goodsManager.update(goods);
		}
		getDao().saveOrUpdate(inStock);
	}
	
	/**
	 * 根据入库单ID修改现有单据数量
	 * @param id
	 * @param nowCounts
	 */
	@Transactional
	public void saveNowCounts(Integer id, Integer nowCounts){
		InStock inStock = get(id);
		inStock.setNowCounts(nowCounts);
		update(inStock);
	}
	
	/**
	 * 删除入库单
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void remove(InStock inStock) {
		// 删除入库单的同时修改实际库存量
		if(inStock.getGoods() != null && inStock.getGoods().getId() != null) {
			Goods goods = goodsManager.get(inStock.getGoods().getId());
			// 入库是改变原有数量（原有库存  - 删除库存单中数量）
			// 原库存
			Integer stockCounts = goods.getStockCounts() == null ? 0 : goods.getStockCounts(); 
			// 入库数
			Integer inCounts = inStock.getInCounts() == null ? 0 : inStock.getInCounts();
			goods.setStockCounts(stockCounts  - inCounts);
			goodsManager.update(goods);
		}
		super.remove(inStock);
	}



	/**
	 * 生成入库单号
	 * 组成：两位年份两位月份两位日期+（流水号，不够8位前面补零），如：201106230001
	 * 
	 * @param date
	 * @return
	 */

	public String getStockNo(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		StringBuilder sb = new StringBuilder(dateFormat.format(date));
		// dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			String stockNo = (String)getDao().findObject("select max(s.stockNo) from InStock s where DATE_FORMAT(s.createTime, '%Y%m%d')>= DATE_FORMAT(now(), '%Y%m%d')");
			long count = 1l;
			if (stockNo != null) {
				count = new Long(stockNo .substring(stockNo.length() - 4)) + 1;
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
	
	/**
	 * 通过goods的Id获取库存
	 * @param id
	 * @return
	 */
	public List<InStock> queryInStock(Integer id){
		String hql = "from InStock i where i.goods.id = ? order by i.inDate asc";
		return query(hql, id);
	}
}
