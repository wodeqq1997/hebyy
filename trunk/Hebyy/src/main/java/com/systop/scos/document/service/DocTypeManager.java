package com.systop.scos.document.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.ApplicationException;
import com.systop.core.Constants;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.document.model.DocType;

/**
 * 文档类别管理类
 * 
 * @author Nice
 */
@Service
public class DocTypeManager extends BaseGenericsManager<DocType> {

	/**
	 * 用于计算文档类型编号
	 */
	@Autowired
	private DocTypeSerialNoManager serialNoManager;

	@Override
	@Transactional
	public void save(DocType entity) {
		Assert.notNull(entity);
		logger.debug("Parent dept {}", entity.getParentDocType());
		// 查询上级文档类型并建立双向关联
		DocType parent = entity.getParentDocType();
		getDao().evict(parent);
		if (parent != null && parent.getId() != null) {
			logger.debug("Parent ProductSort Id {}", entity.getParentDocType()
					.getId());
			parent = get(entity.getParentDocType().getId());
			if (parent != null) {
				parent.getChildDocTypes().add(entity);
				entity.setParentDocType(parent);
			}
		} else {
			entity.setParentDocType(null); // 处理parentId为null的情况
		}
		if (entity.getId() == null) {// 新建的文档类型编号
			entity.setSerialNo(serialNoManager.getSerialNo(entity,
					entity.getIsPublic(), entity.getOwner()));
		}
		getDao().getHibernateTemplate().clear();
		super.save(entity);
	}

	/**
	 * 查询给定用户的个人文档类别
	 * 
	 * @param userId
	 * @return
	 */
	public List<DocType> getDocTypes(Integer userId) {
		String hql = "from DocType dt where dt.owner.id = ? and dt.isPublic = ?";
		return query(hql, new Object[] { userId, Constants.NO });
	}

	public List<DocType> getPublicDocTypes() {
		String hql = "from DocType dt where dt.isPublic = ?";
		return query(hql, Constants.YES);
	}

	/**
	 * 查询给定用户的个人文档类别,并将每个 DocType转换成Map
	 * 
	 * @param userId
	 * @return
	 */
	public Map<Integer, String> getDocTypesInMap(Integer userId) {
		return toMap(getDocTypes(userId));
	}

	public Map<Integer, String> getPublicDocTypesInMap() {
		return toMap(getPublicDocTypes());
	}

	private Map<Integer, String> toMap(List<DocType> docTyps) {
		Map<Integer, String> dtMap = new HashMap<Integer, String>();
		if (docTyps != null) {

			for (DocType dt : docTyps) {
				dtMap.put(dt.getId(), dt.getName());
			}

		}
		return dtMap;
	}

	@Transactional
	public void remove(DocType dt) {
		if (dt != null) {
			if (isUseType(dt.getId())) {
				throw new ApplicationException("文档类型使用中,无法删除!");
			} else {
				getDao().delete(dt);
			}
		}
	}

	/**
	 * 检查类别是否正在使用
	 */
	public boolean isUseType(Integer id) {
		String hql = "select count(d.id) from Document d where d.docType.id = ?";
		Long count = (Long) getDao().findObject(hql, id);
		return count > 0;
	}

	/**
	 * 根据父ID获得文档类型并按日期排序，如果父ID为Null则获得顶级文档类型
	 * 
	 * @param parentId
	 * @param isPublic
	 *            （0：个人文档，1：公共文档）
	 * @param owner
	 *            个人文档时，需传user对象
	 * @return
	 */
	public List<DocType> getDocTypesByParnetId(Integer parentId,
			String isPublic, User owner) {
		List<DocType> docTypes = null;
		StringBuffer hql = new StringBuffer();
		List<Object> args = new ArrayList<Object>();
		if (parentId == null) {
			hql.append("from DocType dt where dt.parentDocType is null ");
			
		} else {
			hql.append("from DocType dt where dt.parentDocType.id = ? ");
			args.add(parentId);
		}
		hql.append("and dt.isPublic = ? ");
		args.add(isPublic);

		if (Constants.NO.equals(isPublic) && owner != null) {
			hql.append("and dt.owner.id = ? ");
			args.add(owner.getId());
		}

		hql.append("order by dt.id ");
		docTypes = query(hql.toString(), args.toArray());
		return docTypes;
	}
}
