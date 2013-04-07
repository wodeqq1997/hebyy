package com.systop.video.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoUserManager {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoUserManager.class);

}
