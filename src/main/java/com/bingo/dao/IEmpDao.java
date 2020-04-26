package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.Emp;

@Repository(value = "iEmpDao")
public interface IEmpDao {
	/**
	 * 
	 * @Title: getEmpByDeptNo
	 * @Description: TODO(查询指定部门下的所有员工)
	 * @param deptno
	 * @return List<Emp>
	 */
	public List<Emp> findEmpByDeptNo(Integer deptno);

	/**
	 * 
	 * @Title: findAllEmp
	 * @Description: TODO(查询所有员工)
	 * @return List<Emp>
	 */
	public List<Emp> findAllEmp();

	/**
	 * 
	 * @Title: findEmpById
	 * @Description: TODO(根据id查询员工)
	 * @param id
	 * @return Emp
	 */
	public Emp findEmpById(Integer id);

	/**
	 * 
	 * @Title: updateEmp
	 * @Description: TODO(修改员工信息)
	 * @param emp
	 * @return int
	 */
	public int updateEmp(Emp emp);

	/**
	 * 
	 * @Title: insertEmp
	 * @Description: TODO(添加员工信息)
	 * @param emp
	 * @return int
	 */
	public int insertEmp(Emp emp);

	/**
	 * 
	 * @Title: deleteEmp
	 * @Description: TODO(删除员工信息)
	 * @param id
	 * @return int
	 */
	public int deleteEmp(Integer id);

}
