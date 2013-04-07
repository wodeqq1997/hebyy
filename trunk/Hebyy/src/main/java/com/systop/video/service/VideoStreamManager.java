package com.systop.video.service;

import java.util.Set;

import org.apache.commons.lang.xwork.StringUtils;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.Red5;
import org.red5.server.api.stream.IBroadcastStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.systop.video.VideoApplicationContext;
import com.systop.video.VideoConstants;
import com.systop.video.util.IConnectionCallback;
import com.systop.video.util.VideoUtils;

@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoStreamManager {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoStreamManager.class);

	/**
	 * 视频广播.
	 */
	public void streamBroadcastStart(final IBroadcastStream stream) {
		// 当前连接的user,即视频的发送者
		// final User user = VideoUtils.getCurrentUser(userManager);
		final String userName = VideoUtils.getCurrentUserName();
		/*
		 * logger.info("--streamBroadcastStart--------video---------->" +
		 * "视频广播开始: name{},Scope{},publishedName{}", new Object[] {
		 * stream.getName(), stream.getScope().getName(),
		 * stream.getPublishedName() });
		 */
		VideoUtils.doWithScopeConnections(stream.getScope(),
				new IConnectionCallback() {
					// 回调方法
					@Override
					public void doWithConnection(IConnection conn) {
						// 得到新连接的用户,即视频的接收者
						String clientUser = VideoUtils.getUserIdByClient(conn
								.getClient());

						/*
						 * logger.info("----------video---------->" +
						 * "视频发送者{},接收者{}", user.getName(), client .getName());
						 */
						// 向其他人(需要排除自己)发送接收视频的提示,在系统指定位置的播放器中播放视频
						if (StringUtils.isNotBlank(clientUser)
								&& !StringUtils.equals(clientUser,
										userName.toString())) {
							final Integer currentIndex = Integer
									.valueOf(Red5
											.getConnectionLocal()
											.getClient()
											.getAttribute(
													VideoConstants.STREAM_CLIENT_ATTR_INDEX)
											.toString());
							logger.info("%%%%%%%%%%%%%%%%%%%%%%------------------>"
									+ currentIndex);
							VideoUtils
									.call(conn,
											VideoConstants.CLIENT_METHOD_ON_STREAM_RECEIVED,
											new Object[] {
													stream.getPublishedName(),
													userName, currentIndex },
											null);
						}
						// 将视频广播的publishedName存入相应的IClient
						conn.getClient().setAttribute(
								VideoConstants.STREAM_CLIENT_ATTR_KEY,
								stream.getPublishedName());
					}

				});
	}

	public void streamBroadcastClose(final IBroadcastStream stream,
			VideoApplicationContext ctx) {
		final String userName = VideoUtils.getCurrentUserName();
		/*
		 * logger.info("--streamBroadcastClose--------video---------->" +
		 * "视频广播结束 name {},Scope {},publishedName{}", new Object[] {
		 * stream.getName(), stream.getScope().getName(),
		 * stream.getPublishedName() });
		 */
		// 删除当前scope中的接收视频的客户保存在IClient中的publishedName
		Set<IClient> clients = stream.getScope().getClients();
		for (IClient client : clients) {
			Object obj = client
					.getAttribute(VideoConstants.STREAM_CLIENT_ATTR_KEY);
			if (stream.getPublishedName().equals(obj)) {
				/*
				 * logger.info("----------video---------->" +
				 * "remove stream published name.{}", stream
				 * .getPublishedName());
				 */
				client.removeAttribute(VideoConstants.STREAM_CLIENT_ATTR_KEY);
				break;
			}
		}
		// 停止客户端播放
		VideoUtils.doWithScopeConnections(stream.getScope(),
				new IConnectionCallback() {

					@Override
					public void doWithConnection(IConnection conn) {
						String clientUser = VideoUtils.getUserIdByClient(conn
								.getClient());

						/*
						 * logger.info("----------video---------->" +
						 * "视频关闭:视频发送者{},接收者{}", user.getLoginId(), clientUser);
						 */

						// 向其他人发送停止接收视频的提示
						if (StringUtils.isNotBlank(clientUser)
								&& !StringUtils.equals(clientUser,
										userName.toString())) {
							final Integer currentIndex = Integer
									.valueOf(Red5
											.getConnectionLocal()
											.getClient()
											.getAttribute(
													VideoConstants.STREAM_CLIENT_ATTR_INDEX)
											.toString());
							/* logger.info("视频index{}", currentIndex); */
							VideoUtils
									.call(conn,
											VideoConstants.CLIENT_METHOD_ON_SUBSCRIBE_OVER,
											new Object[] { userName,
													currentIndex }, null);
						}
					}

				});
	}

}
