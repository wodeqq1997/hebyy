package com.systop.scos.info.notice.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.StrutsStatics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.core.Constants;
import com.systop.core.dao.support.Page;
import com.systop.core.service.BaseGenericsManager;
import com.systop.core.util.PageUtil;
import com.systop.scos.communicate.smsg.service.MessageManager;
import com.systop.scos.info.notice.model.Notice;

/**
 * 通知公告管理类
 * 
 * @author SongBaoJie
 */
@Service
public class NoticeManager extends BaseGenericsManager<Notice> {

	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;

	@Autowired
	private MessageManager messageManager;

	@Autowired
	private UserManager userManager;

	/**
	 * 通知公告保存，第一次创建的时候保存createTime
	 * 发表通知公告时，将为所有用户发送通知
	 */
	@Transactional
	public void save(Notice notice) {
        boolean notify = false;
		if (notice != null) {
			if (notice.getId() == null) {
				notice.setCreateTime(new Date());
                notify = true;
			}
			// 当存在附件id时反向修改附件的类别信息
			fileAttchManager.updateFileType(notice.getFileAttchIds(),
					FileConstants.NOTICE);
			getDao().saveOrUpdate(notice);

            if(notify){
                // 得到所有可用状态用户
                List<User> users = userManager.query("from User u where u.status = ?", Constants.STATUS_AVAILABLE);
                ServletContext ctx = (ServletContext) ActionContext.getContext().get(StrutsStatics.SERVLET_CONTEXT);
                String path = ctx.getContextPath();
                for(User user : users){
                    messageManager.saveNoticeMsg(path,notice,user);
                }
            }
		}
	}

	/**
	 * 删除通知公告的同时删除附件
	 * 
	 * @param entity
	 * @param context
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void remove(Notice entity, ServletContext context) {
		if (entity.getFileAttchIds() != null
				&& entity.getFileAttchIds().length() > 0)
			fileAttchManager.removeByIds(entity.getFileAttchIds(), context);
		super.remove(entity);
	}

	/**
	 * @param count
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Notice> getNotices(Integer count) {
		StringBuffer sql = new StringBuffer("from Notice n where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		sql.append("order by n.createTime desc");
		
		Page page = PageUtil.getPage(1, count);
		page =  pageQuery(page, sql.toString(),args.toArray());
		return  page.getData();
	}
}
