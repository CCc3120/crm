package com.bingo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bingo.bean.Product;

@Repository(value = "iProductDao")
public interface IProductDao {
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
	public int updateProductStock(@Param("pid") Integer pid, @Param("stock") Integer stock);

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
