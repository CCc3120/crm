package com.bingo.bean;

import java.io.Serializable;

/**
 * 
 * @ClassName: SysRole
 * @Description: TODO(权限角色表)
 * @author 25865
 * @date 2018年12月8日 下午12:48:05 <br/>
 *       注意：本内容仅限于学习参考，禁止外泄以及用于其他的商业目
 */
public class SysRole implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String available;

	public SysRole() {
		super();
	}

	public SysRole(String name, String available) {
		super();
		this.name = name;
		this.available = available;
	}

	public SysRole(Integer id, String name, String available) {
		super();
		this.id = id;
		this.name = name;
		this.available = available;
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

	public String getAvailable() {
		return available;
	}

	public void setAvailable(String available) {
		this.available = available;
	}

	@Override
	public String toString() {
		return "SysRole [id=" + id + ", name=" + name + ", available=" + available + "]";
	}

}
