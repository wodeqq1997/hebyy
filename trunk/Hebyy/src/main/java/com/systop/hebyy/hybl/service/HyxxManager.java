package com.systop.hebyy.hybl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;

import com.systop.hebyy.hybl.model.Hyxx;

/**
 * 会议信息业务页面
 * 
 * @author wangyaping
 * 
 */
@Service
public class HyxxManager extends BaseGenericsManager<Hyxx> {

	/**
	 * 查询全部
	 * 
	 * @return
	 */

	public List<Hyxx> queryAlljkjss() {
		
		String sql = "from Hyxx j";
		return query(sql);
	}

	/**
	 * 通过id获得对象的值
	 */

	@Transactional
	public Hyxx getHyxxByid(int id) {

		String hql = "from Hyxx p where p.id = ? ";
		Hyxx hyxx = findObject(hql, id);
		return hyxx;

	}

	/**
	 * 得到最大的id号
	 */
	@Transactional
	public int getHyxxMaxid() {

		String hql = "select Max(p.id) from Hyxx p  ";
		String id = getDao().findObject(hql).toString().trim();
		System.out.print(id);
		int id1 = Integer.parseInt(id);
		return id1;

	}
}
