package com.systop.video;

import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

/**
 * 用于包装应用中scope,conn,stream实例
 * 
 * @author DELPHI
 * 
 */
public final class VideoApplicationContext {
	private IScope appScope;

	private IConnection conn;

	private IClient client;

	public IScope getAppScope() {
		return appScope;
	}

	public void setAppScope(IScope appScope) {
		this.appScope = appScope;
	}

	public IConnection getConn() {
		return conn;
	}

	public void setConn(IConnection conn) {
		this.conn = conn;
	}

	public IClient getClient() {
		return client;
	}

	public void setClient(IClient client) {
		this.client = client;
	}

}
