package com.bingo.biz.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.SysRole;
import com.bingo.bean.SysUser;
import com.bingo.bean.SysUserRole;
import com.bingo.biz.ISysUserRoleBiz;
import com.bingo.dao.ISysUserRoleDao;

@Service(value = "sysUserRoleBizImpl")
public class SysUserRoleBizImpl implements ISysUserRoleBiz {
	@Resource(name = "iSysUserRoleDao")
	private ISysUserRoleDao isr;

	@Override
	public int insertSysUserRole(String[] roleIds, Integer userId) {
		SysUser sysUser = new SysUser();
		sysUser.setId(userId);
		int count = 0;
		if (roleIds != null && roleIds.length > 0) {
			for (String roleId : roleIds) {
				SysRole sysRole = new SysRole();
				sysRole.setId(Integer.parseInt(roleId));
				int row = isr.insertSysUserRole(new SysUserRole(sysUser, sysRole));
				if (row > 0) {
					count++;
				}
			}
			if (count == roleIds.length) {
				count = 1;
			} else {
				count = 0;
			}
		}else {
			count = 1;
		}
		return count;
	}

	@Override
	public int deleteSysUserRole(Integer userId) {
		int row = isr.deleteSysUserRole(userId);
		return row;
	}

}
