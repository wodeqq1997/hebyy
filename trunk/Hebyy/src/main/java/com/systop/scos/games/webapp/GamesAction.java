package com.systop.scos.games.webapp;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.games.model.Games;
import com.systop.scos.games.service.GamesManager;

@SuppressWarnings("serial")
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class GamesAction extends DefaultCrudAction<Games, GamesManager> {

	
	public String index(){
		StringBuffer hql = new StringBuffer( "from Games g where 1 = 1 ");
		List<Object> args = new ArrayList<Object>();
		
		if(StringUtils.isNotBlank(getModel().getName())){
			hql.append(" and g.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}
}
