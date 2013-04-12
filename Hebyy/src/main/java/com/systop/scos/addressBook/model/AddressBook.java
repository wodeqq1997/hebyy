package com.systop.scos.addressBook.model;
/**
 * 通讯录
 */
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.systop.core.model.BaseModel;

@Entity
@Table(name = "address_book")
@SuppressWarnings("serial")
public class AddressBook extends BaseModel {

	private Integer id;
	
	//姓名
	private String name;
	
	//手机号
	private String number;

	//家庭号码
	private String homeNumber;
	
	//办公号码
	private String officeNumber;
	
	//备注
	private String descn;
	
	//类别
	private AddressBookType addressBookType;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "number")
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "addressBook_type_id")
	public AddressBookType getAddressBookType() {
		return addressBookType;
	}

	public void setAddressBookType(AddressBookType addressBookType) {
		this.addressBookType = addressBookType;
	}

	@Column(name = "homeNumber")
	public String getHomeNumber() {
		return homeNumber;
	}

	public void setHomeNumber(String homeNumber) {
		this.homeNumber = homeNumber;
	}

	@Column(name = "officeNumber")
	public String getOfficeNumber() {
		return officeNumber;
	}

	public void setOfficeNumber(String officeNumber) {
		this.officeNumber = officeNumber;
	}

	@Column(name = "descn")
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}
	
}
