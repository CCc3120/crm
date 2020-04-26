package com.bingo.biz;

public interface ISysUserRoleBiz {
	/**
	 * 
	 * @Title: insertSysUserRole
	 * @Description: TODO(添加用户角色关系)
	 * @param userRole
	 * @return int
	 */
	public int insertSysUserRole(String[] roleIds, Integer userId);

	/**
	 * 
	 * @Title: deleteSysUserRole
	 * @Description: TODO(删除用户角色关系)
	 * @param userId
	 * @return int
	 */
	public int deleteSysUserRole(Integer userId);
}
