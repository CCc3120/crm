package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.Orders;
import com.bingo.biz.IOrdersBiz;
import com.bingo.dao.IOrdersDao;
import com.bingo.dao.IProductDao;
import com.bingo.exception.CustomException;

@Service(value = "ordersBizImpl")
public class OrdersBizImpl implements IOrdersBiz {
	@Resource(name = "iOrdersDao")
	private IOrdersDao iod;
	@Resource(name = "iProductDao")
	private IProductDao ipd;

	@Override
	public List<Orders> findAllOrders() {
		List<Orders> list = iod.findAllOrders();
		return list;
	}

	@Override
	public List<Orders> findOrdersbyEmp(Integer id) {
		List<Orders> list = iod.findOrdersbyEmp(id);
		return list;
	}

	@Override
	public List<Orders> findOrdersByDept(Integer id) {
		List<Orders> list = iod.findOrdersByDept(id);
		return list;
	}

	@Override
	public int insertOrders(Orders order) throws CustomException {
		int row = 0;
		if (order.getProduct().getStock() - order.getQuantity() >= 0) {
			row = iod.insertOrders(order);
			if (row > 0) {
				ipd.updateProductStock(order.getProduct().getId(), order.getProduct().getStock() - order.getQuantity());
			}
		} else {
			throw new CustomException("购买数量错误!");
		}
		return row;
	}

	@Override
	public int updateOrders(Orders order, Integer num) throws CustomException {
		int row = 0;
		int stock = num + order.getProduct().getStock() - order.getQuantity();
		if (stock >= 0) {
			row = iod.updateOrders(order);
			if (row > 0) {
				ipd.updateProductStock(order.getProduct().getId(), stock);
			}
		} else {
			throw new CustomException("购买数量错误!");
		}
		return row;
	}

	@Override
	public int deleteOrders(Integer id) {
		int row = iod.deleteOrders(id);
		return row;
	}

	@Override
	public Orders findOrdersById(Integer id) {
		Orders orders = iod.findOrdersById(id);
		return orders;
	}

}
