package com.systop.video.callback;

import org.red5.server.api.IConnection;

import com.systop.video.VideoConstants;
import com.systop.video.util.IConnectionCallback;
import com.systop.video.util.VideoUtils;

public class SwitchRoomStatusCallback implements IConnectionCallback {

	@Override
	public void doWithConnection(IConnection conn) {
		VideoUtils.call(conn,
				VideoConstants.CLIENT_METHOD_ON_ROOM_CHANGE,
				new Object[] {}, null);
	}

}
