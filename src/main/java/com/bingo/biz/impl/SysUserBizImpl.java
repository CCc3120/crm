package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.SysUser;
import com.bingo.biz.ISysUserBiz;
import com.bingo.dao.ISysUserDao;

@Service(value = "sysUserBizImpl")
public class SysUserBizImpl implements ISysUserBiz {
	@Resource(name = "iSysUserDao")
	private ISysUserDao isu;

	@Override
	public List<SysUser> findAllUser() {
		List<SysUser> list = isu.findAllUser();
		return list;
	}

	@Override
	public SysUser findUserByUserCode(String userCode) {
		SysUser sysUser = isu.findUserByUserCode(userCode);
		return sysUser;
	}

	@Override
	public int insertUser(SysUser sysUser) {
		int row = isu.insertUser(sysUser);
		return row;
	}

	@Override
	public int deleteUser(Integer id) {
		int row = isu.deleteUser(id);
		return row;
	}

	@Override
	public int updateUser(SysUser sysUser) {
		int row = isu.updateUser(sysUser);
		return row;
	}

}
