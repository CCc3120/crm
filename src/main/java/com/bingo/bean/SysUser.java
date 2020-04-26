package com.bingo.bean;

import java.io.Serializable;

public class SysUser implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;// 编号
	private String realName;// 真实姓名
	private String userCode;// 账号
	private String password;// 密码
	private String salt;// 图片
	private Integer locked;// 是否锁定 0锁定 1不锁定

	public SysUser() {
		super();
	}

	public SysUser(String realName, String userCode, String password, String salt, Integer locked) {
		super();
		this.realName = realName;
		this.userCode = userCode;
		this.password = password;
		this.salt = salt;
		this.locked = locked;
	}

	public SysUser(Integer id, String realName, String userCode, String password, String salt, Integer locked) {
		super();
		this.id = id;
		this.realName = realName;
		this.userCode = userCode;
		this.password = password;
		this.salt = salt;
		this.locked = locked;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
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

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public Integer getLocked() {
		return locked;
	}

	public void setLocked(Integer locked) {
		this.locked = locked;
	}

	@Override
	public String toString() {
		return "SysUser [id=" + id + ", realName=" + realName + ", userCode=" + userCode + ", password=" + password
				+ ", salt=" + salt + ", locked=" + locked + "]";
	}

}
