package com.systop.video.service;

import java.util.ArrayList;
import java.util.List;

import org.red5.server.api.IConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.systop.video.VideoConstants;

@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoAppconnectManager {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoAppconnectManager.class);

	@SuppressWarnings("rawtypes")
	public boolean appConnect(IConnection conn, Object[] params) {
		logger.info("--appConnect--------video---------->" + "用户连接scope:{}",
				conn.getScope().getParent());
		String userId = null;
		if (params != null && params.length > 0 && params[0] != null) {
			if (params[0] instanceof String) {
				userId = params[0].toString();
			} else if (params[0] instanceof ArrayList) {
				List paramList = (List) params[0];
				userId = paramList.get(0).toString();// 房主id
			}
		}
		// 验证参数是否合法
	/*	if (ArrayUtils.isEmpty(params) || params[0] == null
				|| StringUtils.isBlank(params[0].toString())) {
			logger.info("参数不合法");
			// 本类实现了IPendingServiceCallback,(实现了resultReceived)即可以作为参数传递给call方法
			VideoUtils.call(conn, VideoConstants.CLIENT_METHOD_NOT_LOGIN, null,
					new BasePendingServiceCallback());
			return false;
		}*/

		// 验证用户是否登录
		/*if (!isAlreadyLogin(userId)) {
			logger.info("未登录");
			VideoUtils.call(conn, VideoConstants.CLIENT_METHOD_NOT_LOGIN, null,
					new BasePendingServiceCallback());
			return false;
		}*/
		// 验证是否已经视频登录
		/*if (isVideoOnline(userId)) {
			logger.info("--2--------video---------->" + "用户{}试图重复连接视频",
					params[0].toString());
			VideoUtils.call(conn, VideoConstants.CLIENT_METHOD_DUPLE_CONNECT,
					null, new BasePendingServiceCallback());
			return false;
		} else {
			userManager.setVideoOnline(
					userManager.get(Integer.valueOf(userId)), Constants.YES);
		}*/
		conn.getClient().setAttribute(VideoConstants.USER_CLIENT_ATTR_KEY,
				userId);
		return true;
	}

	/**
	 * 验证指定的用户id是否已经登录
	 * 
	 * @param userId 指定用户id
	 * @return 是否已经登录
	 */
	/*private boolean isAlreadyLogin(String userId) {
		User user = userManager.get(Integer.valueOf(userId));
		return userManager.isUserOnline(user);
	}*/

	/**
	 * 验证一个用户是否视频在线
	 * 
	 * @param userId 要验证的用户的id
	 * @return 是否视频在线
	 */

	/*private boolean isVideoOnline(String userId) {
		User user = userManager.get(Integer.valueOf(userId));
		return userManager.isVideoOnLine(user);
	}*/
}
