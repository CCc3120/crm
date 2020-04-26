package com.bingo.bean;

import java.io.Serializable;

public class SysRolePermission implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private SysRole sysRole;
	private SysPermission sysPermission;

	public SysRolePermission() {
		super();
	}

	public SysRolePermission(Integer id, SysRole sysRole, SysPermission sysPermission) {
		super();
		this.id = id;
		this.sysRole = sysRole;
		this.sysPermission = sysPermission;
	}

	public SysRolePermission(SysRole sysRole, SysPermission sysPermission) {
		super();
		this.sysRole = sysRole;
		this.sysPermission = sysPermission;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SysRole getSysRole() {
		return sysRole;
	}

	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
	}

	public SysPermission getSysPermission() {
		return sysPermission;
	}

	public void setSysPermission(SysPermission sysPermission) {
		this.sysPermission = sysPermission;
	}

	@Override
	public String toString() {
		return "SysRolePermission [id=" + id + ", sysRole=" + sysRole + ", sysPermission=" + sysPermission + "]";
	}

}
