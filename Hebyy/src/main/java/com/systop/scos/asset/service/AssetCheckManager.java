package com.systop.scos.asset.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.asset.model.AssetCheck;

/**
 * 设备物资检测记录
 *@author LinJie
 *@version 1.0
 */
@Service
public class AssetCheckManager extends BaseGenericsManager<AssetCheck> {

	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;
	
	@Override
	@Transactional
	public void save(AssetCheck entity) {
		if (entity != null) {
			// 当存在附件id时反向修改附件的类别信息
			fileAttchManager.updateFileType(entity.getAttachIds(),
					FileConstants.ASSET_CHECK);
			getDao().saveOrUpdate(entity);
		}
	}
	

}
