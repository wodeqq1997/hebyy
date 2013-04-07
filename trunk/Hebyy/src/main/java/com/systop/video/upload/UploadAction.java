package com.systop.video.upload;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ResourceBundle;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;

import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.common.modules.upload.UploadHandler;
import com.systop.core.util.FileUtil;
import com.systop.core.util.ResourceBundleUtil;
import com.systop.core.webapp.struts2.action.BaseAction;
import com.systop.video.model.SharedFile;
import com.systop.video.StreamFilenameGenerator;
import com.systop.video.upload.service.SharedFileManager;



@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class UploadAction extends BaseAction {
  /**
   * 上传文件时，userId参数也要传上来
   */
  public static final String USER_ID_FIELD = ResourceBundle.getBundle(
      ResourceBundleUtil.DEFAULT_BUNDLE).getString("red5.upload.userId");
  /**
   * 上传文件时，UPLOAD的文件的参数名
   */
  public static final String UPLOAD_FIELD = ResourceBundle.getBundle(
      ResourceBundleUtil.DEFAULT_BUNDLE).getString("red5.upload");
  /**
   * 上传文件时，文件名的参数名
   */
  public static final String FILENAME_FIELD = ResourceBundle.getBundle(
      ResourceBundleUtil.DEFAULT_BUNDLE).getString("red5.upload.filename");
  /**
   * 用户ID
   */
  private Integer userId;
  
  @Autowired
  private UserManager userManager;
  
  /**
   * 被下载文件的文件名
   */
  private String filename;
  
  @Autowired
  private UploadHandler uploadHandler;
  
  @Autowired
  private SharedFileManager sharedFileManager;
  
  /**
   * 接收上传的文件
   * @return
   */
  @Transactional
  public String upload() {
    logger.info("正在处理文件上传！");
    if(!(getRequest() instanceof MultiPartRequestWrapper)) {
      return null;
    }
    //struts2的uploadInterceptor的处理方式有问题，不能得到文件，所以只能绕过去
    MultiPartRequestWrapper request = (MultiPartRequestWrapper) getRequest();    
    String[] filenames = request.getFileNames(UPLOAD_FIELD);
    File [] files = request.getFiles(UPLOAD_FIELD);
    if(ArrayUtils.isEmpty(filenames) || ArrayUtils.isEmpty(files)) {
      logger.info("没有传上文件。");
    }
    for(int i = 0; (i < files.length && i < filenames.length); i++) {
      Integer userId = Integer.valueOf(request.getParameter(USER_ID_FIELD));
      //以随机明为文件名，防止unix下乱码
      String randName = RandomStringUtils.randomNumeric(30);
      File f = uploadHandler.save(files[i], randName, userId);
      logger.info("视频共享上传文件名<<{}>>", encodeFilename(filenames[i]));
      //保存文件到数据库
      sharedFileManager.create(userId, filenames[i], randName, FileUtil.formatSize(f));
    }
        
    return null;
  }
  
  /**
   * 下载指定的文件，由userId确定文件路径，由filename确定文件名。
   * @return
   */  
  public synchronized String download() {
    if(StringUtils.isBlank(filename) || userId == null || !StringUtils.isNumeric(filename)) {
      return null;
    }
    
    SharedFile sharedFile = sharedFileManager.get(Integer.valueOf(filename)); //flash传的是文件的ID
    if(sharedFile == null) {
      logger.warn("Share file not found {}", filename);
      return null;
    }
    InputStream in = uploadHandler.get(sharedFile.getEnName(), userId);    
    if (in != null) {
      logger.debug("dowloading {}", sharedFile.getEnName());
      String fname = sharedFile.getCnName();
      try {
        fname = URLEncoder.encode(fname, "UTF-8");
      } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      getResponse().addHeader("Content-Disposition", "attachment;filename=" + fname);

      getResponse().setContentType("application/x-download;charset=UTF-8");
      try {
        FileCopyUtils.copy(in, getResponse().getOutputStream());
        logger.info("正在下载文件{}",fname);
      } catch (Exception e) {
        logger.warn("文件下载错误:{}", e.getMessage());
        e.printStackTrace();
      }
    } else {
      logger.warn("文件找不到{}-{}", userId, filename);
    }
    
    return null;
  }
  
  /**
   * 下载用户录制的flv文件
   */
  public String downloadFlv() {
    logger.debug("下载flv文件{}", filename);
    User user = userManager.get(userId);
    File file = StreamFilenameGenerator.getUserFlv(user, filename);
    String fname = encodeFilename(filename);
    try {
      fname = URLEncoder.encode(fname, "UTF-8");
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    }
    getResponse().addHeader("Content-Disposition", "attachment;filename=" + fname);
    getResponse().setContentType("application/x-download;charset=UTF-8");
    try {
      InputStream in = new BufferedInputStream(new FileInputStream(file));
      FileCopyUtils.copy(in, getResponse().getOutputStream());
    } catch (IOException e) {
      logger.warn("文件下载错误:{}", e.getMessage());
      e.printStackTrace();
    }
    
    return null;
  }
  
  /**
   * 删除文件，由userId确定文件路径，由filename确定文件名。
   */
  public String remove() {
    if(StringUtils.isBlank(filename) || userId == null) {
      return null;
    }
    logger.debug("删除文件{}-{}", userId, filename);
    String fname = encodeFilename(filename);
    //找到实际的文件名
    SharedFile sharedFile = sharedFileManager.getByCnName(fname, userId);
    if(sharedFile == null) {
      logger.warn("文件未找到{}", fname);
      return null;
    }
    
    uploadHandler.remove(sharedFile.getEnName(), userId);
    sharedFileManager.remove(sharedFile);
    return null;
  }
  
  /**
   * 文件名重新编码，从flex提交的文件名是ISO-8859-1的。
   */
  private String encodeFilename(String filename) {
    try {
      return new String(filename.getBytes("ISO-8859-1"), "UTF-8");
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
      return null;
    }
  }
 

  public String getFilename() {
    return filename;
  }

  public void setFilename(String filename) {
    this.filename = filename;
  }

  public Integer getUserId() {
    return userId;
  }

  public void setUserId(Integer userId) {
    this.userId = userId;
  }

  /**
   * @return the uploadHandler
   */
  public UploadHandler getUploadHandler() {
    return uploadHandler;
  }

  /**
   * @param uploadHandler the uploadHandler to set
   */
  public void setUploadHandler(UploadHandler uploadedHandler) {
    this.uploadHandler = uploadedHandler;
  }
  
}
