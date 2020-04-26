package com.bingo.bean;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Serve {
	private Integer id;
	private String content;// 服务内容
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;// 服务创建时间
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private Date distributionTime;// 分配时间
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private Date endTime;// 服务完成时间
	private String evaluation;// 服务评价
	private String stauts;// 服务状态 0为分配 1已分配 2已完成

	private Custom custom;// 服务对象
	private Emp emp;// 完成服务的员工
	private Dept dept;// 完成服务员工所在部门

	public Serve() {
		super();
	}

	public Serve(Integer id, String content, Date createTime, Date distributionTime, Date endTime, String evaluation,
			String stauts, Custom custom, Emp emp, Dept dept) {
		super();
		this.id = id;
		this.content = content;
		this.createTime = createTime;
		this.distributionTime = distributionTime;
		this.endTime = endTime;
		this.evaluation = evaluation;
		this.stauts = stauts;
		this.custom = custom;
		this.emp = emp;
		this.dept = dept;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(String evaluation) {
		this.evaluation = evaluation;
	}

	public Custom getCustom() {
		return custom;
	}

	public void setCustom(Custom custom) {
		this.custom = custom;
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

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public Date getDistributionTime() {
		return distributionTime;
	}

	public void setDistributionTime(Date distributionTime) {
		this.distributionTime = distributionTime;
	}

	@Override
	public String toString() {
		return "Serve [id=" + id + ", content=" + content + ", createTime=" + createTime + ", distributionTime="
				+ distributionTime + ", endTime=" + endTime + ", evaluation=" + evaluation + ", stauts=" + stauts
				+ ", custom=" + custom + ", emp=" + emp + ", dept=" + dept + "]";
	}

}
