package com.systop.scos.document.webapp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.ApplicationException;
import com.systop.core.Constants;
import com.systop.core.dao.support.Page;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.document.model.Document;
import com.systop.scos.document.service.DocTypeManager;
import com.systop.scos.document.service.DocumentManager;

/**
 * 文档信息Action,负责处理与之相关的各种请求 WangYaping修改（添加分享功能）
 * 
 * @author Nice
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class DocumentAction extends
		DefaultCrudAction<Document, DocumentManager> {

	@Autowired
	private DocTypeManager docTypeManager;

	private String docTypeId;
	// 附件ID
	private String fileAttchIds;

	// 文档编辑页面select标签使用
	private Map<Integer, String> docTypesInMap;

	public String index() {
		return INDEX;
	}

	/**
	 * 我的文档列表
	 */
	public String myDocumentIndex() {
		// 添加注释
		restorePageData(buildQuery(false));
		return "myDocumentIndex";
	}

	/**
	 * 公共文档列表
	 */
	public String publicDocumentIndex() {
		// 添加注释
		restorePageData(buildQuery(true));
		return "publicDocumentIndex";
	}

	/**
	 * 构建查询条件 WangYaping修改
	 * 
	 * @param loginUser
	 *            根据登录用户查询，可以为null,如果为null则忽略该参数
	 * @param isPublic
	 *            查询文档是否共享，可以为null,如果为null则忽略该参数
	 * @return
	 */
	private Page buildQuery(boolean isPublic) {
		StringBuffer hsql = new StringBuffer("from Document d where 1 = 1");
		// 参数集合
		List<Object> args = new ArrayList<Object>();

		if (isPublic) {// 判断是否查询共享文档
			hsql.append(" and d.isPublic = ?");
			args.add(Constants.YES);

		} else {
			hsql.append(" and d.owner.id = ? ");
			args.add(getLoginUser().getId());// 查询属于该用户的文档
			// args.add(Constants.NO);
		}

		if (StringUtils.isNotBlank(getModel().getTitle())) {// 根据标题模糊查询
			hsql.append(" and d.title like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getTitle()));
		}

		if (StringUtils.isNotBlank(getModel().getKeyWord())) {// 根据关键字模糊查询
			hsql.append(" and d.keyWord like ?");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getKeyWord()));
		}

		if (getModel().getDocType() != null
				&& getModel().getDocType().getId() != null) {// 根据文档类别查询
			if (getModel().getDocType().getId() > 0) {
				hsql.append(" and d.docType.id = ?");
				args.add(getModel().getDocType().getId());
			}
		}

		hsql.append(" order by d.createTime desc");

		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hsql.toString(), args.toArray());
		return page;
	}

	/**
	 * 文档信息保存
	 */
	public String save() {
		try {
			if (getModel().getId() == null
					&& !Constants.YES.equals(getModel().getIsPublic())) {
				getModel().setOwner(getLoginUser());
			}
			if (StringUtils.isNotBlank(fileAttchIds)) {
				getModel().setFileattchIds(fileAttchIds);
			}
			getManager().save(getModel());
			if (Constants.YES.equals(getModel().getIsPublic())) {
				return "publicSuccess";
			} else {
				return "mySuccess";
			}
		} catch (ApplicationException e) {
			addActionError(e.getMessage());
			return INPUT;
		}
	}

	/**
	 * @author WangYaping 用于将个人文档分享到公共文档中
	 */
	public String share() {
		if (getModel().getId() != null && StringUtils.isNotBlank(docTypeId)) {
			Document document = new Document();
			getModel().setStatus(getModel().getId().toString());
			getManager().save(getModel());
			document = getModel();
			document.setId(null);
			document.setDocType(docTypeManager.get(Integer.parseInt(docTypeId)));
			document.setIsPublic(Constants.YES);
			document.setOwner(null);
			getManager().save(document);
		}
		return "mySuccess"; // 跳回个人文档页面

	}

	/**
	 * @author WangYaping 跳转到“文档分享页面”
	 */
	public String toShare() {
		return "share"; // 跳回个人文档页面

	}

	/**
	 * 取消分享
	 */
	public String desShare() {
		if (getModel().getId() != null) {
			String hql = "from Document d where d.status = ? ";
			List<Document> list = getManager().query(hql,
					getModel().getStatus());
			if (list != null) {
				for (Document document : list) {
					if (Constants.YES.equals(document.getIsPublic())) {
						getManager().remove(document);
					}
				}
			}
			getModel().setStatus(null);
			getManager().save(getModel());
		}
		setModel(null);
		return this.myDocumentIndex();
	}

	public String remove() {
		if (StringUtils.isNotBlank(getModel().getStatus())) {
			String hql = "from Document d where d.status = ? ";
			List<Document> list = getManager().query(hql,
					getModel().getStatus());
			if (list != null) {
				for (Document document : list) {
					getManager().remove(document);
				}
			}
		}
		if (Constants.YES.equals(getModel().getIsPublic())) {
			return "publicSuccess";
		} else {
			return "mySuccess";
		}
	}

	/**
	 * 查询获取文档类别.个人
	 * 
	 * @return
	 */
	public Map<Integer, String> getPrivateDocTypesInMap() {
		docTypesInMap = docTypeManager.getDocTypesInMap(getLoginUser().getId());
		return docTypesInMap;
	}

	/**
	 * 查询获取文档类别.公共
	 * 
	 * @return
	 */
	public Map<Integer, String> getPublicDocTypesInMap() {
		docTypesInMap = docTypeManager.getPublicDocTypesInMap();
		return docTypesInMap;
	}

	public String getFileAttchIds() {
		return fileAttchIds;
	}

	public void setFileAttchIds(String fileAttchIds) {
		this.fileAttchIds = fileAttchIds;
	}

	public String getDocTypeId() {
		return docTypeId;
	}

	public void setDocTypeId(String docTypeId) {
		this.docTypeId = docTypeId;
	}

}
