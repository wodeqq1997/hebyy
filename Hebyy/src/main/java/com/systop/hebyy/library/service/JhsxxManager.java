package com.systop.hebyy.library.service;




import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.library.model.Jhsxx;

/**
 * 借还书信息业务类
 * @author WangYaping
 *
 */

@Service
public class JhsxxManager extends BaseGenericsManager<Jhsxx> {
	
	/**
	 * 根据id取到对象
	 * 
	 * @param id
	 * @return
	 */

	@Transactional
	public Jhsxx getJhsxxByid(int id) {

		String hql = "from Jhsxx p where p.id = ? ";
		Jhsxx jhs = findObject(hql, id);
		return jhs;

	}
	
	/**
	 * 找到未归还的书
	 * @param jhsxx
	 */
	@Transactional
	public int getNogh(int bookid){
	
		String hql = "select count(p.id) from Jhsxx p where p.hsr is null ";
		String id = getDao().findObject(hql).toString().trim();
		System.out.print(id);
		int id1 = Integer.parseInt(id);
		return id1;
		
		
	}
	
	
	/*
	 * 保存的方法
	 */
	@Transactional
	public void savexx(Jhsxx jhsxx) {
		
		getDao().save(jhsxx);
	}

}
