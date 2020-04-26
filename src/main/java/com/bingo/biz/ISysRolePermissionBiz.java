package com.bingo.biz;


public interface ISysRolePermissionBiz {
	public int deleteSysRolePermission(Integer roleId);

	public int insertSysRolePermission(String[] perId, Integer roleId);
}
