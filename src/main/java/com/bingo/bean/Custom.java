package com.bingo.bean;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Custom implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String sex;
	private String address;
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd")
	private Date birthday;

	public Custom() {
		super();
	}

	public Custom(Integer id, String name, String sex, String address, Date birthday) {
		super();
		this.id = id;
		this.name = name;
		this.sex = sex;
		this.address = address;
		this.birthday = birthday;
	}

	public Custom(String name, String sex, String address, Date birthday) {
		super();
		this.name = name;
		this.sex = sex;
		this.address = address;
		this.birthday = birthday;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	@Override
	public String toString() {
		return "Custom [id=" + id + ", name=" + name + ", sex=" + sex + ", address=" + address + ", birthday="
				+ birthday + "]";
	}

}
