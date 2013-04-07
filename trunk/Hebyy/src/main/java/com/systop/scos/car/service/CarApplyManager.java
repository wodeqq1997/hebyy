package com.systop.scos.car.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.core.ApplicationException;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.car.CarConstants;
import com.systop.scos.car.model.Car;
import com.systop.scos.car.model.CarApply;
import com.systop.scos.car.model.CarUseRecord;

/**
 * 汽车使用申请记录管理类
 * 
 * @author SongBaoJie
 */
@Service
public class CarApplyManager extends BaseGenericsManager<CarApply> {
	@Autowired
	private CarManager carManager;
	
	@Autowired
	private CarUseRecordManager carUseRecordManager;
	
	@Override
	@Transactional
	public void save(CarApply entity) {
		if (entity != null) {
			if(entity.getCar() != null && entity.getCar().getId() != null){
				Car car = carManager.get(entity.getCar().getId());
				// 判断是否申请报废车辆,报废或维修车辆不允许被申请
				if(!car.getStatus().equals(CarConstants.CAR_AVAILABLE)){
					throw new ApplicationException("该车辆状态不允许被申请使用！");
				}
			}
			
			if(entity.getCar() != null && entity.getCar().getId() == null){
				entity.setCar(null);
			}
			
			//保存记录时，默认状态为：0=未审核
			if(entity.getId() == null){
				entity.setStatus(CarConstants.CAR_APPLY_NOT_EXAMINE);
			}
			getDao().saveOrUpdate(entity);
		}
	}
	
	/**
	 * 车辆申请审批通过<br>
	 * 审批通过后将生成一条使用记录。
	 * @param carApply
	 */
	@Transactional
	public void passCarApply(CarApply carApply){
		
		if(!carApply.getStatus().equals(CarConstants.CAR_APPLY_NOT_EXAMINE)){
			throw new ApplicationException("该申请已经审批过！");
		}
		CarUseRecord carUseRecord = new CarUseRecord();
		carUseRecord.setProposer(carApply.getProposer());
		carUseRecord.setPersonCount(carApply.getPersonCount());
		carUseRecord.setCar(carApply.getCar());
		carUseRecord.setStartTime(carApply.getStartTime());
		carUseRecord.setEndTime(carApply.getEndTime());
		carUseRecord.setStartMileage(carApply.getStartMileage());
		carUseRecord.setEndMileage(carApply.getEndMileage());
		carUseRecord.setApplyDate(carApply.getApplyDate());
		carUseRecord.setReason(carApply.getReason());
		carUseRecord.setNotes(carApply.getNotes());
		carUseRecordManager.save(carUseRecord);
		carApply.setStatus(CarConstants.CAR_APPLY_PASS);
		
		try {
			save(carApply);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
