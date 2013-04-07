package com.systop.scos.communicate.mail.service;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.communicate.mail.model.Mail;

@Service
public class MailManager extends BaseGenericsManager<Mail> {

	@Autowired
	private FileAttchManager fileAttchManager;
	
	/**
	 * 保存邮件，更新附件的类别信息
	 */
	@Transactional
	public void save(Mail mail){
		if (mail != null){
			if (StringUtils.isNotBlank(mail.getFileIds())){
				fileAttchManager.updateFileType(mail.getFileIds(), FileConstants.MAIL);
			}
			mail.setSendTime(new Date());//创建日期
			getDao().save(mail);
		}
	}
}
