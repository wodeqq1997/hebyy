package com.systop.scos.subuser.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.ApplicationException;
import com.systop.core.Constants;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.communicate.smsg.service.MessageManager;
import com.systop.scos.subuser.model.SubUser;

@Service
public class SubUserManager extends BaseGenericsManager<SubUser> {
	
	
	@Autowired
	private MessageManager messageManager;
	
	/**
	 * 添加下属关系
	 * 
	 * @param ownerId
	 * @param userId
	 */
	@Transactional
	public void save(User owner, Integer userId, String contextPath) {
		if (owner.getId().intValue() != userId.intValue()){
			SubUser subUser = getSubUser(owner.getId(), userId);
			if (subUser == null) {
				subUser = new SubUser();
				subUser.setOwner(owner);
				subUser.setUser(new User(userId));
				save(subUser);
				Object[] args =  new Object[]{owner.getName(), contextPath, subUser.getId()};
				messageManager.saveSubUserMsg(args, subUser.getUser());
			} else {
				logger.warn("添加的下属关系已经存在,owner:" + subUser.getOwner().getName()
						+ ",user:" + subUser.getUser().getName());
			}
		}else{
			throw new ApplicationException("不允许添加自己为下属,请重新选择!");
		}
	}

	/**
	 * 获得下属
	 * 
	 * @param ownerId
	 * @param userId
	 * @return
	 */
	public SubUser getSubUser(Integer ownerId, Integer userId) {
		String hql = "from SubUser su where su.owner.id = ? and su.user.id = ?";
		return findObject(hql, new Object[] { ownerId, userId });
	}

	private List<SubUser> getSubs(Integer ownerId) {
		String hql = "from SubUser su where su.owner.id = ? and su.status = ?";
		return query(hql, ownerId , Constants.YES);
	}
	
	/**
	 * 获取下级用户
	 * @param ownerId
	 * @return
	 */
	public List<User> getSubUsers(Integer ownerId) {
		List<SubUser> subs = getSubs(ownerId);
		List<User> subUsers = new ArrayList<User>();
		for(SubUser su: subs){
			if (su.getUser() != null){
				subUsers.add(su.getUser());
			}
		}
		return subUsers;
	}
}
