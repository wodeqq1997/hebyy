package com.systop.archive.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.systop.archive.ArchiveConstants;
import com.systop.archive.model.ArchiveFile;
import com.systop.archive.model.ArchiveFileLend;
import com.systop.common.modules.security.user.model.User;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.zjimis.flow.FlowConstants;
import com.systop.zjimis.flow.model.Flow;
import com.systop.zjimis.flow.model.FlowNode;
import com.systop.zjimis.flow.service.FlowManager;
import com.systop.zjimis.flow.service.FlowNodeManager;

/**
 * 档案文件借阅记录Service
 * 
 * @author SongBaoJie
 */
@Service
public class ArchiveFileLendManager extends BaseGenericsManager<ArchiveFileLend> {
	
	@Autowired
	private FlowManager flowManager;
	
	@Autowired
	private FlowNodeManager flowNodeManager;
	
	@Autowired
	private ArchiveFileManager archiveFileManager;
		
	/**
	 * 删除记录同时删除所有审批流程
	 */
	@Override
	@Transactional(readOnly = false)
	public void remove(ArchiveFileLend entity) {
		List<Flow> flows = entity.getFlows();
		for(Flow flow : flows){
			List<FlowNode> flowNodes = flow.getNodes();
			for(FlowNode node : flowNodes){
				flowNodeManager.remove(node);
			}
			flowManager.remove(flow);
		}
		super.remove(entity);
	}

	/**
	 * 保存档案文件借阅记录信息同时保存审核流程 
	 * @param entity
	 * @param auditors
	 * @param fileIds 【借阅文件ID，用，分割多个】
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void save(ArchiveFileLend entity, String auditor, String fileIds){
		if(StringUtils.isNotEmpty(fileIds)){
			String[] fids = fileIds.split(",");
			//暂时没有实现，借阅多条记录
			for(String fid : fids){
				if(StringUtils.isNotBlank(auditor)){
					//保存申请日期
					entity.setCreateTime(new Date());
					//根据文件ID得到档案文件
					ArchiveFile file = archiveFileManager.get(Integer.valueOf(fid));
					if(file == null){
						throw new ApplicationException("申请文件不存在！");
					}
					//添加申请文件
					entity.setArchiveFile(file);
					//创建或修改档案文件借阅记录信息
					save(entity);
					//创建审批流程
					flowManager.saveFlowByField(FlowConstants.FIELD_ARCHIVEFILELEND, entity.getId()+"", auditor, entity.getLendUser());
				}
			}
		}
	}
	
	/**
	 * 根据当前用户和借阅档案文件ID判断是否已经借阅该文件（不包括未审核通过的）
	 * @param fileId
	 * @param user
	 * @return
	 */
	public boolean isArchiveFile(Integer fileId, User user){
		Long count = (Long)getDao().findObject("select count(a.id) from ArchiveFileLend a " 
												+ "where a.archiveFile.id = ? " 
												+ "and a.lendUser.id = ? " 
												+ "and a.status != ? " 
												+ "and a.alsoDate is null", fileId, user.getId(), ArchiveConstants.STATUS_NOPASS);
		return count > 0;
	}
}

