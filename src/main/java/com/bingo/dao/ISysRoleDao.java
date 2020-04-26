package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.SysRole;

@Repository(value = "iSysRoleDao")
public interface ISysRoleDao {
	/**
	 * 
	 * @Title: findAllSysRole
	 * @Description: TODO(查询所有角色信息)
	 * @return List<SysRole>
	 */
	public List<SysRole> findAllSysRole();

	/**
	 * 
	 * @Title: findSysRoleByUserId
	 * @Description: TODO(根据用户id查询角色)
	 * @param id
	 * @return List<SysRole>
	 */
	public List<SysRole> findSysRoleByUserId(Integer userId);

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

}
