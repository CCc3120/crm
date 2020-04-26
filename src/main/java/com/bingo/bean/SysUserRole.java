package com.bingo.bean;

import java.io.Serializable;

public class SysUserRole implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private SysUser sysUser;
	private SysRole sysRole;

	public SysUserRole() {
		super();
	}

	public SysUserRole(Integer id, SysUser sysUser, SysRole sysRole) {
		super();
		this.id = id;
		this.sysUser = sysUser;
		this.sysRole = sysRole;
	}

	public SysUserRole(SysUser sysUser, SysRole sysRole) {
		super();
		this.sysUser = sysUser;
		this.sysRole = sysRole;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}

	public SysRole getSysRole() {
		return sysRole;
	}

	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
	}

	@Override
	public String toString() {
		return "SysUserRole [id=" + id + ", sysUser=" + sysUser + ", sysRole=" + sysRole + "]";
	}
}
