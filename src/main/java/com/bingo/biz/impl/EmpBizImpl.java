package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.Emp;
import com.bingo.biz.IEmpBiz;
import com.bingo.dao.IEmpDao;

@Service(value = "empBizImpl")
public class EmpBizImpl implements IEmpBiz {
	@Resource(name = "iEmpDao")
	private IEmpDao ied;

	@Override
	public List<Emp> findEmpByDeptNo(Integer deptno) {
		List<Emp> elist = ied.findEmpByDeptNo(deptno);
		return elist;
	}

	@Override
	public List<Emp> findAllEmp() {
		List<Emp> elist = ied.findAllEmp();
		return elist;
	}

	@Override
	public Emp findEmpById(Integer id) {
		Emp emp = ied.findEmpById(id);
		return emp;
	}

	@Override
	public int updateEmp(Emp emp) {
		int row = ied.updateEmp(emp);
		return row;
	}

	@Override
	public int insertEmp(Emp emp) {
		int row = ied.insertEmp(emp);
		return row;
	}

	@Override
	public int deleteEmp(Integer id) {
		int row = ied.deleteEmp(id);
		return row;
	}

}
