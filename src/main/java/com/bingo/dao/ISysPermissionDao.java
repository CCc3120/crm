package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.SysPermission;

@Repository(value = "iSysPermissionDao")
public interface ISysPermissionDao {
	/**
	 * 
	 * @Title: findAllPermission
	 * @Description: TODO(查询所有权限)
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findAllPermission();

	/**
	 * 
	 * @Title: findSysPermissionById
	 * @Description: TODO(根据id查询权限)
	 * @param id
	 * @return SysPermission
	 */
	public SysPermission findSysPermissionById(Integer id);

	/**
	 * 
	 * @Title: insertSysPermission
	 * @Description: TODO(添加权限)
	 * @param sysPermission
	 * @return int
	 */
	public int insertSysPermission(SysPermission sysPermission);

	/**
	 * 
	 * @Title: findSysPermissionBypid
	 * @Description: TODO(查询二级菜单栏)
	 * @param parentisd
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findSysMenusBypid(Integer parentisd);

	/**
	 * 
	 * @Title: findSysPermissionByUserId
	 * @Description: TODO(查询指定用户的一级菜单)
	 * @param UserId
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findUserMenus(Integer id);

	/**
	 * 
	 * @Title: findUserPermission
	 * @Description: TODO(获取对应用户的权限)
	 * @param UserId
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findUserPermission(Integer id);

	/**
	 * 
	 * @Title: findAllMenus
	 * @Description: TODO(查询所有一级菜单)
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findAllMenus();

	/**
	 * 
	 * @Title: findMenusByRoleId
	 * @Description: TODO(查询指定角色下的权限信息)
	 * @param id
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findMenusByRoleId(Integer id);
}
