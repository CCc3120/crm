package com.bingo.bean;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Orders implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer quantity;
	private Double pay;
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;
	private Emp emp;
	private Dept dept;
	private Product product;
	private Custom custom;

	public Orders() {
		super();
	}

	public Orders(Integer quantity, Double pay, Date createTime, Emp emp, Dept dept, Product product, Custom custom) {
		super();
		this.quantity = quantity;
		this.pay = pay;
		this.createTime = createTime;
		this.emp = emp;
		this.dept = dept;
		this.product = product;
		this.custom = custom;
	}

	public Orders(Integer id, Integer quantity, Double pay, Date createTime, Emp emp, Dept dept, Product product,
			Custom custom) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.pay = pay;
		this.createTime = createTime;
		this.emp = emp;
		this.dept = dept;
		this.product = product;
		this.custom = custom;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Double getPay() {
		return pay;
	}

	public void setPay(Double pay) {
		this.pay = pay;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Emp getEmp() {
		return emp;
	}

	public void setEmp(Emp emp) {
		this.emp = emp;
	}

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Custom getCustom() {
		return custom;
	}

	public void setCustom(Custom custom) {
		this.custom = custom;
	}

	@Override
	public String toString() {
		return "Orders [id=" + id + ", quantity=" + quantity + ", pay=" + pay + ", createTime=" + createTime + ", emp="
				+ emp + ", dept=" + dept + ", product=" + product + ", custom=" + custom + "]";
	}

}
