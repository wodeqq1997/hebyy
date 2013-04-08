package com.systop.scos.attendance.webapp;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.attendance.model.Time;
import com.systop.scos.attendance.service.TimeManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class TimeAction extends DefaultCrudAction<Time, TimeManager> {

	private Time time;
	
	private Integer id;
	
	//上午上班
	private String morWork ;
	
	//上午下班
	private String morOver ;
	
	//下午上班
	private String afWork ;
	
	//下午下班
	private String afOver ;
	
	public String save(){
		Time time = new Time();
		time.setId(id);
		time.setAfOver(afOver);
		time.setAfWork(afWork);
		time.setMorOver(morOver);
		time.setMorWork(morWork);
		getManager().save(time);
		return SUCCESS;
	}
	
	public String edit(){
		time = getManager().findObject("from Time");
		return INPUT;
	}

	public Time getTime() {
		return time;
	}

	public void setTime(Time time) {
		this.time = time;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMorWork() {
		return morWork;
	}

	public void setMorWork(String morWork) {
		this.morWork = morWork;
	}

	public String getMorOver() {
		return morOver;
	}

	public void setMorOver(String morOver) {
		this.morOver = morOver;
	}

	public String getAfWork() {
		return afWork;
	}

	public void setAfWork(String afWork) {
		this.afWork = afWork;
	}

	public String getAfOver() {
		return afOver;
	}

	public void setAfOver(String afOver) {
		this.afOver = afOver;
	}
	
	
}