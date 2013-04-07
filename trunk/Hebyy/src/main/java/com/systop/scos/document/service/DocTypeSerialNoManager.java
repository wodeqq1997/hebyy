package com.systop.scos.document.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.Constants;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.StringUtil;
import com.systop.scos.document.DocumentConstants;
import com.systop.scos.document.model.DocType;

/**
 * 计算文档类型编号<br>
 * <ul>
 * <li>同级文档类型，从01开始，最多99</li>
 * <li>文档类型编号等于"上级类型编号,类型编号",例如， 类型编号01，下属的小组编号为01,02</li>
 * </ul>
 * 
 * @author songbaojie
 */
@SuppressWarnings({ "unchecked", "rawtypes" })
@Service
public class DocTypeSerialNoManager extends BaseGenericsManager<DocType> {

	/**
	 * 返回给定文档类型的类型编号
	 * 
	 * @param parentProsort
	 *            给定文档类型
	 * 
	 */
	public String getSerialNo(final DocType type, String isPublic, User owner) {
		Assert.notNull(type, "The given DocType must not be null.");
		String serialNo = null;
		if (type.getParentDocType() != null) { // 如果有上级类型
			List<String> serialNos = new ArrayList<String>();
			if (isPublic.equals(Constants.NO) && owner != null) {
				serialNos = getDao()
						.query("select dt.serialNo from DocType dt "
								+ "where dt.parentDocType = ? and dt.isPublic = ? and dt.owner.id = ? order by dt.serialNo desc",
								type.getParentDocType(), isPublic,
								owner.getId());
			} else {
				serialNos = getDao()
						.query("select dt.serialNo from DocType dt "
								+ "where dt.parentDocType = ? and dt.isPublic = ? order by dt.serialNo desc",
								type.getParentDocType(), Constants.YES);
			}
			if (serialNos == null || serialNos.isEmpty()) { // 如果同级类型
				serialNo = buildFirstSerialNo(type.getParentDocType());
			} else { // 有同级级类型
				String maxSerialNo = (String) serialNos.get(0); // 同级类型最大编号
				// 找出同级类型最大编号的最后两位
				final String[] splited = org.springframework.util.StringUtils
						.commaDelimitedListToStringArray(maxSerialNo);
				if (splited == null || splited.length == 0) { // 同级类型没有编号
					serialNo = buildFirstSerialNo(type.getParentDocType());
				} else {// 计算当前类型编号
					Integer serial = StringUtil
							.getNumFromSerial(splited[splited.length - 1]);
					serialNo = type.getParentDocType().getSerialNo() + ","
							+ StringUtil.zeroPadding((serial + 1), 2);
				}
			}
		} else { // 如果没有上级类型
			serialNo = this.getTopProductSortSerialNo(isPublic, owner);
			type.setSerialNo(serialNo);
		}

		logger.debug("Create serial No." + serialNo);
		return serialNo;
	}

	/**
	 * 计算顶级文档类型编号
	 */
	public String getTopProductSortSerialNo(String isPublic, User owner) {
		List<String> serialNos = new ArrayList<String>();
		if (isPublic.equals(Constants.NO) && owner != null) {
			serialNos = getDao()
					.query("select dt.serialNo from DocType dt "
							+ "where dt.parentDocType is null and dt.isPublic = ? and dt.owner.id = ? order by dt.serialNo desc",
							isPublic, owner.getId());
		} else {
			serialNos = getDao()
					.query("select dt.serialNo from DocType dt "
							+ "where dt.parentDocType is null and dt.isPublic = ? order by dt.serialNo desc",
							Constants.YES);
		}
		// 没有文档类型
		if (serialNos == null || serialNos.isEmpty()) {
			return buildFirstSerialNo(null);
		}
		String maxSerialNo = (String) serialNos.get(0);
		// 文档类型编号为null
		if (StringUtils.isBlank(maxSerialNo)) {
			return buildFirstSerialNo(null);
		} else {
			Integer serial = StringUtil.getNumFromSerial(maxSerialNo);
			return StringUtil.zeroPadding((serial + 1), 2);
		}
	}

	/**
	 * 根据上级文档类型和当前文档类型的前一个编号，获得当前类型编号的数字表示 ， 用于重置所有文档类型编号:<br>
	 * 首先根据上级文档类型编号，计算同级文档类型的第一个编号，以后便再此基础上 +1即可。
	 */
	private Integer getSerial(DocType docType, final Integer preSerial,
			String isPublic, User owner) {
		Integer serial = null;
		if (preSerial == null) {
			String serialNo = getSerialNo(docType, isPublic, owner);
			if (StringUtils.isNotBlank(serialNo)) {
				String[] splits = org.springframework.util.StringUtils
						.commaDelimitedListToStringArray(serialNo);
				if (splits != null && splits.length > 0) {
					serial = StringUtil
							.getNumFromSerial(splits[splits.length - 1]);
				} else {
					serial = 0;
				}
			}
		} else {
			serial = preSerial + 1;
		}

		return serial;
	}

	/**
	 * 重设所有类型编号。
	 */
	@Transactional
	public void updateAllSerialNo(String isPublic, User owner) {
		List<DocType> tops = new ArrayList<DocType>();
		if (isPublic.equals(Constants.NO) && owner != null) {
			tops = getDao()
					.query("from DocType d where d.parentDocType is null and dt.isPublic = ? and dt.owner.id = ?",
							isPublic, owner.getId());			
		}else{
			tops = getDao()
					.query("from DocType d where d.parentDocType is null and dt.isPublic = ?",
							Constants.YES);
		}
		Map serialMap = new HashMap(100); // 用于存放类型ID-SerialNo
		// 计算所有类型编号，并将类型ID-类型编号的对应关系存入serialMap
		Integer serial = null;
		for (DocType type : tops) {
			serial = this.getSerial(type, serial, isPublic, owner);
			// String serialNo = getSerialNo(top);
			type.setSerialNo(buildSerialNo(null, serial));
			serialMap.put(type.getId(), buildSerialNo(null, serial));
			// getDao().saveObject(top);
			if (type.getChildDocTypes().size() > 0) {
				this.updateChildrenSerialNo(type, serialMap, isPublic, owner);
			}
		}
		// 批量更新类型编号
		Set<Integer> ids = serialMap.keySet();
		for (Integer id : ids) {
			DocType type = get(id);
			getDao().evict(type);
			type.setSerialNo((String) serialMap.get(id));
			getDao().getHibernateTemplate().update(type);
		}
	}

	/**
	 * 更新所有子文档类型的SerialNo
	 */
	@Transactional
	public void updateChildrenSerialNo(DocType parent, Map serialMap,
			String isPublic, User owner) {
		logger.debug("Update " + parent.getName() + "'s children serial No.");
		Set<DocType> children = parent.getChildDocTypes();
		Integer serial = null;
		for (DocType child : children) {
			serial = this.getSerial(child, serial, isPublic, owner);
			child.setSerialNo(buildSerialNo(parent, serial));
			serialMap.put(child.getId(), buildSerialNo(parent, serial));
			// getDao().saveObject(child);
			if (child.getChildDocTypes().size() > 0) {
				updateChildrenSerialNo(child, serialMap, isPublic, owner);
			}
		}
	}

	/**
	 * 构建第一个文档类型的编号
	 */
	private static String buildFirstSerialNo(DocType parent) {
		if (parent == null) {
			return DocumentConstants.FIRST_SERIAL_NO;
		} else {
			return new StringBuffer(100).append(parent.getSerialNo())
					.append(",").append(DocumentConstants.FIRST_SERIAL_NO)
					.toString();
		}
	}

	/**
	 * 构建文档类型编号
	 */
	private static String buildSerialNo(DocType parent, Integer serial) {
		if (parent == null) {
			return StringUtil.zeroPadding(serial, 2);
		} else {
			return new StringBuffer(100).append(parent.getSerialNo())
					.append(",").append(StringUtil.zeroPadding(serial, 2))
					.toString();
		}
	}

}
