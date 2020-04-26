package com.bingo.bean;

import java.io.Serializable;

public class Product implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String desc;
	private Double price;
	private Integer stock;
	private Double discount;// 折扣
	private Double cost;// 折后价
	private String pic;// 商品图片名

	public Product() {
		super();
	}

	public Product(String name, String desc, Double price, Integer stock, Double discount, Double cost, String pic) {
		super();
		this.name = name;
		this.desc = desc;
		this.price = price;
		this.stock = stock;
		this.discount = discount;
		this.cost = cost;
		this.pic = pic;
	}

	public Product(Integer id, String name, String desc, Double price, Integer stock, Double discount, Double cost,
			String pic) {
		super();
		this.id = id;
		this.name = name;
		this.desc = desc;
		this.price = price;
		this.stock = stock;
		this.discount = discount;
		this.cost = cost;
		this.pic = pic;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public Double getDiscount() {
		return discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", desc=" + desc + ", price=" + price + ", stock=" + stock
				+ ", discount=" + discount + ", cost=" + cost + ", pic=" + pic + "]";
	}

}
