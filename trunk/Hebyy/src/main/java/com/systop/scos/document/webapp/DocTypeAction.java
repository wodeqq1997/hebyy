package com.systop.scos.document.webapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.common.modules.security.user.UserUtil;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.ApplicationException;
import com.systop.core.Constants;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.document.model.DocType;
import com.systop.scos.document.service.DocTypeManager;

/**
 * @author XuRan
 */

/*
 * 显示文档类型信息
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class DocTypeAction extends DefaultCrudAction<DocType, DocTypeManager> {

	// 请求是否公告类别
	public String isPublic;

	private DocType docType;

	private Map<String, Object> result;

	// AJAX调用返回变量(JSON)
	private List<Map<String, Object>> docTypes;

	/* 显示文档类型信息 */
	public String index() {
		// if(StringUtils.isNotBlank(getModel().getIsPublic())
		// && getModel().getIsPublic().equals(Constants.YES)){
		// return "publicIndex";
		// }
		// StringBuffer sql = new StringBuffer("from DocType dt where 1=1");
		// List<Object> args = new ArrayList<Object>();
		// if (StringUtils.isNotBlank(getModel().getName())) {
		// sql.append(" and dt.name like ?");
		// args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		// }
		// if (Constants.YES.equals(getModel().getIsPublic())) {
		// sql.append(" and dt.isPublic = ?");
		// args.add(getModel().getIsPublic());
		// } else {
		// sql.append(" and dt.owner.id = ?");
		// args.add(getLoginUser().getId());
		// }
		// page = PageUtil.getPage(getPageNo(), getPageSize());
		// page = getManager().pageQuery(page, sql.toString(), args.toArray());
		// restorePageData(page);
		return INDEX;
	}

	/* 保存文档类型信息 */
	public String save() {
		if (getModel().getId() == null
				&& !Constants.YES.equals(getModel().getIsPublic())) {
			getModel().setOwner(getLoginUser());
		}
		return super.save();
	}

	/**
	 * 保存数据，异步调用(保存公共文档类型)
	 */
	public String saveAsynch() {
		result = new HashMap<String, Object>();
		getLoginUser();
		try {
			if (getModel().getId() == null) {// 添加,需要赋值上级类型
				String parentId = getRequest().getParameter("parentId");
				if (StringUtils.isNumeric(parentId)) {
					DocType parent = getManager()
							.get(Integer.valueOf(parentId));
					getModel().setParentDocType(parent);
				}
			}

			docType = getModel();// 从model中得到对象
			if (StringUtils.isNotBlank(docType.getIsPublic())
					&& docType.getIsPublic().equals(Constants.NO)) {
				docType.setOwner(getLoginUser());
			}
			
			getManager().save(docType);
			result.put("success", true);
			result.put("id", docType.getId());
			result.put("text", docType.getName());
			result.put("descn", docType.getDescn());
			// result.put("status", docType.getStatus());
		} catch (ApplicationException e) {
			result.put("failure", true);
			result.put("msg", e.getMessage());
			e.printStackTrace();
		}
		return "complete";
	}

	/**
	 * 删除数据，异步调用（删除公共文档）
	 */
	public String removeAsynch() {
		result = new HashMap<String, Object>();
		User u = UserUtil.getPrincipal(getRequest());
		if (u != null) {
			if (getModel() != null && getModel().getId() != null) {
				// 判断此类型下是否有文档使用，如果有不可删除
				if (getManager().isUseType(getModel().getId())) {
					result.put("success", false);
					result.put("msg", "该类型下已经存在关联文档,不可删除!");
				} else {
					getManager().remove(getModel());
					result.put("success", true);
					result.put("msg", "删除成功!");
				}
			} else {
				result.put("success", false);
				result.put("msg", "删除的对象已不存在");
			}
		}
		return "complete";
	}

	/**
	 * 判断所删除文档类型是否正在使用
	 */
	public String remove() {
		try {
			getManager().remove(getModel());
			return SUCCESS;
		} catch (ApplicationException e) {
			addActionError(e.getMessage());
			return this.index();
		}
	}

	/**
	 * 构建文档类型
	 * 
	 * @return
	 */
	public String docTypeTree() {
		List<DocType> tops = null;
		// String status = getRequest().getParameter("status");//
		// (String)getRequest().getAttribute("status");

		// 如果isPublic为0则只得到个人文档类型, 1:公共文档
		if (StringUtils.isNotBlank(getModel().getIsPublic())
				&& getModel().getIsPublic().equals(Constants.YES)) {
			tops = getManager()
					.getDocTypesByParnetId(null, Constants.YES, null);
		} else {
			tops = getManager().getDocTypesByParnetId(null, Constants.NO,
					getLoginUser());
		}

		docTypes = new ArrayList<Map<String, Object>>();
		for (DocType type : tops) {
			Map<String, Object> top = toMap(type);
			top = buildTreeByParent(top, true);
			docTypes.add(top);
		}
		return "tree";
	}

	/**
	 * 根据父ID构建JSON数据
	 * 
	 * @param parent
	 * @param nested
	 *            是否嵌套
	 * @return
	 */
	private Map<String, Object> buildTreeByParent(Map<String, Object> parent,
			boolean nested) {
		if (parent == null || parent.get("id") == null) {
			return null;
		}
		List<DocType> subs = new ArrayList<DocType>();
		// 如果isPublic为0则只得到个人文档类型
		if (StringUtils.isNotBlank(getModel().getIsPublic())
				&& getModel().getIsPublic().equals(Constants.NO)) {
			subs = getManager().getDocTypesByParnetId(
					(Integer) parent.get("id"), Constants.NO, getLoginUser());
		} else {
			subs = getManager().getDocTypesByParnetId(
					(Integer) parent.get("id"), Constants.YES, null);
		}
		List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
		for (DocType sub : subs) {
			Map<String, Object> child = toMap(sub);
			if (nested) {
				child = buildTreeByParent(child, nested);
			}
			children.add(child);
		}
		if (!children.isEmpty()) {
			parent.put("children", children);
			parent.put("leaf", false);
		} else {
			parent.put("leaf", true);
		}
		return parent;
	}

	/**
	 * 将商品类型中的部分内容存储到MAP中
	 * 
	 * @param p
	 * @return
	 */
	private Map<String, Object> toMap(DocType type) {
		Map<String, Object> map = null;
		if (type != null) {
			map = new HashMap<String, Object>();
			map.put("id", type.getId());
			map.put("text", type.getName());
			map.put("descn", type.getDescn());
			map.put("isPublic", type.getIsPublic());

			// map.put("status", type.getStatus());
			// if (p.getStatus() != null && p.getStatus().equals("0")) {
			// map.put("cls", "isStatusNo");
			// }
			// map.put("iconCls", "x-tree-node-icon");
		}
		return map;
	}

	public DocType getDocType() {
		return docType;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public List<Map<String, Object>> getDocTypes() {
		return docTypes;
	}
}
