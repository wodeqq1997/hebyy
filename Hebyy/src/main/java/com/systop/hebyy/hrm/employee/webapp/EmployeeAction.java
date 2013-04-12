package com.systop.hebyy.hrm.employee.webapp;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.validation.SkipValidation;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;

import com.systop.common.modules.security.user.UserConstants;
import com.systop.core.ApplicationException;
import com.systop.core.Constants;
import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.hebyy.hrm.employee.model.Employee;
import com.systop.hebyy.hrm.employee.service.EmployeeManager;
import com.systop.hebyy.hrm.extinfo.ExtinfoConstants;
@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class EmployeeAction extends DefaultCrudAction<Employee, EmployeeManager>{
	
	private File upload;//实际上传文件

	private String uploadFileName;//上传文件名
	
	// 是否由自己编辑
	private String editSelf;
	// 部门ID
	private Integer deptId;
	
	private boolean notifiedMessage;
	
	//private boolean _notifiedSms;
	
	public String showUsers(){
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer("from Employee ");
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return "showusers";
	}
	/**
	 * 导入员工Excel
	 * @return
	 */
	@SkipValidation
	public String importSupplier() {
		//上传文件路径
		String uploadroot = ExtinfoConstants.UPLOAD_ROOT;
		//上传文件是否为空
		if(upload != null){
			try{
			//上传文件路径
			String targetDirectory=uploadroot;
			//上传文件名
	        String targetFileName = uploadFileName;
	        //生成文件
	        File target = new File(targetDirectory, targetFileName);
	        //上传
	        FileUtils.copyFile(upload, target);          
	        //保存文件的存放路径
	        setUploadFileName(target.getPath());
//	        System.out.println("文件上传为：" + uploadFileName);
	        getManager().importData(uploadFileName);
//	        System.out.println(target.getPath() + "文件处理完毕。");
	        }catch(Exception e){
	        	e.printStackTrace();
	        }
		}
		return "importsuccess";
	}
	//返回导入数据页面
	@SkipValidation
	public String importIndex() {
		return "importsupplier";
	}

	public String saveEmployee() {
		try {
			Assert.notNull(getModel());
			if (deptId == null || deptId == 0) {
				addActionMessage("请选择所属部门");
				return INPUT;
			}
			// 负责部门中文逗号“，”替代为英文逗号“,”
            try{
			    getModel().setResponsibleDepts(getModel().getResponsibleDepts().replace("，",","));
            }catch (Exception e){
                getModel().setResponsibleDepts("");
            }
          
            // 分公司 for: 2013-01-23 by: wangfan
			getManager().getDao().getHibernateTemplate().clear();
			getManager().save(getModel(), deptId);
			if (editSelf != null && Constants.YES.equals(editSelf)) {
				addActionMessage("个人信息修改成功");
				return SUCCESS;
			}
		} catch (ApplicationException e) {
			addActionError(e.getMessage());
			return SUCCESS;
		}
        String referrer = getRequest().getHeader("referer");
        if(referrer.contains("from=hr")){
            return SUCCESS;
            }
        else {
        	return SUCCESS;
        }
        }
	/**
	 * 编辑用户
	 */
	@SkipValidation
	@Override
	public String editNew() {
		getModel().setSex(UserConstants.GENT);
		return INPUT;
	}
	/**
	 * 编辑用户，重新调用manager方法，目的是为了加在用户照片
	 */
	public String edit() {
		if (getModel() != null && getModel().getId() != null) {
			setModel(getManager().get(getModel().getId()));
		}
		return INPUT;
	}

	/**
	 * 删除用户照片
	 * 
	 * @return
	 */
	public String removePhoto() {
		getManager().removeUserPhoto(getModel(), getServletContext());
		if (Constants.YES.equals(editSelf)) {
			return "editSelfRemovePhoto";
		}
		return INPUT;
	}
	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public Integer getDeptId() {
		return deptId;
	}
	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}
	public String getEditSelf() {
		return editSelf;
	}
	public void setEditSelf(String editSelf) {
		this.editSelf = editSelf;
	}
 public boolean isNotifiedMessage() {
	        return notifiedMessage;
	    }
}
