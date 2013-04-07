package com.systop.scos.car.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.car.CarConstants;
import com.systop.scos.car.model.Car;
import com.systop.scos.car.model.CarUseRecord;

/**
 * 汽车使用记录管理类
 * 
 * @author SongBaoJie
 */
@Service
public class CarUseRecordManager extends BaseGenericsManager<CarUseRecord> {
	@Autowired
	private CarManager carManager;
	@Override
	@Transactional
	public void save(CarUseRecord entity) {
		if (entity != null) {
			if(entity.getCar() != null && entity.getCar().getId() != null){
				Car car = carManager.get(entity.getCar().getId());
				// 判断是否申请报废车辆,报废或维修车辆不允许被申请
				if(!car.getStatus().equals(CarConstants.CAR_AVAILABLE)){
					throw new ApplicationException("该车辆状态不允许被申请使用！");
				}
			}
			//保存记录时，默认状态为：0=未审核
			if(entity.getId() == null){
				entity.setStatus(CarConstants.CAR_APPLY_NOT_EXAMINE);
			}
			getDao().saveOrUpdate(entity);
		}
	}
}
