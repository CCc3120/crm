package com.bingo.biz.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.SysPermission;
import com.bingo.bean.SysRole;
import com.bingo.bean.SysRolePermission;
import com.bingo.biz.ISysRolePermissionBiz;
import com.bingo.dao.ISysRolePermissionDao;

@Service(value = "sysRolePermissionBizImpl")
public class SysRolePermissionBizImpl implements ISysRolePermissionBiz {
	@Resource(name = "iSysRolePermissionDao")
	private ISysRolePermissionDao isp;

	@Override
	public int deleteSysRolePermission(Integer roleId) {
		int row = isp.deleteSysRolePermission(roleId);
		return row;
	}

	@Override
	public int insertSysRolePermission(String[] perIds, Integer roleId) {
		SysRole sysRole = new SysRole();
		sysRole.setId(roleId);
		int count = 0;
		if (perIds != null && perIds.length > 0) {
			for (String perId : perIds) {
				SysPermission sysPermission = new SysPermission();
				sysPermission.setId(Integer.parseInt(perId));
				int row = isp.insertSysRolePermission(new SysRolePermission(sysRole, sysPermission));
				if (row > 0) {
					count++;
				}
			}
			if (count == perIds.length) {
				count = 1;
			} else {
				count = 0;
			}
		} else {
			count = 1;
		}
		return count;
	}

}
