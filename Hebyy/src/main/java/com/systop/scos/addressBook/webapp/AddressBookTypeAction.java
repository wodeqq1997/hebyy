package com.systop.scos.addressBook.webapp;

/**
 * 通讯录类别Action
 */
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.addressBook.model.AddressBookType;
import com.systop.scos.addressBook.service.AddressBookTypeManager;
@SuppressWarnings({  "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AddressBookTypeAction extends DefaultCrudAction<AddressBookType, AddressBookTypeManager> {

	public String index(){
		StringBuffer hql = new StringBuffer(" from AddressBookType a where 1 = 1");
		List<Object> args = new ArrayList<Object>();
		
		if(StringUtils.isNotBlank(getModel().getName())){
			hql.append(" and a.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		
		return INDEX;
	}
}
