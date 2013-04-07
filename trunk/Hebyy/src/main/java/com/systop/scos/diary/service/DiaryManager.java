package com.systop.scos.diary.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.DateUtil;
import com.systop.scos.diary.model.Diary;

/**
 * 
 * @author XuRan
 */
@Service
public class DiaryManager extends BaseGenericsManager<Diary> {
	/**
	 * 文档信息保存，第一次创建的时候保存createTime
	 */
	@Transactional
	public void save(Diary diary) {
		if (diary != null) {
			if (diary.getId() == null) {
				diary.setCreateTime(new Date());
			}
			diary.setUpdateTime(new Date());
			getDao().saveOrUpdate(diary);
		}
	}

	/**
	 * 查询下属用户的工作日志
	 * 
	 * @param page
	 * @param ownerId
	 * @return
	 */
	public Diary getUserDiary(Integer ownerId, Date date) {
		Date begin = DateUtil.firstSecondOfDate(date);
		Date end = DateUtil.lastSecondOfDate(date);
		String hql = "from Diary d where d.user.id = ? and  d.createTime between ? and ?";
		return findObject(hql, new Object[] { ownerId, begin, end });
	}

    /**
     * get last diary
     * @return
     * @param id
     */
    public Diary last(Integer id){
        List<Object> list = getDao().limitQurey("from Diary w where w.user.id = ? order by w.createTime desc", 1, id);
        if(list.size()>0)
            return (Diary)list.get(0);
        return null;
    }
}
