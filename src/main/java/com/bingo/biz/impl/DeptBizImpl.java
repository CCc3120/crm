package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.Dept;
import com.bingo.biz.IDeptBiz;
import com.bingo.dao.IDeptDao;

@Service(value = "deptBizImpl")
public class DeptBizImpl implements IDeptBiz {
	@Resource(name = "iDeptDao")
	private IDeptDao idd;

	@Override
	public List<Dept> findAllDept() {
		List<Dept> list = idd.findAllDept();
		return list;
	}

	@Override
	public Dept findDeptById(Integer id) {
		Dept dept = idd.findDeptById(id);
		return dept;
	}

	@Override
	public int insertDept(Dept dept) {
		int row = idd.insertDept(dept);
		return row;
	}

	@Override
	public int deleteDept(Integer id) {
		int row = idd.deleteDept(id);
		return row;
	}

	@Override
	public int updateDept(Dept dept) {
		int row = idd.updateDept(dept);
		return row;
	}

}
