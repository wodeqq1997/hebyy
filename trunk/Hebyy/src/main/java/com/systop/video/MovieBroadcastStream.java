package com.systop.video;

import java.io.IOException;
import java.util.Collection;

import org.red5.server.api.IScope;
import org.red5.server.api.stream.IBroadcastStream;
import org.red5.server.api.stream.IStreamCodecInfo;
import org.red5.server.api.stream.IStreamListener;
import org.red5.server.api.stream.ResourceExistException;
import org.red5.server.api.stream.ResourceNotFoundException;
import org.red5.server.messaging.IProvider;

public class MovieBroadcastStream implements IBroadcastStream{

	@Override
	public void addStreamListener(IStreamListener arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public IProvider getProvider() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getPublishedName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getSaveFilename() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<IStreamListener> getStreamListeners() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void removeStreamListener(IStreamListener arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveAs(String arg0, boolean arg1) throws IOException,
			ResourceNotFoundException, ResourceExistException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setPublishedName(String arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void close() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public IStreamCodecInfo getCodecInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public IScope getScope() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void start() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void stop() {
		// TODO Auto-generated method stub
		
	}

}
