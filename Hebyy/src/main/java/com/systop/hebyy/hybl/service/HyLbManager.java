package com.systop.hebyy.hybl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.gzzd.model.Zcxx;
import com.systop.hebyy.hybl.model.HyLb;
import com.systop.hebyy.hybl.model.Hyxx;
/**
 * 会议类别
 * @author wangyaping
 *
 */
@Service
public class HyLbManager  extends BaseGenericsManager<HyLb> {
	
	/**
	 * 查询全部
	 * 
	 * @return
	 */
	public List<HyLb> queryAll() {
		String sql = "from HyLb j";
		return query(sql);
	}
	/**
	 * 通过id获得对象的值
	 */

	@Transactional
	public HyLb getHyLbByid(int id) {

		String hql = "from HyLb p where p.id = ? ";
		HyLb hylb = findObject(hql, id);
		return hylb;

	}
	
	/**
	 * 通过名称获得对象的值
	 */

	@Transactional
	public HyLb getHyLbByName(String name) {

		String hql = "from HyLb p where p.hyLbMc = ? ";
		HyLb hylb = findObject(hql, name);
		return hylb;

	}
}
