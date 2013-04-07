package com.systop.video.action;

import org.apache.commons.lang.xwork.StringUtils;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;


import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.video.VideoApplicationContext;
import com.systop.video.VideoConstants;
import com.systop.video.util.IConnectionCallback;
import com.systop.video.util.VideoUtils;
@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoMovieAction {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoMovieAction.class);
	@Autowired
	private UserManager userManager;

	/**
	 * 在主席的操作下，选中某一已经上传的视频文件，进行"电影公映"
	 */
	public void movieBroadcastStart(final String fileName,
			final String fileOwnnerId, VideoApplicationContext ctx) {
		if (StringUtils.isBlank(fileName) || StringUtils.isBlank(fileOwnnerId)) {
			return;
		}
		final User user = VideoUtils.getCurrentUser(userManager);
		logger.debug("用户{}正在播放视频文件{}", user.getLoginId(), fileName);
		IScope scope = ctx.getAppScope().getScope(user.getId().toString());// appScope.getScope(user.getId().toString());
		if (scope == null) {
			scope = Red5.getConnectionLocal().getScope();
		}
		// 向同一會議中的所有用戶發送播放視頻指令
		VideoUtils.doWithScopeConnections(scope, new IConnectionCallback() {
			@Override
			public void doWithConnection(IConnection conn) {
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				VideoUtils.call(conn,
						VideoConstants.CLIENT_METHOD_ON_MOVIE_BROADCAST_START,
						new Object[] { fileName, fileOwnnerId }, null);
			}
		});

	}

	/**
	 * 在主席的操作下，"电影公映"结束,离开
	 */
	public void movieBroadcastClose(String fileName, VideoApplicationContext ctx) {
		// 向同一會議中的所有用戶發送停止播放視頻指令
		VideoUtils.doWithScopeConnections(ctx.getAppScope(),
				new IConnectionCallback() {
					@Override
					public void doWithConnection(IConnection conn) {

						VideoUtils
								.call(
										conn,
										VideoConstants.CLIENT_METHOD_ON_MOVIE_BROADCAST_CLOSE,
										new Object[] {}, null);
					}
				});
	}
}
