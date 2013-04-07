package com.systop.video.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.xwork.StringUtils;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
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
import com.systop.video.room.model.Room;
import com.systop.video.room.service.RoomManager;
import com.systop.video.util.IConnectionCallback;
import com.systop.video.util.VideoUtils;

/**
 * 完成和业务(数据访问)相关
 * 
 * @author DELPHI
 * 
 */
@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoRoomManager {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoRoomManager.class);
	@Autowired
	private RoomManager roomManager;
	@Autowired
	private UserManager userManager;

	/**
	 * 实现和业务相关的房间连接方法 将用户id和Client对象进行关联
	 * 
	 * @param conn
	 * @param params
	 * @param ctx
	 */
	@SuppressWarnings("rawtypes")
	public void roomConnect(IConnection conn, Object[] params,
			VideoApplicationContext ctx) {
		String userId = null;
		if (params != null && params.length > 0 && params[0] != null) {
			if (params[0] instanceof String) {
				userId = params[0].toString();
			} else if (params[0] instanceof ArrayList) {
				List paramList = (List) params[0];
				userId = paramList.get(0).toString();
				String roomName = paramList.get(1).toString();// 房间名称
				String roomRemark = paramList.get(2).toString();// 房间备注
				String members = paramList.get(3).toString();// 成员id

				// String actionType = paramList.get(4).toString();//
				// 操作类型(新建/修改)

				//User user = userManager.get(Integer.valueOf(userId));

				roomManager.saveRoom(roomName, userId, members, roomRemark);

				VideoUtils.doWithScopeConnections(ctx.getAppScope(),
						new IConnectionCallback() {
							@Override
							public void doWithConnection(IConnection conn) {
								VideoUtils
										.call(
												conn,
												VideoConstants.CLIENT_METHOD_ON_ROOM_CHANGE,
												new Object[] {}, null);
							}
						});

			}
		}

	}

	/**
	 * 加入房间业务方法
	 * 
	 * @param client
	 * @param room
	 * @param ctx
	 * @return
	 */
	public boolean roomJoin(IClient client, final IScope room,
			VideoApplicationContext ctx) {
		// 检查房间人数是否超限
		Room r = roomManager.getByName(room.getName());
		if (r != null && r.getMembersCount() >= VideoConstants.MAX_ROOM_MEMBERS) {
			// 显示房间已经满了
			VideoUtils.doWithClientConnections(client,
					new IConnectionCallback() {

						@Override
						public void doWithConnection(IConnection conn) {
							VideoUtils
									.call(
											conn,
											VideoConstants.CLIENT_METHOD_ON_ROOM_IS_FULL,
											new Object[] { room.getName() },
											null);
						}
					});
			return true;
		}

		final String userId = VideoUtils.getUserIdByClient(client);
		//final User user = userManager.get(Integer.valueOf(id));
		final Integer minIndex = VideoUtils.getMinIndex(room);
		/**
		 * 如果room为null或者room名称为null,则仅仅是作为连接,不作room的任何操作 如果room不为null(有意义的值)
		 * 如果房间确实存着,则加入房间 如果房间不存着,则创建房间
		 */
		Room rom = null;
		// 如果room为null或者房间名称为null,则无理取闹(null)--登录大厅...,不予理睬
		if (room == null || "null".equals(room.getName())) {
			/* logger.info("用户{}登录大厅!!!", user.getName()); */
			return true;
		} else {// 如果room不为null并且房间名称为有意义的值(加入/或者创建)
			// 更新room成员,修改成员的在线状态
			// 如果是修改房间

			rom = roomManager.join(room.getName(), userId);
			if (client.getAttribute(VideoConstants.STREAM_CLIENT_ATTR_INDEX) == null) {
				// 将当前加入房间的客户的视频index设置为所在房间最小空闲index
				client.setAttribute(VideoConstants.STREAM_CLIENT_ATTR_INDEX,
						minIndex);
			}

			/*
			 * logger.info("-------->用户{}进入房间,获得视频索引{}", user.getName(),
			 * minIndex);
			 */
		}
		final String roomName = rom.getName();
		final User master = userManager.get(Integer.valueOf(rom.getMaster()));
		// 通知所有同房间成员,新用户加入
		VideoUtils.doWithScopeConnections(room, new IConnectionCallback() {
			@Override
			public void doWithConnection(IConnection conn) {
				VideoUtils.call(conn,
						VideoConstants.CLIENT_METHOD_ON_ROOM_JOIN,
						new Object[] { userId, roomName }, null);
			}
		});
		// 显示连接及房间信息
		VideoUtils.doWithClientConnections(client, new IConnectionCallback() {

			@Override
			public void doWithConnection(IConnection conn) {
				VideoUtils.call(conn,
						VideoConstants.CLIENT_METHOD_SHOW_CONN_STATUS,
						new Object[] { roomName, master.getName(),
						userId, minIndex }, null);
			}
		});

		VideoUtils.doWithClientConnections(client, new IConnectionCallback() {

			@Override
			public void doWithConnection(IConnection conn) {
				VideoUtils.call(conn,
						VideoConstants.CLIENT_METHOD_ON_ROOM_JOIN,
						new Object[] { userId, roomName }, null);

				// ------------------------------------------------------------------------------------------------------

				// 如果当前房间有视频广播,则邀请新来的用户加入
				Set<IClient> clients = room.getClients();
				for (IClient client : clients) {
					String publishedName = (String) client
							.getAttribute(VideoConstants.STREAM_CLIENT_ATTR_KEY);
					
					String userName = VideoUtils.getUserIdByClient(client);
					Integer currentIndex = (Integer) client
							.getAttribute(VideoConstants.STREAM_CLIENT_ATTR_INDEX);
					/* logger.info("%%%%%%%%%%%%%%%%%%%%%%" + currentIndex); */
					if (StringUtils.isNotBlank(publishedName)) {
						/*
						 * logger.info("----------video---------->" +
						 * "恢复视频通话{}", publishedName);
						 */
						/*
						 * logger.info("----->房间成员{}视频index:{}", user.getName(),
						 * currentIndex);
						 */
						VideoUtils
								.call(
										conn,
										VideoConstants.CLIENT_METHOD_ON_SUBSCRIBE_RESUME,
										new Object[] { publishedName,
												userName, currentIndex },
										null);
					}
				}
			}

		});

		return true;
	}

	/**
	 * 用户离开房间
	 */
	public void roomLeave(IClient client, final IScope room,
			VideoApplicationContext ctx) {
		final String userId = VideoUtils.getUserIdByClient(client);
		
		// 更新room成员,同时更新房间人员人数
		roomManager.leave(room.getName(), userId);

		logger.info("用户{}离开房间,并且归还了房间{}", userId, room.getName());
		final Integer currentIndex = Integer.valueOf(client.getAttribute(
				VideoConstants.STREAM_CLIENT_ATTR_INDEX).toString());
		VideoUtils.doWithScopeConnections(room, new IConnectionCallback() {

			@Override
			public void doWithConnection(IConnection conn) {

				VideoUtils.call(conn,
						VideoConstants.CLIENT_METHOD_ON_ROOM_LEAVE,
						new Object[] { userId,
								roomManager.isMaster(room.getName(), userId),
								currentIndex }, null);
			}
		});
		/*
		 * logger.info("--roomLeave--------video---------->" + "用户{}离开了房间{}",
		 * user .getName(), room.getName());
		 */
	}

	/**
	 * Handler method. Called when room scope is stopped. 停止一个房间.
	 * 
	 */
	public void roomStop(IScope room) {
		if (roomManager.getDao().exists(room, "name")) {
			roomManager.closeRoom(room.getName());
		}
	}

}
