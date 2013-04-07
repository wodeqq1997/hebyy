package com.systop.video.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.systop.video.VideoApplicationContext;
import com.systop.video.VideoConstants;
import com.systop.video.room.service.RoomManager;
import com.systop.video.util.IConnectionCallback;
import com.systop.video.util.VideoUtils;
@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoMessageAction {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoMessageAction.class);
	//@Autowired
	//private UserManager userManager;
	@Autowired
	private RoomManager roomManager;

	/**
	 * 
	 * 客户端发送文字信息方法 客户端调用方法,<br>
	 * <code>onSendMsg</code><br>
	 * 方法,把信息广播给同一房间所有用户<br>
	 * 
	 * @param msg 文字信息
	 */
	public void onSendMsg(final String msg,VideoApplicationContext ctx) {
		// 得到当前用户(聊天信息发送者)
		//final User user = VideoUtils.getCurrentUser(userManager);
		final String userName = VideoUtils.getCurrentUserName();
		/* logger.info("&&&&&&&&&&&&&&&&&&&" + user.getName()); */
		// 得到当前用户所在房间
		IScope scope = Red5.getConnectionLocal().getScope();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy年MM月dd日 hh:mm:ss");
		StringBuffer buf = new StringBuffer("[").append(userName).append(
				"]").append(sf.format(new Date())).append("<br>");
		buf.append(msg);
		buf.delete(buf.indexOf("SIZE"), buf.indexOf("SIZE") + 9);
		final String fullMsg = buf.toString();
		// fullMsg.replace("SIZE=\'10\'", " ");
		logger.info(fullMsg);

		VideoUtils.doWithScopeConnections(scope, new IConnectionCallback() {
			@Override
			public void doWithConnection(IConnection conn) {
				VideoUtils.call(conn, VideoConstants.CLIENT_METHOD_RECEIVE_MSG,
						new Object[] { fullMsg, userName }, null);
			}
		});

		roomManager.saveMeetingRecord(scope.getName(), fullMsg);
	}
}
