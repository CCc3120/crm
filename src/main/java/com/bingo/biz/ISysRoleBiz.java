package com.bingo.biz;

import java.util.List;

import com.bingo.bean.SysRole;

public interface ISysRoleBiz {
	/**
	 * 
	 * @Title: findAllSysRole
	 * @Description: TODO(查询所有角色信息)
	 * @return List<SysRole>
	 */
	public List<SysRole> findAllSysRole();

	/**
	 * 
	 * @Title: insertSysRole
	 * @Description: TODO(添加角色)
	 * @param role
	 * @return int
	 */
	public int insertSysRole(SysRole role);

	/**
	 * 
	 * @Title: updateSysRole
	 * @Description: TODO(修改角色)
	 * @param role
	 * @return int
	 */
	public int updateSysRole(SysRole role);

	/**
	 * 
	 * @Title: deleteSysRole
	 * @Description: TODO(删除角色)
	 * @param id
	 * @return int
	 */
	public int deleteSysRole(Integer id);

	/**
	 * 
	 * @Title: findSysRoleByUserId
	 * @Description: TODO(根据用户id查询角色)
	 * @param id
	 * @return List<SysRole>
	 */
	public List<SysRole> findSysRoleByUserId(Integer userId);
}
