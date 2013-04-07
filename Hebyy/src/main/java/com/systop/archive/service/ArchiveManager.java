package com.systop.archive.service;

import java.text.SimpleDateFormat;
import java.util.*;

import org.hibernate.criterion.MatchMode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.archive.model.Archive;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;

/**
 * 档案Service
 * 
 * @author SongBaoJie
 */
@Service
public class ArchiveManager extends BaseGenericsManager<Archive> {

	@Transactional
	public void save(Archive entity) {
		if (getDao().exists(entity, "archiveNO")) {
			throw new ApplicationException("该【案卷编号】已经存在,请您查证后再次录入");
		}
		if (entity.getId() == null) {
			entity.setCreateTime(new Date());
		}
		if (entity.getDept() != null && entity.getDept().getId() == null) {
			entity.setDept(null);
		}
		getDao().saveOrUpdate(entity);
	}


	/**
	 * 生成档案编号 组成：年份 + 档案类别标示（kc,djcl等）+（流水号不够2为前面补零），如：2012kc-01、2012djcl-111。
	 * 
	 * @param date
	 * @param mark
	 *            标示（kc, djcl等）
	 * @return
	 */

	@SuppressWarnings("rawtypes")
	public String getArchiveNO(Date date, String mark) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
		StringBuilder sb = new StringBuilder(dateFormat.format(date));
		List list = null;
		// dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			list = query(
					"select max(a.archiveNO) from Archive a where a.archiveNO like ? order by a.archiveNO desc",
					MatchMode.ANYWHERE
							.toMatchString(sb.append(mark).toString()));
			long count = 1l;
			if (list != null && list.size() > 0 && list.get(0) != null) {
				String s = list.get(0).toString();
                String _s = s.substring(s.lastIndexOf('-') + 1, s.length());
                count = new Long(_s) + 1;
			}
            //issue 958
			sb.append("-").append(fillZero(2, String.valueOf(count)));
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
