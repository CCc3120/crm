package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.SysRole;
import com.bingo.biz.ISysRoleBiz;
import com.bingo.dao.ISysRoleDao;

@Service(value = "sysRoleBizImpl")
public class SysRoleBizImpl implements ISysRoleBiz {
	@Resource(name = "iSysRoleDao")
	private ISysRoleDao isd;

	@Override
	public List<SysRole> findAllSysRole() {
		List<SysRole> list = isd.findAllSysRole();
		return list;
	}

	@Override
	public int insertSysRole(SysRole role) {
		int row = isd.insertSysRole(role);
		return row;
	}

	@Override
	public int updateSysRole(SysRole role) {
		int row = isd.updateSysRole(role);
		return row;
	}

	@Override
	public int deleteSysRole(Integer id) {
		int row = isd.deleteSysRole(id);
		return row;
	}

	@Override
	public List<SysRole> findSysRoleByUserId(Integer userId) {
		List<SysRole> list = isd.findSysRoleByUserId(userId);
		return list;
	}

}
