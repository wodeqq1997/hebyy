package com.systop.scos.addressBook.webapp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.systop.core.util.PageUtil;
import com.systop.core.webapp.struts2.action.DefaultCrudAction;
import com.systop.scos.addressBook.model.AddressBook;
import com.systop.scos.addressBook.service.AddressBookManager;
import com.systop.scos.addressBook.service.AddressBookTypeManager;

@SuppressWarnings({ "serial" })
@Controller
@Scope(BeanDefinition.SCOPE_PROTOTYPE)
public class AddressBookAction extends
		DefaultCrudAction<AddressBook, AddressBookManager> {

	//号码查询
	private String phone;
	
	@Autowired
	private AddressBookTypeManager addressBookTypeManager;
	
	public String index(){
		StringBuffer hql = new StringBuffer("from AddressBook a where 1 =1 ");
		List<Object> args = new ArrayList<Object>();
		
		if(StringUtils.isNotBlank(getModel().getName())){
			hql.append(" and a.name like ? ");
			args.add(MatchMode.ANYWHERE.toMatchString(getModel().getName()));
		}
		
		if(StringUtils.isNotBlank(phone)){
			hql.append(" and (a.number like ? or a.homeNumber like ? or a.officeNumber like ? )");
			args.add(MatchMode.ANYWHERE.toMatchString(phone));
			args.add(MatchMode.ANYWHERE.toMatchString(phone));
			args.add(MatchMode.ANYWHERE.toMatchString(phone));
		}
		
		if(getModel().getAddressBookType() != null && getModel().getAddressBookType().getId() != null){
			hql.append(" and a.addressBookType.id = ?");
			args.add(getModel().getAddressBookType().getId());
		}
		
		page = PageUtil.getPage(getPageNo(), getPageSize());
		page = getManager().pageQuery(page, hql.toString(), args.toArray());
		restorePageData(page);
		return INDEX;
	}

	/**
	 * 类别Map
	 * @return
	 */
	public Map<Integer, String> getAddressBookTypeMap() {
		return addressBookTypeManager.getAddressBookTypeMap();
	}
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
