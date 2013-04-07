package com.systop.hebyy.hrm.extinfo.service;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.hrm.extinfo.model.EnterpriseExt;

/**
 * 
 * 企业档案管理
 * 
 * @author GaoRuoFan
 *
 */
@Service
public class EnterpriseExtManager extends BaseGenericsManager<EnterpriseExt> {

	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;

	@Autowired
	private UserManager userManager;
	
	/**
	 * 保存档案并关联到用户
	 * 
	 * @param userExt
	 * @param userId
	 */
	@Transactional
	public void save(EnterpriseExt userExt, Integer userId) {
		if(userExt != null){
			User user = null;
			if (userId != null) {
				user = getDao().get(User.class, userId);
			}
			if(user == null){
				throw new ApplicationException("该员工不存在！");
			}
			if (getDao().exists(userExt, "user.id")) {
				throw new ApplicationException("该员工企业档案已经存在！");
			}
				userExt.setUser(user);
			fileAttchManager.updateFileType(userExt.getFileAttchIds(),
					FileConstants.CERTIFICATE);
			getDao().saveOrUpdate(userExt);
			user.setEnterpriseExt(userExt);
			userManager.save(user);
		}
	}

	/**
	 * 删除档案的的同时删除证书附件
	 * @param entity
	 * @param context
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void remove(EnterpriseExt entity, ServletContext context) {
		if(entity.getFileAttchIds() != null && entity.getFileAttchIds().length() > 0)
			fileAttchManager.removeByIds(entity.getFileAttchIds(), context);		
		super.remove(entity);
	}
	
	/**
	 * 通过用户得到企业档案 
	 * @param user
	 * @return
	 */
	public EnterpriseExt getEnterpriseExt(User user){
		return findObject("from EnterpriseExt e where e.user.id = ?", user.getId());
	}
	
}
