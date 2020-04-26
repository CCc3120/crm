package com.bingo.bean;

import java.io.Serializable;
import java.util.List;

public class ActiveUser implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String userCode;
	private String password;
	private String realName;// 真实姓名
	private String salt;// 图片

	private List<SysPermission> menus;// 菜单
	private List<SysPermission> permission;// 权限

	public ActiveUser() {
		super();
	}

	public ActiveUser(Integer id, String userCode, String password, String realName, String salt,
			List<SysPermission> menus, List<SysPermission> permission) {
		super();
		this.id = id;
		this.userCode = userCode;
		this.password = password;
		this.realName = realName;
		this.salt = salt;
		this.menus = menus;
		this.permission = permission;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public List<SysPermission> getMenus() {
		return menus;
	}

	public void setMenus(List<SysPermission> menus) {
		this.menus = menus;
	}

	public List<SysPermission> getPermission() {
		return permission;
	}

	public void setPermission(List<SysPermission> permission) {
		this.permission = permission;
	}

	@Override
	public String toString() {
		return "ActiveUser [id=" + id + ", userCode=" + userCode + ", password=" + password + ", realName=" + realName
				+ ", salt=" + salt + ", menus=" + menus + ", permission=" + permission + "]";
	}

}
