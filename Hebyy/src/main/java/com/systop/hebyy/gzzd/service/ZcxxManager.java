package com.systop.hebyy.gzzd.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.gzzd.model.Zcxx;

/**
 * 章程目录业务类
 * 
 * @author WangYaping
 * 
 */
@Service
public class ZcxxManager extends BaseGenericsManager<Zcxx> {

	/**
	 * 查询全部
	 * 
	 * @return
	 */
	public List<Zcxx> queryAlljkjss() {
		String sql = "from Zcxx j";
		return query(sql);
	}

	/**
	 * 根据名称取到对象
	 * 
	 * @param zcName目录名称
	 * @return
	 */
	@Transactional
	public Zcxx getZcxxByKdname(String zcName) {

		String hql = "from Zcxx p where p.zcMc = ? ";
		Zcxx zcxx = findObject(hql, zcName);
		return zcxx;

	}

	/**
	 * 根据id取到对象
	 * 
	 * @param
	 * @return
	 */
	@Transactional
	public Zcxx getZcxxByKdid(int id) {

		String hql = "from Zcxx p where p.id = ? ";

		Zcxx zcxx = findObject(hql, id);
		return zcxx;

	}

}
