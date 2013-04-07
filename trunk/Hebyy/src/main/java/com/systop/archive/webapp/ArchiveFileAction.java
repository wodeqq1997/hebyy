package com.systop.archive.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.archive.model.Archive;
import com.systop.archive.model.ArchiveFile;
import com.systop.archive.service.ArchiveFileManager;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;

/**
 * 档案类型管理Action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings({ "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class ArchiveFileAction extends
		DefaultCrudAction<ArchiveFile, ArchiveFileManager> {

    private List<Archive> archiveList;

    /**
	 * 查询档案类型
	 */
	@Override
	public String index() {
		StringBuffer sql = new StringBuffer("from ArchiveFile a where 1=1");
		List<Object> args = new ArrayList<Object>();

		if (StringUtils.isNotBlank(getModel().getName())) {
			sql.append(" and a.name like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		
		if(getModel().getArchive() != null ){
			if (StringUtils.isNotBlank(getModel().getArchive().getName())) {
				sql.append(" and a.archive.name like ?");
				args.add(MatchMode.ANYWHERE.toMatchString(getModel().getArchive().getName()));
			}else if(getModel().getArchive().getId() != null){
				sql.append(" and a.archive.id = ?");
				args.add(getModel().getArchive().getId());
			}
		}

//		sql.append(" order by a.createTime desc");
		sql.append(" order by a.fileNO");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, sql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 借阅文件index
	 */
	public String fileIndex() {
		this.index();
		return "fileIndex";
	}

	/**
	 * 编辑档案类型
	 */
	@Override
	public String edit() {
		return super.edit();
	}

	/**
	 * 保存档案类型
	 */
	@Override
	public String save() {
		// 默认保存负责人
		getModel().setUser(getLoginUser());
		// 所属案卷修改时容易发生异常，需要clear 
		getManager().getDao().getHibernateTemplate().clear();
		return super.save();
	}

	/**
	 * 预览档案类型
	 */
	public String view() {
		// 前台标示，判断是否需要显示附件。
		String sign = getRequest().getParameter("sign");
		// 判断附件是否可见
		if (StringUtils.isNotEmpty(sign) && sign.equals("viewFile")) {
			getRequest().setAttribute("sign", sign);
		}
		return VIEW;
	}

	@Override
	public String remove() {
		try {
			return super.remove();			
		} catch (Exception e) {
			setModel(null);
			addActionError("该档案文件已经使用，不允许删除");
			return this.index();
		}
	}

    public String editPayment(){
        return super.edit();
    }

    public List<Archive> getArchiveList() {
        return archiveList;
    }

    public void setArchiveList(List<Archive> archiveList) {
        this.archiveList = archiveList;
    }
}