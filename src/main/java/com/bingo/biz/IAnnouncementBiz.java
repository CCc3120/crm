package com.bingo.biz;

import java.util.List;

import com.bingo.bean.Announcement;

public interface IAnnouncementBiz {
	/***
	 * 
	 * @Title: findAllAnnouncement
	 * @Description: TODO(查询所有公告)
	 * @return List<Announcement>
	 */
	public List<Announcement> findAllAnnouncement();

	/**
	 * 
	 * @Title: findAnnouncementById
	 * @Description: TODO(根据id查询公告记录)
	 * @param id
	 * @return Announcement
	 */
	public Announcement findAnnouncementById(Integer id);

	/**
	 * 
	 * @Title: insertAnnouncement
	 * @Description: TODO(发布公告)
	 * @param anno
	 * @return int
	 */
	public int insertAnnouncement(Announcement anno);

	/**
	 * 
	 * @Title: deleteAnnouncement
	 * @Description: TODO(删除公告)
	 * @param id
	 * @return int
	 */
	public int deleteAnnouncement(Integer id);

	/**
	 * 
	 * @Title: updateAnnouncement
	 * @Description: TODO(修改公告)
	 * @param anno
	 * @return int
	 */
	public int updateAnnouncement(Announcement anno);
}
