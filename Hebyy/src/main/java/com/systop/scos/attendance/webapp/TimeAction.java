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

}
