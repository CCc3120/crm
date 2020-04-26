package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.Dept;

@Repository(value = "iDeptDao")
public interface IDeptDao {
	/**
	 * 
	 * @Title: findAllDept
	 * @Description: TODO(查询所有部门)
	 * @return List<Dept>
	 */
	public List<Dept> findAllDept();

	/**
	 * 
	 * @Title: findDeptById
	 * @Description: TODO(根据编号查询)
	 * @param id
	 * @return Dept
	 */
	public Dept findDeptById(Integer id);

	/**
	 * 
	 * @Title: insertDept
	 * @Description: TODO(添加部门信息)
	 * @param dept
	 * @return int
	 */
	public int insertDept(Dept dept);

	/**
	 * 
	 * @Title: deleteDept
	 * @Description: TODO(根据id删除部门)
	 * @param dept
	 * @return int
	 */
	public int deleteDept(Integer id);

	/**
	 * 
	 * @Title: updateDept
	 * @Description: TODO(修改部门信息)
	 * @param dept
	 * @return int
	 */
	public int updateDept(Dept dept);
}
