package com.systop.archive.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.archive.model.ArchiveCabinet;
import com.systop.archive.service.ArchiveCabinetManager;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;

/**
 * 档案柜管理Action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ArchiveCabinetAction extends DefaultCrudAction<ArchiveCabinet, ArchiveCabinetManager> {

	/**
	 * 查询档案柜
	 */
	@Override
	public String index() {
		StringBuffer sql = new StringBuffer("from ArchiveCabinet a where 1=1");
		List<Object> args = new ArrayList<Object>();

		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append(" and a.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		sql.append(" order by a.createTime desc");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 编辑档案柜
	 */
	@Override
	public String edit() {
		return super.edit();
	}

	/**
	 * 保存档案柜
	 */
	@Override
	public String save() {
		// 默认保存负责人
		getModel().setUser(getLoginUser());
		return super.save();
	}

	/**
	 * 预览档案柜
	 */
	public String view() {
		return VIEW;
	}

	@Override
	public String remove() {
		try {
			return super.remove();
		} catch (Exception e) {
			setModel(null);
			addActionError("该档案柜已经使用，不允许删除");
			return this.index();
		}
	}
}