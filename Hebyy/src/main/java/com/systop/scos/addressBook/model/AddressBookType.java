package com.systop.scos.addressBook.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.systop.core.model.BaseModel;
@Entity
@Table(name = "addressBook_type")
@SuppressWarnings("serial")
public class AddressBookType extends BaseModel {

	private Integer id;
	
	private String name;
	
	private String descn;

	private Set<AddressBook> addressBooks = new HashSet<AddressBook>();
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

	@Column(name = "descn")
	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	@OneToMany(cascade = {}, fetch = FetchType.LAZY, mappedBy = "addressBookType")
	public Set<AddressBook> getAddressBooks() {
		return addressBooks;
	}

	public void setAddressBooks(Set<AddressBook> addressBooks) {
		this.addressBooks = addressBooks;
	}
	
}
