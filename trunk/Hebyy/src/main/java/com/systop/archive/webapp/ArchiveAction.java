package com.systop.archive.webapp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.archive.model.Archive;
import com.systop.archive.service.ArchiveCabinetManager;
import com.systop.archive.service.ArchiveManager;
import com.systop.archive.service.ArchiveTypeManager;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;

/**
 * 工程档案管理Action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ArchiveAction extends DefaultCrudAction<Archive, ArchiveManager> {

	@Autowired
	private ArchiveTypeManager archiveTypeManager;

	@Autowired
	private ArchiveCabinetManager archiveCabinetManager;

	/**
	 * 查询档案
	 */
	@Override
	public String index() {
		StringBuffer sql = new StringBuffer("from Archive a where 1=1");
		List<Object> args = new ArrayList<Object>();

		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append(" and a.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		if (getModel().getArchiveType() != null
				&& getModel().getArchiveType().getId() != null) {
			sql.append(" and a.archiveType.id = ?");
			args.add(getModel().getArchiveType().getId());
		}

		sql.append(" order by a.archiveNO");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 借阅档案index
	 */
	public String archiveIndex() {
		this.index();
		return "archiveIndex";
	}

	/**
	 * 编辑档案
	 */
	@Override
	public String edit() {
		return super.edit();
	}

	/**
	 * 保存档案
	 */
	@Override
	public String save() {
		// 默认保存负责人
		getModel().setUser(getLoginUser());
		// 修改案卷类型需clear
		getManager().getDao().getHibernateTemplate().clear();
		return super.save();
	}

	@Override
	public String remove() {
		try {
			return super.remove();
		} catch (Exception e) {
			setModel(null);
			addActionError("该案卷已经使用，不允许删除");
			return this.index();
		}
	}

	/**
	 * 预览档案
	 */
	public String view() {
		return VIEW;
	}

	/**
	 * 选择档案
	 */
	public String showIndex() {
		this.index();
		return "showIndex";
	}

	/**
	 * 预览档案以及档案下的文件
	 */
	public String allView() {
        if (getModel().getId() == null) {
        }
        return "allView";
	}

	/**
	 * 所有档案类型MAP
	 * 
	 * @return Map
	 */
	public Map<Integer, String> getArchiveTypeMap() {
		return archiveTypeManager.getAllArchiveType();
	}

	/**
	 * 所有档案柜MAP
	 * 
	 * @return Map
	 */
	public Map<Integer, String> getArchiveCabinetMap() {
		return archiveCabinetManager.getAllArchiveCabinet();
	}
}