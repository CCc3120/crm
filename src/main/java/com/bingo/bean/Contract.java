package com.bingo.bean;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 
 * @ClassName: Contract
 * @Description: TODO(合同)
 * @author 25865
 * @date 2018年12月14日 下午4:55:26 <br/>
 *       注意：本内容仅限于学习参考，禁止外泄以及用于其他的商业目
 */
public class Contract implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String title;
	private String context;
	private String aname;
	private String bname;
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;

	public Contract() {
		super();
	}

	public Contract(Integer id, String title, String context, String aname, String bname, Date createTime) {
		super();
		this.id = id;
		this.title = title;
		this.context = context;
		this.aname = aname;
		this.bname = bname;
		this.createTime = createTime;
	}

	public Contract(String title, String context, String aname, String bname, Date createTime) {
		super();
		this.title = title;
		this.context = context;
		this.aname = aname;
		this.bname = bname;
		this.createTime = createTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "Contract [id=" + id + ", title=" + title + ", context=" + context + ", aname=" + aname + ", bname="
				+ bname + ", createTime=" + createTime + "]";
	}

}
