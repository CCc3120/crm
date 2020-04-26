package com.bingo.bean;

import java.io.Serializable;
import java.util.List;

public class SysPermission implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String type;
	private String url;
	private String perCode;
	private Integer parentid;
	private Integer parentids;
	private String sortstring;
	private String available;

	private List<SysPermission> sysPermission;//二级菜单

	public SysPermission() {
		super();
	}

	public SysPermission(Integer id, String name, String type, String url, String perCode, Integer parentid,
			Integer parentids, String sortstring, String available) {
		super();
		this.id = id;
		this.name = name;
		this.type = type;
		this.url = url;
		this.perCode = perCode;
		this.parentid = parentid;
		this.parentids = parentids;
		this.sortstring = sortstring;
		this.available = available;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPerCode() {
		return perCode;
	}

	public void setPerCode(String perCode) {
		this.perCode = perCode;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	public Integer getParentids() {
		return parentids;
	}

	public void setParentids(Integer parentids) {
		this.parentids = parentids;
	}

	public String getSortstring() {
		return sortstring;
	}

	public void setSortstring(String sortstring) {
		this.sortstring = sortstring;
	}

	public String getAvailable() {
		return available;
	}

	public void setAvailable(String available) {
		this.available = available;
	}

	public List<SysPermission> getSysPermission() {
		return sysPermission;
	}

	public void setSysPermission(List<SysPermission> sysPermission) {
		this.sysPermission = sysPermission;
	}

	@Override
	public String toString() {
		return "SysPermission [id=" + id + ", name=" + name + ", type=" + type + ", url=" + url + ", perCode=" + perCode
				+ ", parentid=" + parentid + ", parentids=" + parentids + ", sortstring=" + sortstring + ", available="
				+ available + "]";
	}

}
