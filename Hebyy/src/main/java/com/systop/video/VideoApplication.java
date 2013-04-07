package com.systop.video;

//import java.io.IOException;
//import java.util.Calendar;

import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.stream.IBroadcastStream;
//import org.red5.server.api.stream.ResourceExistException;
//import org.red5.server.api.stream.ResourceNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.util.Assert;

//import com.systop.common.modules.security.user.model.User;
//import com.systop.common.modules.security.user.service.UserManager;
//import com.systop.core.Constants;
import com.systop.core.util.ReflectUtil;
import com.systop.video.service.VideoAppconnectManager;
import com.systop.video.service.VideoRoomManager;
import com.systop.video.service.VideoStreamManager;
//import com.systop.video.util.VideoUtils;

/**
 * 视频服务的核心类，按照Red5规范进行配置，完成所有Red5控制层面的功能
 * 
 * @author
 */

public class VideoApplication extends MultiThreadedApplicationAdapter implements
		IPendingServiceCallback {
	/**
	 * Red5的顶级Scope,用于遍历Red5的Scope树
	 */
	// private IScope appScope;
	/** Spring的ApplicationContext，用于查找得到bean */
	@Autowired
	private ApplicationContext context;
	/** 本Video应用中用于封装Red5作用域,以传递给service层的context */
	private static VideoApplicationContext ctx = new VideoApplicationContext();
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoApplication.class);
	//@Autowired
	//private UserManager userManager;

	@Autowired
	private VideoRoomManager videoRoomManager;
	@Autowired
	private VideoStreamManager videoStreamManager;
	@Autowired
	private VideoAppconnectManager videoAppconnectManager;

	/**
	 * 应用启动<br>
	 * appStart方法在Red5应用启动启动时会被调用一次<br>
	 * 可以通过在自己的类中覆盖这个方法来完成自己想添加的功能.
	 */
	@Override
	public boolean appStart(IScope app) {
		logger.info("--appStart--------video---------->"
				+ "Red5视频服务启动...SCOPE:{}", app.getClass());
		ctx.setAppScope(app);
		// 初始化所有用户的videoOnline属性为"不在线"
		//userManager.initUserVideoOnline();
		return true;
	}

	/**
	 * 应用连接
	 */
	@Override
	public boolean appConnect(IConnection conn, Object[] params) {
		if (!videoAppconnectManager.appConnect(conn, params)) {
			return false;
		}
		return super.appConnect(conn, params);
	}

	/**
	 * 断开视频连接
	 */
	@Override
	public void appDisconnect(IConnection conn) {
		//final User user = VideoUtils.getCurrentUser(userManager);
		//userManager.setVideoOnline(userManager.get(user.getId()), Constants.NO);
		super.appDisconnect(conn);
	}

	/**
	 * 加入应用
	 */
	@Override
	public boolean appJoin(IClient client, IScope app) {
		return super.appJoin(client, app);
	}

	/**
	 * 离开应用
	 */
	@Override
	public void appLeave(IClient client, IScope app) {
		super.appLeave(client, app);
	}

	/**
	 * 应用停止
	 */
	@Override
	public void appStop(IScope app) {
		logger.info("--appStop--------video---------->" + "appStop");
		super.appStop(app);
	}

	/**
	 * 连接房间<br>
	 */
	@Override
	public boolean roomConnect(IConnection conn, Object[] params) {
		videoRoomManager.roomConnect(conn, params, ctx);

		return super.roomConnect(conn, params);
	}

	/**
	 * 进入房间,调用客户端方法提示欢迎信息
	 */
	@Override
	public boolean roomJoin(IClient client, final IScope room) {
		ctx.setClient(client);
		if (!super.roomJoin(client, room)) {
			return false;
		}
		return videoRoomManager.roomJoin(client, room, ctx);
	}

	/**
	 * 当客户端和房间失去连接时被调用
	 * 
	 * @param conn
	 */
	@Override
	public void roomDisconnect(IConnection conn) {
		logger.info("--roomDisconnect--------video---------->"
				+ "room Disconnect");
		super.roomDisconnect(conn);
	}

	/**
	 * 用户离开房间
	 */
	@Override
	public void roomLeave(IClient client, final IScope room) {
		super.roomLeave(client, room);
		ctx.setClient(client);
		videoRoomManager.roomLeave(client, room, ctx);
	}

	/**
	 * Handler method. Called when room scope is stopped. 停止一个房间.
	 * 
	 */
	@Override
	public void roomStop(IScope room) {
		room.removeAttributes();
		videoRoomManager.roomStop(room);
		super.roomStop(room);
	}

	/**
	 * 视频广播.
	 */
	@Override
	public void streamBroadcastStart(final IBroadcastStream stream) {
		super.streamBroadcastStart(stream);
		videoStreamManager.streamBroadcastStart(stream);
	}

	/**
	 * 关闭视频广播，通知其他客户端
	 */
	@Override
	public void streamBroadcastClose(final IBroadcastStream stream) {
		super.streamBroadcastClose(stream);
		videoStreamManager.streamBroadcastClose(stream, ctx);
	}

	/**
	 * 视频录制
	 */
	@Override
	public void streamRecordStart(IBroadcastStream stream) {
		//StringBuffer buf = new StringBuffer();
		/* logger.info("视频录制开始"); */
		//User user = VideoUtils.getCurrentUser(userManager);
		/*if (user != null) {
			Calendar c = Calendar.getInstance();
			buf.append(stream.getSaveFilename()).append("_").append(
					c.get(Calendar.YEAR)).append(c.get(Calendar.MONTH)).append(
					c.get(Calendar.DATE)).append(c.get(Calendar.HOUR)).append(
					c.get(Calendar.MINUTE)).append(c.get(Calendar.SECOND));
			try {
				stream.saveAs(buf.toString(), false);
			} catch (IOException e) {
				logger.warn("视频录制IO异常,{}", e.getMessage());
				e.printStackTrace();
			} catch (ResourceNotFoundException e) {
				logger.warn("视频录制，资源未找到。{}", e.getMessage());
				e.printStackTrace();
			} catch (ResourceExistException e) {
				logger.warn("视频录制，资源已经存在{}。", e.getMessage());
				e.printStackTrace();
			}
		}*/
	}

	/**
	 * 用于被客户端调用的方法
	 * 
	 * @param beanId 要访问的Bean的Id
	 * @param methodName 要调用的方法名
	 * @param args 传递的参数数组
	 * @return 返回的結果
	 */
	public Object action(String[] args) {

		Assert.notEmpty(args);
		String beanId = args[0];
		String methodName = args[1];
		Object[] invokeArgs = new Object[args.length - 1];
		System.arraycopy(args, 2, invokeArgs, 0, args.length - 2);
		invokeArgs[invokeArgs.length - 1] = ctx;
		/**
		 * <pre>
		 * 根据客户端传递的beanId从Spring容器中得到相应的Bean实例 
		 * 并根据客户端传递的方法名和参数，使用反射进行调用
		 * </pre>
		 */
		return (Object) ReflectUtil.invoke(context.getBean(beanId), methodName,
				invokeArgs);
	}

	@Override
	public void resultReceived(IPendingServiceCall arg0) {

	}
}
