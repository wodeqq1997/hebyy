package com.systop.scos.addressBook.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;

import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.addressBook.model.AddressBookType;

@Service
public class AddressBookTypeManager extends BaseGenericsManager<AddressBookType> {

	@SuppressWarnings("unchecked")
	public Map<Integer, String> getAddressBookTypeMap() {
		
		StringBuffer sql = new StringBuffer("from AddressBookType a where 1=1 ");
		List<Object> args = new ArrayList<Object>();
		
		
		List<AddressBookType> addressBookTypes = query(sql.toString(), args.toArray());
		Map<Integer, String> typeMap = new LinkedMap();
		for (AddressBookType addressBookType : addressBookTypes) {
			typeMap.put(addressBookType.getId(), addressBookType.getName());
		}
		return typeMap;
	}

}
