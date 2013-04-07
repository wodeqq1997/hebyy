package com.systop.scos.info.article.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.info.article.model.ArticleType;

/**
 * 文章类型管理，涉及相关业务及数据库操作等
 * 
 * @author SongBaoJie
 */
@Service
public class ArticleTypeManager extends BaseGenericsManager<ArticleType> {
	
	@Override
	@Transactional
	public void save(ArticleType entity) {
		if (getDao().exists(entity, "name")) {
			throw new ApplicationException("该新闻类别名称已经存在,请您查证后再次录入");
		}
		super.save(entity);
	}

	/**
	 * 得到所有文章类型
	 * 
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getAllArticleType() {
		Map typeMap = new LinkedMap();
		StringBuffer sql = new StringBuffer("from ArticleType a where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		List<ArticleType> list = getDao().query(sql.toString(),args.toArray());
		for (ArticleType a : list) {
			typeMap.put(a.getId(), a.getName());
		}
		return typeMap;
	}

	/**
	 * 根据文章类型ID判断项目中是否使用该类型
	 * 
	 * @param id
	 * @return
	 */
	public boolean isUseArticleType(Integer id) {
		// TODO
		// ArticleType articleType = get(id);
		// if(articleType.getArticles().size() > 0){
		// return false;
		// }
		return true;
	}
}
