package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.SysPermission;
import com.bingo.bean.SysUser;

@Repository(value = "iSysUserDao")
public interface ISysUserDao {
	/**
	 * 
	 * @Title: findAllUser
	 * @Description: TODO(查询所有用户信息)
	 * @return List<SysUser>
	 */
	public List<SysUser> findAllUser();

	/**
	 * 
	 * @Title: findUserByUserCode
	 * @Description: TODO(根据用户名查询)
	 * @param userCode
	 * @return SysUser
	 */
	public SysUser findUserByUserCode(String userCode);

	/**
	 * 
	 * @Title: insertUser
	 * @Description: TODO(添加用户)
	 * @param sysUser
	 * @return int
	 */
	public int insertUser(SysUser sysUser);

	/**
	 * 
	 * @Title: deleteUser
	 * @Description: TODO(删除)
	 * @param id
	 * @return int
	 */
	public int deleteUser(Integer id);

	/**
	 * 
	 * @Title: updateUser
	 * @Description: TODO(修改用户)
	 * @param sysUser
	 * @return int
	 */
	public int updateUser(SysUser sysUser);

	/**
	 * 
	 * @Title: findUserMenus
	 * @Description: TODO(根据用户id查询菜单)
	 * @param id
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findUserMenus(Integer id);

	/**
	 * 
	 * @Title: findUserPermission
	 * @Description: TODO(查询用户权限)
	 * @param id
	 * @return List<SysPermission>
	 */
	public List<SysPermission> findUserPermission(Integer id);
}
