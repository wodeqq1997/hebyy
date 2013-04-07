package com.systop.hebyy.hrm.contract.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.dao.support.Page;
import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.hrm.contract.model.EmpContract;

/**
 * 
 * 员工合同管理
 * 
 * @author GaoRuoFan
 *
 */
@Service
public class EmpContractManager  extends BaseGenericsManager<EmpContract> {

	/**
	 * 保存员工合同并关联指定的用户
	 * 
	 * @param userContract
	 * @param userId
	 */
	@Transactional
	public void save(EmpContract empContract,Integer userId) {
		if (userId != null) {
			empContract.setUser(getDao().get(User.class, userId));
		}
		save(empContract);
	}
	
	/**
	 * 得到员工合同信息
	 * 
	 * @param page 分页对象
	 * @param 用户ID 
	 * @return
	 * List<UserContract>
	 */
	@SuppressWarnings("unchecked")
	public List<EmpContract> getUserContractByUid(Page page,int userId){
		page = getDao().pagedQuery(page, "from EmpContract e where e.user.id = ? ", userId);
		return page.getData();
	}

    public EmpContract currentContract(Integer id){
        EmpContract contract = findObject("from EmpContract e where e.user.id=? order by e.startTime desc", id);
        return contract;
    }
}
