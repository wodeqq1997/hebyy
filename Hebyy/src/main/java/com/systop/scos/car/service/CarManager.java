package com.systop.scos.car.service;

import java.io.Serializable;

import javax.servlet.ServletContext;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.fileattch.FileConstants;
import com.systop.common.modules.fileattch.model.FileAttch;
import com.systop.common.modules.fileattch.service.FileAttchManager;
import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.car.model.Car;

/**
 * 车辆信息管理类
 * 
 * @author SongBaoJie
 */
@Service
public class CarManager extends BaseGenericsManager<Car> {
	// 附件操作类
	@Autowired
	private FileAttchManager fileAttchManager;

	@Transactional
	public void save(Car entity) {
		if (entity != null) {
			if (getDao().exists(entity, "carNo") || getDao().exists(entity, "engineNo") ) {
				throw new ApplicationException("该车辆已经存在,请您查证后再次录入");
			}
			// 当存在附件id时反向修改附件的类别信息
			fileAttchManager.updateFileType(entity.getCarPhoto(),
					FileConstants.CAR);
			getDao().saveOrUpdate(entity);
		}
	}

	/**
	 * 删除车辆图片
	 * 
	 * @param id
	 */
	@Transactional
	public void removeCarPhoto(Car car, ServletContext context) {
		fileAttchManager.removeByIds(car.getCarPhoto(), context);
		car.setCarPhoto(null);
		getDao().saveOrUpdate(car);
	}

	/**
	 * 查询车辆，如果车辆照片附件不存在，直接将carPhoto set null;
	 * 
	 * @param id
	 * @return Car
	 */
	@Override
	@Transactional
	public Car get(Serializable id) {
		Car car = super.get(id);
		if (car != null) {
			String photoId = car.getCarPhoto();
			if (StringUtils.isNotBlank(photoId)) {
				photoId = photoId.replace(",", "");
				if (StringUtils.isNumeric(photoId)) {
					FileAttch fileAttch = fileAttchManager.get(Integer.valueOf(photoId));
					if (fileAttch == null) {
						car.setCarPhoto(null);
						getDao().saveOrUpdate(car);
					} else {
						car.setFileAttch(fileAttch);
					}
				}
			}
		}
		return car;
	}
}
