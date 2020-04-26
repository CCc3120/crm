package com.bingo.biz;

import java.util.List;

import com.bingo.bean.Product;

public interface IProductBiz {
	/**
	 * 
	 * @Title: findAllProduct
	 * @Description: TODO(查询所有商品信息)
	 * @return List<Product>
	 */
	public List<Product> findAllProduct();

	/**
	 * 
	 * @Title: findProductById
	 * @Description: TODO(根据商品id查询商品信息)
	 * @param id
	 * @return Product
	 */
	public Product findProductById(Integer id);

	/**
	 * 
	 * @Title: updateProduct
	 * @Description: TODO(修改商品信息)
	 * @param product
	 * @return int
	 */
	public int updateProduct(Product product);

	/**
	 * 
	 * @Title: updateProductStock
	 * @Description: TODO(修改商品库存)
	 * @param pid
	 * @param stock
	 * @return int
	 */
	public int updateProductStock(Integer pid, Integer stock);

	/**
	 * 
	 * @Title: insertProduct
	 * @Description: TODO(添加商品信息)
	 * @param product
	 * @return int
	 */
	public int insertProduct(Product product);

	/**
	 * 
	 * @Title: deleteProduct
	 * @Description: TODO(删除商品)
	 * @param id
	 * @return int
	 */
	public int deleteProduct(Integer id);
}
