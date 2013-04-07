package com.systop.hebyy.hrm.resume.service;

import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.hrm.resume.model.ResumeTemplate;

/**
 * 
 * 简历模板管理
 * 
 * @author GaoRuoFan
 * 
 */
@Service
public class ResumeTemplateManager extends BaseGenericsManager<ResumeTemplate> {
	public ResumeTemplate getResumeTemplate() {
		return findObject("from ResumeTemplate");
	}
}
