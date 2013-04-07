package com.systop.video.action;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.common.modules.template.Template;
import com.systop.common.modules.template.TemplateContext;
import com.systop.common.modules.template.TemplateRender;
import com.systop.video.VideoApplicationContext;
import com.systop.video.VideoConstants;

@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoUsersAction {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoUsersAction.class);
	@Autowired
	private UserManager userManager;
	@Autowired
	private TemplateRender templateRender;

	/**
	 * 客户端调用<br>
	 * 得到已当前人员所在区县人员列表,以填充房间信息中人员列表备选
	 * 
	 * @return
	 */

	@SuppressWarnings("null")
	@Deprecated
	public String refreshUsers1(String userId, String currentRoomMembersStr,
			VideoApplicationContext ctx) {
		Assert.notNull(userId);

		/*
		 * final List<User> users = userManager.getDao().query(
		 * "select u from User u left join fetch u.dept where u.id <> ?", new
		 * Object[] { Integer.valueOf(userId) });
		 */
		User user = userManager.findObject(
				"select u from User u left join fetch u.dept where u.id = ? ",
				Integer.valueOf(userId));
		//Dept dept = roomManager.getCountyByUser(user);
		//final List<User> users = roomManager.getUsersByCounty(dept);
		final List<User> users = null;//roomManager.getAllUsers();
		// 得到房间已有成员
		List<User> currentRoomMembers = new ArrayList<User>();
		if (StringUtils.isNotBlank(currentRoomMembersStr)) {
			String[] ids = currentRoomMembersStr.split(VideoConstants.SPLITER);
			for (String id : ids) {
				currentRoomMembers.add(userManager.get(Integer.valueOf(id)));
			}
		}

		// 从人员列表中剔除已有的成员
		users.removeAll(currentRoomMembers);
		users.remove(user);// 在用户列表中排除当前用户自己
		// users.add(userManager.get(Integer.valueOf(userId)));
		/* logger.info("总共{}个用户", users.size()); */
		// 用模板生成xml
		Template template = new Template("userListXml");
		TemplateContext templateCtx = new TemplateContext();
		templateCtx.setTemplate(template);
		templateCtx.addParameter("users", users);
		StringWriter writer = new StringWriter();
		templateCtx.setWriter(writer);
		try {
			templateRender.renderTemplate(templateCtx);
		} catch (Exception e) {
			logger.error("An error has occurs. {}", e.getMessage());
			e.printStackTrace();
		}
		/*
		 * logger.info("返回XML数据供客户端刷新登录人员列表"); logger.info(writer.toString());
		 */
		return writer.toString();
	}
}
