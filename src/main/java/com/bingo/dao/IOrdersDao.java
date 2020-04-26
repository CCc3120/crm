package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.Orders;

@Repository(value = "iOrdersDao")
public interface IOrdersDao {
	/**
	 * 
	 * @Title: findAllOrders
	 * @Description: TODO(查询所有订单)
	 * @return List<Orders>
	 */
	public List<Orders> findAllOrders();

	/**
	 * 
	 * @Title: findOrdersById
	 * @Description: TODO(通过订单id查询订单)
	 * @param id
	 * @return Orders
	 */
	public Orders findOrdersById(Integer id);

	/**
	 * 
	 * @Title: findOrdersbyEmp
	 * @Description: TODO(根据员工查询订单)
	 * @param id
	 * @return List<Orders>
	 */
	public List<Orders> findOrdersbyEmp(Integer id);

	/**
	 * 
	 * @Title: findOrdersByDept
	 * @Description: TODO(根据部门查询订单)
	 * @param id
	 * @return List<Orders>
	 */
	public List<Orders> findOrdersByDept(Integer id);

	/**
	 * 
	 * @Title: insertOrders
	 * @Description: TODO(添加订单)
	 * @param order
	 * @return int
	 */
	public int insertOrders(Orders order);

	/**
	 * 
	 * @Title: updateOrders
	 * @Description: TODO(修改订单)
	 * @param order
	 * @return int
	 */
	public int updateOrders(Orders order);

	/**
	 * 
	 * @Title: deleteOrders
	 * @Description: TODO(删除订单)
	 * @param id
	 * @return int
	 */
	public int deleteOrders(Integer id);
}
