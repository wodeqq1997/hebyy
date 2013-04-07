package com.systop.video.psc;

import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;

public class BasePendingServiceCallback implements IPendingServiceCallback {

	/**
	 * IPendingServiceCallback接口所要求实现的方法<br>
	 * Callback that will be executed when the result of a pending service call
	 * has been received.
	 */
	@Override
	public void resultReceived(IPendingServiceCall iPendingServiceCall) {
	}

}
