package com.systop.scos.survey.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.survey.SurveyConstants;
import com.systop.scos.survey.model.Survey;
import com.systop.scos.survey.model.Voter;
@Service
public class VoterManager extends BaseGenericsManager<Voter> {

	/**
	 * 根据问卷调查的Id统计人数
	 * @param id
	 * @return
	 */
	public int count(Integer id){
		String hql = "select count(*) from Voter v where v.survey.id = ?";
		int count = ((Long) getDao().findObject(hql, id)).intValue();
		return count;
	}
	
	/**
	 * 根据问卷Id和用户Id判断是否已经参加过问卷调查
	 * @param surveyId
	 * @param userId
	 * @return String
	 */
	public String isJoin(Integer surveyId, Integer userId){
		String hql = "from Voter v where v.survey.id = ? and v.user.id = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(surveyId);
		args.add(userId);
		List<Voter> list = query(hql, args.toArray());
		if(list.size() != 0){
			return SurveyConstants.OVERSURVEY;
		}else{
			return SurveyConstants.UNFINISHED;
		}
	}
	
	/**
	 * 保存参加过的用户
	 * @param survey
	 * @param user
	 */
	@Transactional
	public void save(Survey survey, User user){
		Voter v = new Voter();
		v.setSurvey(survey);
		v.setUser(user);
		save(v);
	}
}
