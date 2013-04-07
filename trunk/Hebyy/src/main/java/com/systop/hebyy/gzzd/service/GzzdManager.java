package com.systop.hebyy.gzzd.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.dao.support.Page;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.PageUtil;
import com.systop.hebyy.gzzd.model.Gzzd;
import com.systop.hebyy.gzzd.model.Zcxx;

/**
 * 规章制度业务类
 * 
 * @author wangyaping
 * 
 */
@Service
public class GzzdManager extends BaseGenericsManager<Gzzd> {

	/**
	 * 通过id获得对象的值
	 */

	@Transactional
	public Gzzd getGzzdByid(int id) {

		String hql = "from Gzzd p where p.id = ? ";
		Gzzd gzzd = findObject(hql, id);
		return gzzd;

	}

	/**
	 * 通过类别目录id拿到一组对象
	 * 
	 * @param id
	 * @return
	 */
	public List<Gzzd> querykc(int id) {

		StringBuffer hql = new StringBuffer(

		" from  Gzzd p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (id != 0) {
			hql.append(" and p.zcxx.id = ? ");
			args.add(id);
		}

		hql.append(" order by p.id ");
		return query(hql.toString(), args.toArray());
	}

	/**
	 * 保存规章制度并关联指定的目录
	 * 
	 * @param Gzzd
	 * @param zcId
	 */
	@Transactional
	public void save(Gzzd gzzd, Integer zcId) {

		if (zcId != null) {
			gzzd.setZcxx(getDao().get(Zcxx.class, zcId));
		}

		save(gzzd);
	}

	/**
	 * 查询全部的规章制度
	 * @param count
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Gzzd> getNotices(Integer count) {
		StringBuffer sql = new StringBuffer("from Gzzd p where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		sql.append("order by p.id ");
		Page page = PageUtil.getPage(1, count);
		page = pageQuery(page, sql.toString(), args.toArray());
		return page.getData();
	}

}
