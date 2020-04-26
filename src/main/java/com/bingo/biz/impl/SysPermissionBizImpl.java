package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.SysPermission;
import com.bingo.biz.ISysPermissionBiz;
import com.bingo.dao.ISysPermissionDao;

@Service(value = "sysPermissionBizImpl")
public class SysPermissionBizImpl implements ISysPermissionBiz {
	@Resource(name = "iSysPermissionDao")
	private ISysPermissionDao isp;

	@Override
	public List<SysPermission> findAllPermission() {
		List<SysPermission> list = isp.findAllPermission();
		return list;
	}

	@Override
	public int insertSysPermission(SysPermission sysPermission) {
		int row = isp.insertSysPermission(sysPermission);
		return row;
	}

	@Override
	public List<SysPermission> findSysMenusBypid(Integer parentisd) {
		List<SysPermission> list = isp.findSysMenusBypid(parentisd);
		return list;
	}

	@Override
	public List<SysPermission> findUserMenus(Integer id) {
		List<SysPermission> list = isp.findUserMenus(id);
		return list;
	}

	@Override
	public List<SysPermission> findUserPermission(Integer id) {
		List<SysPermission> list = isp.findUserPermission(id);
		return list;
	}

	@Override
	public List<SysPermission> findAllMenus() {
		List<SysPermission> list = isp.findAllMenus();
		return list;
	}

	@Override
	public SysPermission findSysPermissionById(Integer id) {
		SysPermission sysPermission = isp.findSysPermissionById(id);
		return sysPermission;
	}

	@Override
	public List<SysPermission> findMenusByRoleId(Integer id) {
		List<SysPermission> list = isp.findMenusByRoleId(id);
		return list;
	}

}
