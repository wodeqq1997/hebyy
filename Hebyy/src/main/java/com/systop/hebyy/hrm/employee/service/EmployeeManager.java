package com.systop.hebyy.hrm.employee.service;

import java.io.File;
import java.io.Serializable;

import javax.servlet.ServletContext;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ibm.icu.text.SimpleDateFormat;
import com.systop.common.modules.dept.model.Dept;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.service.BaseGenericsManager;
import com.systop.hebyy.hrm.employee.model.Employee;
@SuppressWarnings("unused")
@Service
public class EmployeeManager extends BaseGenericsManager<Employee>{

	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;
	@Transactional
	public void importData(String uploadFileName) {
		try {
//			System.out.println("正在处理数据：" + uploadFileName);
			Workbook workbook = null;
			Sheet sheet = null;
			//打开文件
			workbook = Workbook.getWorkbook(new File(uploadFileName));
			//打开工作表
			sheet = workbook.getSheet(0);
			//获取工作表行列数目
		
			int colCount = sheet.getColumns();
			int rowCount = sheet.getRows();
//			System.out.println("ColCount:" + colCount + " RowCount:" + rowCount);
			//循环读取Excel数据，填充到数据表中
			for (int i = 1; i<rowCount; i++) {
				SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd");
					//企业对个人转账业务
				Employee employee = new Employee();
				employee.setName(sheet.getCell(0,i).getContents());
				employee.setSex(sheet.getCell(1,i).getContents());
					//User user = new User();				//企业账户
					//user.setSapNo(sheet.getCell(0,i).getContents());//SAP号
					//user.setSupplierName(sheet.getCell(1,i).getContents());
					//user.setName(sheet.getCell(0,i).getContents());
					//user.setAddress(sheet.getCell(1,i).getContents());
					//user.setDegree(sheet.getCell(2,i).getContents());
					//user.setCollege(sheet.getCell(3,i).getContents());
					//user.setStatus("1");
					//user.setBirthDay(formate.parse(sheet.getCell(4,i).getContents()));
					//user.setDept(null);
					//user.setDescn(sheet.getCell(5,i).getContents());
					//user.setEmail(sheet.getCell(6,i).getContents());
					//user.setEmergencyPhone(sheet.getCell(7,i).getContents());
					//user.setEnterpriseExt(null);
					//user.setFileStorage(sheet.getCell(8,i).getContents());
					//user.setFox(sheet.getCell(9,i).getContents());
					/*user.setIdNumber(" ");
					user.setIssuerBank(" ");
					user.setOrganizationCode(" ");
					user.setProvince(" ");
					user.setSupplierAbbreviation(" ");
					user.setSupplierAccount(" ");
					user.setSupplierType(" ");
					user.setTerminate("0");
					user.setZipCode(null);*/
//					System.out.println(supplier.getSapNo());
					getDao().save(employee);										
			}
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		System.out.println(uploadFileName + "文件处理失败！" + e.getMessage());
		}
	}
	
	@Transactional
	public void save(Employee employee, Integer deptId) {
		if (deptId != null) {
			employee.setDept(getDao().get(Dept.class, deptId));
		}
		save(employee);
	}
	
	/**
	 * 根据Id获得用户，同时加在用户照片信息
	 * @param id
	 * @return
	 */
	public Employee get(Serializable id) {
		Employee e = super.get(id);
		// 获得个人照片
		if (e != null && StringUtils.isNotBlank(e.getPhotoId())) {
			e.setPhoto(fileAttchManager.findFirst(e.getPhotoId()));
		}
		return e;
	}
	
	/**
	 * 删除用户照片
	 * @param user
	 * @param context
	 */
	@Transactional
	public void removeUserPhoto(Employee employee, ServletContext context){
		if (employee != null){
			fileAttchManager.removeByIds(employee.getPhotoId(), context);
			employee.setPhotoId(null);
			getDao().update(employee);
		}
	}

}
