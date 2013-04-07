package com.systop.hebyy.tsgl.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.model.FileAttch;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.tsgl.model.Lbxx;
import com.systop.hebyy.tsgl.model.Tsxx;


/**
 * 图书维护业务类
 * @author wangyaping
 *
 */

@Service
public class TsglManager extends BaseGenericsManager<Tsxx> {
	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;

	/**
	 * 查询全部
	 * 
	 * @return
	 */
	public List<Tsxx> queryAlljkjss() {
		
		String sql = "from Tsxx j";
		return query(sql);
	}

	/**
	 * 通过id获得对象的值
	 */

	@Transactional
	public Tsxx getTsxxByid(int id) {

		String hql = "from Tsxx p where p.id = ? ";
		Tsxx tsxx = findObject(hql, id);
		return tsxx;

	}

	/**
	 * 得到最大的id号
	 */
	@Transactional
	public int getTsxxMaxid() {

		String hql = "select Max(p.id) from Tsxx p  ";
		String id = getDao().findObject(hql).toString().trim();
		System.out.print(id);
		int id1 = Integer.parseInt(id);
		return id1;

	}

	public List<Tsxx> querykc(int id) {

		StringBuffer hql = new StringBuffer(

		" from  Tsxx p where 1=1 ");
		List<Object> args = new ArrayList<Object>();

		if (id!=0) {
			hql.append(" and p.lbxx.id = ? ");
			args.add(id);
		}
		
		hql.append(" order by p.id ");
		return query(hql.toString(), args.toArray());
	}
	
	/**
	 * 保存图书信息并关联指定的图书类别
	 * 
	 * @param user
	 * @param deptId
	 */
	@Transactional
	public void save(Tsxx tsxx, Integer lbId) {
		if (lbId != null) {
			tsxx.setLbxx(getDao().get(Lbxx.class, lbId));
			fileAttchManager.updateFileType(tsxx.getBookPhoto(),
					FileConstants.TSXX);
			getDao().saveOrUpdate(tsxx);
		}
		save(tsxx);
	}
	
	/**
	 * 删除图片
	 * 
	 * @param id
	 */
	@Transactional
	public void removeBookPhoto(Tsxx tsxx, ServletContext context) {
		fileAttchManager.removeByIds(tsxx.getBookPhoto(), context);
		tsxx.setBookPhoto(null);
		getDao().saveOrUpdate(tsxx);
	}

	
	/**
	 * 根据id得到图书对象，如果图书照片附件不存在，直接将carPhoto set null;
	 * 
	 * @param id
	 * @return Tsxx
	 */
	@Override
	@Transactional
	public Tsxx get(Serializable id) {
		Tsxx tsxx = super.get(id);
		if (tsxx != null) {
			String photoId = tsxx.getBookPhoto();
			if (StringUtils.isNotBlank(photoId)) {
				photoId = photoId.replace(",", "");
				if (StringUtils.isNumeric(photoId)) {
					FileAttch fileAttch = fileAttchManager.get(Integer.valueOf(photoId));
					if (fileAttch == null) {
						tsxx.setBookPhoto(null);
						getDao().saveOrUpdate(tsxx);
					} else {
						tsxx.setFileAttch(fileAttch);
					}
				}
			}
		}
		return tsxx;
	}
}
