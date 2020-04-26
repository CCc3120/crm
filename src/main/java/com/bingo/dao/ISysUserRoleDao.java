package com.bingo.dao;

import org.springframework.stereotype.Repository;

import com.bingo.bean.SysUserRole;

@Repository(value = "iSysUserRoleDao")
public interface ISysUserRoleDao {
	/**
	 * 
	 * @Title: insertSysUserRole
	 * @Description: TODO(添加用户角色关系)
	 * @param userRole
	 * @return int
	 */
	public int insertSysUserRole(SysUserRole userRole);

	/**
	 * 
	 * @Title: deleteSysUserRole
	 * @Description: TODO(删除用户角色关系)
	 * @param userId
	 * @return int
	 */
	public int deleteSysUserRole(Integer userId);

}
