package com.systop.video;

import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.red5.server.api.IScope;
import org.red5.server.api.stream.IStreamFilenameGenerator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.common.modules.upload.DefaultUploadHandler;
import com.systop.core.util.DateUtil;

/**
 * @author catstiger@gmail.com
 * 
 */
@Component("streamFilenameGenerator")
public class StreamFilenameGenerator implements IStreamFilenameGenerator {
	private static Logger logger = LoggerFactory
			.getLogger(StreamFilenameGenerator.class);
	public static final String FLV_NAME_SUFFIX = "_video";
	@Autowired
	private UserManager userManager;

	/**
	 * 将视频文件保存到以该用户的ID命名的目录下的flv目录下。
	 * 
	 * @see IStreamFilenameGenerator#generateFilename(IScope, String, String,
	 *      IStreamFilenameGenerator.GenerationType)
	 */
	@Override
	public String generateFilename(IScope scope, String name, String extension,
			GenerationType type) {

		String rootPath = DefaultUploadHandler.getRootPath();

		if (name != null && name.indexOf(File.separator) >= 0) {
			name = name.substring(name.lastIndexOf(File.separator));
			if (name.startsWith(File.separator)) {
				name = name.substring(1);
			}
		}
		logger.debug(name);
		StringBuffer filename = new StringBuffer(rootPath).append(
				scope.getName()).append(File.separator).append("flv").append(
				File.separator).append(name);

		if (extension != null && name.indexOf(extension) < 0) {
			filename.append(extension);
		}
		logger.info("视频文件{}", filename);
		return filename.toString();
	}

	/**
	 * @see IStreamFilenameGenerator#generateFilename(IScope, String,
	 *      IStreamFilenameGenerator.GenerationType)
	 */
	@Override
	public String generateFilename(IScope scope, String name,
			GenerationType type) {
		return generateFilename(scope, name, null, type);
	}

	/**
	 * 得到指定用户用于存放flv文件的folder
	 * 
	 */
	public static String getUserFlvFolder(User user) {
		String rootPath = DefaultUploadHandler.getRootPath();
		return new StringBuffer(rootPath).append(user.getId()).append(
				File.separator).append("flv").append(File.separator).toString();
	}

	/**
	 * 返回指定的用户flv文件
	 */
	public static File getUserFlv(User user, final String filename) {
		String folder = StreamFilenameGenerator.getUserFlvFolder(user);
		File file = new File(folder);
		if (!file.exists()) {
			return null;
		}
		File[] files = file.listFiles(new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				String name = pathname.getName();
				return pathname.isFile() && name.equals(filename);
			}
		});

		return (files == null || files.length == 0) ? null : files[0];
	}

	/**
	 * 列出某用户录制的所有flv文件
	 * 
	 * @return 一个Map对象的列表，map的key为name,user,time,分别对应文件的名字，用户名，最后修改时间
	 */
	public List<Map<String, String>> listUserFlvs(User user) {
		String folder = StreamFilenameGenerator.getUserFlvFolder(user);
		File file = new File(folder);
		if (!file.exists()) {
			return Collections.emptyList();
		}
		File[] files = file.listFiles(new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				String name = pathname.getName();
				return pathname.isFile()
						&& ".flv".equals(name.substring(name.lastIndexOf(".")));
			}
		});
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		for (File flv : files) {
			String name = flv.getName();
			User actor = userManager.getUser(name.substring(0, name
					.lastIndexOf(FLV_NAME_SUFFIX)));
			if (actor != null) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("name", name);
				map.put("user", actor.getName());
				map.put("time", DateUtil.getDateTime("yyyy-MM-dd hh:mm",
						new Date(flv.lastModified())));
				list.add(map);
			}
		}
		return list;
	}

	/**
	 * @see IStreamFilenameGenerator#resolvesToAbsolutePath()
	 */
	@Override
	public boolean resolvesToAbsolutePath() {
		return true;
	}

}
