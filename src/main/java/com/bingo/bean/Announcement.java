package com.bingo.bean;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 
 * @ClassName: Announcement
 * @Description: TODO(公告)
 * @author 25865
 * @date 2018年12月5日 下午7:24:12 <br/>
 *       注意：本内容仅限于学习参考，禁止外泄以及用于其他的商业目
 */
public class Announcement implements Serializable {
	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;// 编号
	private String title;// 标题
	private String content;// 内容
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;// 创建时间

	public Announcement() {
		super();
	}

	public Announcement(String title, String content, Date createTime) {
		super();
		this.title = title;
		this.content = content;
		this.createTime = createTime;
	}

	public Announcement(Integer id, String title, String content, Date createTime) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
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

	@Override
	public String toString() {
		return "Announcement [id=" + id + ", title=" + title + ", content=" + content + ", createTime=" + createTime
				+ "]";
	}

}
