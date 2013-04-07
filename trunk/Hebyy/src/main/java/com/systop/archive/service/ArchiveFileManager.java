package com.systop.archive.service;


import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.archive.model.ArchiveFile;
import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;

/**
 * 档案文件Service
 * 
 * @author SongBaoJie
 */
@Service
public class ArchiveFileManager extends BaseGenericsManager<ArchiveFile> {
	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;

	/**
	 * 技术方案保存
	 */
	@Transactional
	public void save(ArchiveFile file) {
		if (getDao().exists(file, "archive.id", "name")) {
			throw new ApplicationException("该案卷下【文件名】重复,请您查证后再次录入");
		}
		if (file != null) {
			if(file.getId() == null){
				file.setCreateTime(new Date());
			}
			// 当存在附件id时反向修改附件的类别信息
			fileAttchManager.updateFileType(file. getAttachIds(), FileConstants.ARCHIVE_FILE);
			getDao().saveOrUpdate(file);
		}
	}
	
	

}

