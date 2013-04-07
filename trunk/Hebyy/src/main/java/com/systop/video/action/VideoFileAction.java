package com.systop.video.action;

import java.io.StringWriter;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.common.modules.template.Template;
import com.systop.common.modules.template.TemplateContext;
import com.systop.common.modules.template.TemplateRender;
import com.systop.common.modules.upload.UploadHandler;
import com.systop.video.model.SharedFile;
import com.systop.video.VideoApplicationContext;
import com.systop.video.upload.service.SharedFileManager;
import com.systop.video.util.VideoUtils;

@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
public class VideoFileAction {
	protected static final Logger logger = LoggerFactory
			.getLogger(VideoFileAction.class);

	@Autowired
	private UserManager userManager;
	@Autowired
	private TemplateRender templateRender;
	@Autowired
	private SharedFileManager sharedFileManager;
	@Autowired
	private UploadHandler uploadHandler;

	/**
	 * 得到文件列表
	 * 
	 * @return
	 */
	public String refreshFileList(VideoApplicationContext ctx) {
		User user = VideoUtils.getCurrentUser(userManager);
		List<SharedFile> sharedFiles = sharedFileManager.getByUserId(user
				.getId());
		logger.debug("{}户的文件,共{}个", user.getId(), sharedFiles.size());
		Template template = new Template("fileListXml");
		TemplateContext templateCtx = new TemplateContext();
		templateCtx.setTemplate(template);
		templateCtx.addParameter("files", sharedFiles);
		StringWriter writer = new StringWriter();
		templateCtx.setWriter(writer);
		try {
			templateRender.renderTemplate(templateCtx);
		} catch (Exception ex) {
			logger.error("An error has occurs. {}", ex.getMessage());
			ex.printStackTrace();
			return "";
		}
		logger.debug("返回XML数据供客户端刷新列表");
		return writer.toString();
	}

	/**
	 * 删除已上传文件
	 * 
	 * @param fileName
	 * @return
	 */
	public String removeFile(String fileName, VideoApplicationContext ctx) {
		if (StringUtils.isBlank(fileName)) {
			return "";
		}
		User user = VideoUtils.getCurrentUser(userManager);
		if (user != null && user.getId() != null) {
			SharedFile sharedFile = sharedFileManager.getByCnName(fileName,
					user.getId());
			if (sharedFile == null) {
				logger.warn("要删除的文件<<{}>>未找到", fileName);
			}
			uploadHandler.remove(sharedFile.getEnName(), user.getId());
			sharedFileManager.remove(sharedFile);
			return refreshFileList(ctx);
		}
		return "";
	}

}
