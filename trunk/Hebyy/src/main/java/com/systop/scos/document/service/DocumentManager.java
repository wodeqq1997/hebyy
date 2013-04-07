package com.systop.scos.document.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.document.model.Document;

/**
 * 文档信息管理，涉及相关业务及数据库操作等
 * 
 * @author Nice
 */
@Service
public class DocumentManager extends BaseGenericsManager<Document> {

	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;

	/**
	 * 文档信息保存，第一次创建的时候保存createTime
	 */
	@Transactional
	public void save(Document document) {
		if (document != null) {
			if (document.getId() == null) {
				document.setCreateTime(new Date());
			}
			//文件保存为默认类别时，设置文件类型id为空
			if(document.getDocType().getId() == 0) {
				document.setDocType(null);
			}
			// 当存在附件id时反向修改附件的类别信息
			fileAttchManager.updateFileType(document.getFileattchIds(), FileConstants.DOCUMENT);
			getDao().getHibernateTemplate().clear();//清除Hibernate缓存
			getDao().saveOrUpdate(document);
		}
	}
}
