package com.systop.video.upload.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.service.BaseGenericsManager;
import com.systop.video.model.SharedFile;



/**
 * 用于处理视频共享文件的中文名，因为FreeBSD不支持中文
 * 文件名，所以需要将中文文件名放在数据库中
 * @author catstiger@gmail.com
 *
 */
@Service
public class SharedFileManager extends BaseGenericsManager<SharedFile> {
  
  @Transactional
  public void create(Integer userId, String filename, String encodeName, String size) {
    SharedFile sharedFile = new SharedFile();
    sharedFile.setCnName(filename);
    sharedFile.setEnName(encodeName);
    sharedFile.setOwner(userId);
    sharedFile.setSize(size);
    
    getDao().save(sharedFile);
  }
  
  /**
   * 根据中文名，返回保存在文件系统中的共享文件
   */
  public SharedFile getByCnName(String cnName, Integer userId) {
    return findObject("from SharedFile sf where sf.cnName=? and sf.owner=?",
        new Object[]{cnName, userId});
  }
  
  /**
   * 返回某个用户的共享文件
   */
  public List<SharedFile> getByUserId(Integer userId) {
    return this.query("from SharedFile sf where sf.owner = ?", userId);
  }
  
}
