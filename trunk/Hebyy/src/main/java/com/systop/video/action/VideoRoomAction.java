package com.systop.video.action;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.template.Template;
import com.systop.common.modules.template.TemplateContext;
import com.systop.common.modules.template.TemplateRender;
import com.systop.video.VideoApplicationContext;
import com.systop.video.VideoConstants;
import com.systop.video.room.model.Room;
import com.systop.video.room.service.RoomManager;
import com.systop.video.service.VideoRoomManager;
import com.systop.video.util.IConnectionCallback;
import com.systop.video.util.VideoUtils;

@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoRoomAction {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoRoomAction.class);
	@Autowired
	private RoomManager roomManager;
	@Autowired
	private TemplateRender templateRender;
	@Autowired
	private VideoRoomManager videoRoomManager;

	/**
	 * 会议主人强制关闭会议
	 * 
	 * @param roomName
	 * @param userId
	 */
	public void closeRoom(String roomName, VideoApplicationContext ctx) {
		roomManager.closeRoom(roomName);
		// 如果在Scope树中有该会议(因为数据库中的rooms和Scope有时候是不同步的),则通知会议中的各个客户端,会议关闭
		if (ctx.getAppScope().hasChildScope(roomName)) {
			IScope scope = ctx.getAppScope().getScope(roomName);
			VideoUtils.doWithScopeConnections(scope, new IConnectionCallback() {

				@Override
				public void doWithConnection(IConnection conn) {

					VideoUtils.call(conn,
							VideoConstants.CLIENT_METHOD_ON_CLOSE_ROOM,
							new Object[] {}, null);
				}
			});
		}
		// 通知应用中的所有客户端,房间的状态改变
		VideoUtils.doWithScopeConnections(ctx.getAppScope(),
				new IConnectionCallback() {
					@Override
					public void doWithConnection(IConnection conn) {
						VideoUtils.call(conn,
								VideoConstants.CLIENT_METHOD_ON_ROOM_CHANGE,
								new Object[] {}, null);
					}
				});

	}

	/**
	 * 客户端调用,创建房间<br>
	 * 由于早就建立了连接,在用户点击"新建房间"按钮时创建房间,所以<br>
	 * 只能是通过调用的方式来进行房间的创建.
	 * 
	 * @return
	 */
	public void createRoom(final String userId, final String roomName,
			final String members, final String roomRemark,
			VideoApplicationContext ctx) {

		// final User user = VideoUtils.getCurrentUser(userManager);
		final String userName = VideoUtils.getCurrentUserName();
		//User user = userManager.get(Integer.valueOf(userId));
		/* logger.info("user{}创建名称为{}的房间", user.getName(), roomName); */

		roomManager.saveRoom(roomName, userName, members, roomRemark);
		callClientRoomChange(ctx);
		// 调用刷新房间列表方法--是否可行?????tmd好像不行啊!!!!
		// refreshRooms();
		/*
		 * //得到当前连接 IConnection conn = Red5.getConnectionLocal(); //调用客户端函数,重新刷新
		 * VideoUtils.call(conn, VideoConstants.CLIENT_METHOD_NOT_LOGIN, null,
		 * this);
		 */
	}

	/**
	 * 客户端调用方法,房间主人强制删除一个房间(所有房客被踢出).
	 * 
	 * @param roomName
	 */
	public void removeRoom(final String roomName, final String userId,
			VideoApplicationContext ctx) {
		/* logger.info("------------------------------->" + roomName); */
		Assert.notNull(roomName);
		Assert.notNull(userId);
		final Room room = roomManager.getByName(roomName);
		// final User user = VideoUtils.getCurrentUser(userManager);
		/* final User user = userManager.get(Integer.valueOf(userId)); */
		if (room != null) {
			/* logger.info("user{}删除名称为{}的房间", user.getName(), room.getName()); */
			roomManager.remove(room);
		}
		IScope scope = ctx.getAppScope().getScope(roomName);
		// room和IScope有时候不同步,程序退出等情况
		if (scope != null) {
			videoRoomManager.roomStop(scope);
			// 从Scope树中删除指定的房间
			ctx.getAppScope().removeChildScope(scope);
		}
		VideoUtils.doWithScopeConnections(ctx.getAppScope(),
				new IConnectionCallback() {
					@Override
					public void doWithConnection(IConnection conn) {
						VideoUtils.call(conn,
								VideoConstants.CLIENT_METHOD_ON_ROOM_CHANGE,
								new Object[] {}, null);
					}
				});
	}

	/**
	 * 根据用户选择的房间得到房间详细信息
	 * 
	 * @param roomName 房间名称
	 * @return 保存房间信息的xml文本
	 */
	public String getRoomInfoByName(final String roomName,
			VideoApplicationContext ctx) {
		Assert.notNull(roomName);
		/* logger.info(roomName); */
		final Room room = roomManager.getByName(roomName);

		if (room != null) {
			String members = room.getMembers();

			List<String> memberList = new ArrayList<String>();
			/*
			 * String masterHql =
			 * "select u from User u left join fetch u.dept where u.id = ? ";
			 * User master = (User) roomManager.getDao().query(masterHql,
			 * Integer.valueOf(room.getMaster())).get(0);
			 */
			 User master = roomManager.getDao().get(User.class,
			 Integer.valueOf(Integer.valueOf(room.getMaster())));
			 memberList.add(master.getName());
			if (StringUtils.isNotBlank(members)) {
				String[] membersId = members.split(VideoConstants.SPLITER);
				if (membersId.length > 0) {
					for (String memberId : membersId) {
						if (StringUtils.isBlank(memberId)) {
							continue;
						}
		
						memberList.add(memberId);
					}
				}
			}
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("room", room);
			parameters.put("members", memberList);

			Template template = new Template("roomInfoXml");
			TemplateContext templateContext = new TemplateContext();
			templateContext.setTemplate(template);
			templateContext.addParameters(parameters);
			StringWriter writer = new StringWriter();
			templateContext.setWriter(writer);
			try {
				templateRender.renderTemplate(templateContext);
			} catch (Exception e) {
				logger.error("An error has occurs. {}", e.getMessage());
				e.printStackTrace();
			}
			/*
			 * logger.info("返回XML数据供客户端刷新房间信息及成员列表");
			 * logger.info(writer.toString());
			 */

			return writer.toString();

		} else {
			return "";
		}
	}

	/**
	 * 得到房间列表,根据当前用户所在区县,列出特定区县下的会议(房间) 1.如果当前用户为区县级用户,即其所在部门为区县
	 * (所在部门为county,user.getDept eq getCountyByUser(user)), 则列出其区县会议和上一级区县的会议
	 * 2.如果当前用户不为区县级用户(某职能部门), (所在部门不为county,user.getDept ne
	 * getCountyByUser(user)) 则只列出其所在区县的会议
	 * 
	 * @return
	 */
	public String refreshRooms(String userId, VideoApplicationContext ctx) {
		List<Room> rooms = roomManager.listRooms(userId);

		/* logger.info("总共{}个房间", rooms.size()); */
		// 用模板生成xml
		Template template = new Template("roomListXml");
		TemplateContext templateCtx = new TemplateContext();
		templateCtx.setTemplate(template);
		templateCtx.addParameter("rooms", rooms);
		StringWriter writer = new StringWriter();
		templateCtx.setWriter(writer);
		try {
			templateRender.renderTemplate(templateCtx);
		} catch (Exception e) {
			logger.error("An error has occurs. {}", e.getMessage());
			e.printStackTrace();
		}
		// logger.info("返回XML数据供客户端刷新房间列表"); logger.info(writer.toString());

		return writer.toString();
	}

	/**
	 * 切换会议房间的状态
	 * 
	 * @param roomName
	 */
	public void switchRoomStatus(String roomName, VideoApplicationContext ctx) {
		roomManager.switchRoomStatus(roomName);

		callClientRoomChange(ctx);
	}

	/**
	 * 检查同名房间是否存在
	 * 
	 * @param roomName
	 * @return
	 */
	public String checkSameNameRoom(final String roomName,
			VideoApplicationContext ctx) {
		Assert.notNull(roomName);
		Room room = roomManager.getByName(roomName);
		if (room != null) {
			return "TRUE";
		} else {
			return "FALSE";
		}
	}
	/**
	 * 检查用户要登录的会议中是否已经有了同名用户
	 * @param userName
	 * @param roomName
	 * @param ctx
	 * @return
	 */
	public String checkSameNameUser(final String userName,final String roomName,VideoApplicationContext ctx){
		Assert.notNull(userName);
		if(roomManager.checkSameNameUser(userName, roomName)){
			return "TRUE";
		} else {
			return "FALSE";
		}
	}
	/**
	 * 检测用户名密码登录会议
	 * @return
	 */
	public String loginRoom(final String password,final String roomName,VideoApplicationContext ctx){
		if(roomManager.loginRoom(password, roomName)){
			return "TRUE";
		} else {
			return "FALSE";
		}
	}
	private void callClientRoomChange(VideoApplicationContext ctx){
		VideoUtils.doWithScopeConnections(ctx.getAppScope(),
				new IConnectionCallback() {
					@Override
					public void doWithConnection(IConnection conn) {
						VideoUtils.call(conn,
								VideoConstants.CLIENT_METHOD_ON_ROOM_CHANGE,
								new Object[] {}, null);
					}
				});
	}
}
