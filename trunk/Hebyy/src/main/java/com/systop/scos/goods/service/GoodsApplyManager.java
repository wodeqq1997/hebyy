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
import com.systop.scos.goods.GoodsConstants;
import com.systop.scos.goods.model.Goods;
import com.systop.scos.goods.model.GoodsApply;
import com.systop.scos.goods.model.InStock;

/**
 * 办公用品申请service
 * 
 * @author SongBaoJie
 * 
 */
@Service
public class GoodsApplyManager extends BaseGenericsManager<GoodsApply> {

	@Autowired
	private GoodsManager goodsManager;

	@Autowired
	private InStockManager inStockManager;

	/**
	 * 保存办公用品申请单
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void save(GoodsApply entity) {
		if (entity.getId() == null) {
			// 设置办公用品审核状态：未审核状态
			entity.setStatus(GoodsConstants.GOODS_APPLY_NOT_EXAMINE);
			entity.setApplyDate(new Date());
			List<InStock> list = inStockManager.queryInStock(entity.getGoods()
					.getId());
			Double totalPrice = 0D;
			Integer useCount = entity.getUseCount();
			for (InStock inStock : list) {
				if (useCount != 0) {
					if (useCount <= inStock.getNowCounts()) {
						totalPrice = totalPrice + useCount * inStock.getPrice();
						useCount = 0;
					} else {
						useCount = useCount - inStock.getNowCounts();
						totalPrice = totalPrice + inStock.getPrice()
								* inStock.getNowCounts();
					}
				}
			}
			entity.setTotalPrice(totalPrice);
		}
		super.save(entity);
	}

	/**
	 * 根据申请状态，修改原库存数量(通过申请，库存数量=原库存数量-申请数量)
	 */
	@Transactional
	public void updateCountByPass(GoodsApply entity) {
		// 修改实际库存量（原库存 - 出库数量）
		if (entity.getGoods() != null && entity.getGoods().getId() != null) {
			Goods goods = goodsManager.get(entity.getGoods().getId());
			// 修改入库单中实际库存量
			List<InStock> list = inStockManager.queryInStock(entity.getGoods()
					.getId());
			Integer useCount = entity.getUseCount();
			for (InStock stock : list) {
				if (useCount != 0) {
					if (useCount <= stock.getNowCounts()) {
						stock.setNowCounts(stock.getNowCounts() - useCount);
						useCount = 0;
					} else {
						useCount = useCount - stock.getNowCounts();
						stock.setNowCounts(0);
					}
					// 修改库存现有数量
					inStockManager.saveNowCounts(stock.getId(), stock.getNowCounts());
				}
			}
			// 原库存
			Integer stockCounts = goods.getStockCounts() == null ? 0 : goods
					.getStockCounts();
			// 出库数量
			Integer useCounts = entity.getUseCount() == null ? 0 : entity
					.getUseCount();
			// 出库后现有库存量
			goods.setStockCounts(stockCounts - useCounts);
			goodsManager.update(goods);
		}
		update(entity);
	}

	/**
	 * 删除办公用品申请单
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void remove(GoodsApply entity) {
		// 修改实际库存量
		// if(entity.getGoods() != null && entity.getGoods().getId() != null) {
		// Goods goods = goodsManager.get(entity.getGoods().getId());
		// goods.setStockCounts(goods.getStockCounts() + entity.getUseCount());
		// goodsManager.update(goods);
		// }
		super.remove(entity);
	}

	/**
	 * 生成申请单号 组成：两位年份两位月份两位日期+（流水号，不够8位前面补零），如：201106230001
	 * 
	 * @param date
	 * @return
	 */

	@SuppressWarnings("rawtypes")
	public String getApplyNo(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		StringBuilder sb = new StringBuilder(dateFormat.format(date));
		List list = null;
		// dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			list = query("select max(g.applyNo) from GoodsApply g where DATE_FORMAT(g.applyDate, '%Y%m%d')>= DATE_FORMAT(now(), '%Y%m%d')");
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
