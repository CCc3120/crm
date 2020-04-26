package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.Product;
import com.bingo.biz.IProductBiz;
import com.bingo.dao.IProductDao;

@Service(value = "productBizImpl")
public class ProductBizImpl implements IProductBiz {
	@Resource(name = "iProductDao")
	private IProductDao ipd;

	@Override
	public List<Product> findAllProduct() {
		List<Product> list = ipd.findAllProduct();
		return list;
	}

	@Override
	public Product findProductById(Integer id) {
		Product product = ipd.findProductById(id);
		return product;
	}

	@Override
	public int updateProduct(Product product) {
		int row = ipd.updateProduct(product);
		return row;
	}

	@Override
	public int updateProductStock(Integer pid, Integer stock) {
		int row = ipd.updateProductStock(pid, stock);
		return row;
	}

	@Override
	public int insertProduct(Product product) {
		int row = ipd.insertProduct(product);
		return row;
	}

	@Override
	public int deleteProduct(Integer id) {
		int row = ipd.deleteProduct(id);
		return row;
	}

}
