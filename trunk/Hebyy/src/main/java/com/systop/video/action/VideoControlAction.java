package com.systop.video.action;

import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.systop.video.VideoApplicationContext;
import com.systop.video.VideoConstants;
import com.systop.video.util.IConnectionCallback;
import com.systop.video.util.VideoUtils;
@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoControlAction {
	/**
	 * 客户端调用方法,房主切换指定用户的麦克风
	 * 
	 * @param index
	 * @param gain
	 */
	public void switchSound(int index, int gain,VideoApplicationContext ctx) {
		final Integer currentIndex = index;
		final Integer currentGain = gain;
		// 得到当前用户(聊天信息发送者)
		// final User user = VideoUtils.getCurrentUser(userManager);
		/* logger.info("&&&&&&&&&&&&&&&&&&&" + user.getName()); */
		// 得到当前用户所在房间
		IScope scope = Red5.getConnectionLocal().getScope();
		VideoUtils.doWithScopeConnections(scope, new IConnectionCallback() {
			@Override
			public void doWithConnection(IConnection conn) {
				IClient client = conn.getClient();
				if (client
						.getAttribute(VideoConstants.STREAM_CLIENT_ATTR_INDEX)
						.toString().equals(currentIndex.toString())) {
					/*
					 * final Integer currentIndex = Integer.valueOf(Red5
					 * .getConnectionLocal().getClient().getAttribute(
					 * VideoConstants.STREAM_CLIENT_ATTR_INDEX) .toString());
					 */
					/*
					 * logger.info("%%%%%%%%%%%%%%%%%%%%%%------------------>" +
					 * currentIndex);
					 */
					/*
					 * logger.info("设定成员{}麦克风音量为{}", VideoUtils
					 * .getUserIdByClient(client), currentGain);
					 */
					VideoUtils.call(conn, VideoConstants.SWITCH_CLIENT_MIC,
							new Object[] { currentGain }, null);
				}
			}
		});
	}
}
