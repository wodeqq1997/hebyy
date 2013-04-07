package com.systop.scos.survey.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.survey.model.SurveySubitem;

/**
 * 问卷调查选项管理
 * 
 * @author LinJie
 */
@Service
public class SurveySubitemManager extends BaseGenericsManager<SurveySubitem> {

	/**
	 * 根据Id修改投票百分比和得票数
	 * 
	 * @param id
	 */
	@Transactional
	public void save(Integer id, int count) {
		SurveySubitem surveySubitem = this.get(id);
		int votesCount = surveySubitem.getVotesCount();
		votesCount = votesCount + 1;
		float percent = (float) votesCount / count * 1000;
		surveySubitem.setVotesCount(votesCount);
		surveySubitem.setPercent((int) percent);
		surveySubitem.setVotesCount(votesCount);
		update(surveySubitem);
		List<SurveySubitem> list = query(
				"from SurveySubitem s where s.surveyItem.id = ?", surveySubitem
						.getSurveyItem().getId());
		for (SurveySubitem surveySub : list) {
			surveySub.setPercent((int)((float)surveySub.getVotesCount() / count * 1000));
			update(surveySub);
		}
	}
}
