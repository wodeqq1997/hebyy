package com.systop.scos.diary.webapp;

import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.diary.model.DiaryComment;
import com.systop.scos.diary.service.DiaryCommentManager;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.Date;

/**
 * 项目日志评论管理action
 * 
 * @author SongBaoJie
 * 
 */
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class DiaryCommentAction extends
		DefaultCrudAction<DiaryComment, DiaryCommentManager> {

	@Override
	public String save() {
		getModel().setUser(getLoginUser());
		getModel().setCreateTime(new Date());
		return super.save();
	}
}
