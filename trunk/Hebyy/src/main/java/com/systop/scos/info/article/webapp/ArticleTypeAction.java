package com.systop.scos.info.article.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.info.article.model.ArticleType;
import com.systop.scos.info.article.service.ArticleTypeManager;

/**
 * 文章类型信息Action,负责处理与之相关的各种请求
 * 
 * @author SongBaoJie
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ArticleTypeAction extends
		DefaultCrudAction<ArticleType, ArticleTypeManager> {
	/**
	 * 查询显示文章类型信息
	 */
	public String index() {
		page = PageUtil.getPage(getPageNo(), getPageSize());
		StringBuffer sql = new StringBuffer("from ArticleType a where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append("and a.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
	
	public String save(){
		// 当前登录用户所属分公司id
		getManager().save(getModel());
		return SUCCESS;
	}

	@Override
	public String remove() {
		if (getModel() != null) {
			if (getManager().isUseArticleType(getModel().getId())) {
				return super.remove();
			} else {
				setModel(null);
				addActionError("该文章类型中已经使用，不允许删除");
				return this.index();
			}
		} else {
			setModel(null);
			addActionError("该文章类型不存在，删除失败");
			return this.index();
		}
	}
	
	/**
	 * 获得首页显示所需的文章类别
	 * @return
	 */
	public String indexTypes(){
		StringBuffer sql = new StringBuffer("from ArticleType a where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		sql.append("order by a.orderId ");
		items = getManager().query(sql.toString(),args.toArray());
		return "indexTypes";
	}
}
