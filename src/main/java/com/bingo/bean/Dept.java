package com.bingo.bean;

import java.io.Serializable;
import java.util.List;

public class Dept implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;// 部门编号
	private String name;// 部门名
	private String desc;// 部门描述
	private Integer maxPerson;// 最大人数

	private List<Emp> elist;

	public Dept() {
		super();
	}

	public Dept(String name, String desc, Integer maxPerson) {
		super();
		this.name = name;
		this.desc = desc;
		this.maxPerson = maxPerson;
	}

	public Dept(Integer id, String name, String desc, Integer maxPerson, List<Emp> elist) {
		super();
		this.id = id;
		this.name = name;
		this.desc = desc;
		this.maxPerson = maxPerson;
		this.elist = elist;
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

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Integer getMaxPerson() {
		return maxPerson;
	}

	public void setMaxPerson(Integer maxPerson) {
		this.maxPerson = maxPerson;
	}

	public List<Emp> getElist() {
		return elist;
	}

	public void setElist(List<Emp> elist) {
		this.elist = elist;
	}

	@Override
	public String toString() {
		return "Dept [id=" + id + ", name=" + name + ", desc=" + desc + ", maxPerson=" + maxPerson + ", elist=" + elist
				+ "]";
	}

}
