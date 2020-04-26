package com.bingo.dao;

import org.springframework.stereotype.Repository;

import com.bingo.bean.SysRolePermission;

@Repository(value = "iSysRolePermissionDao")
public interface ISysRolePermissionDao {
	public int insertSysRolePermission(SysRolePermission rolePermission);

	public int deleteSysRolePermission(Integer roleId);
}
