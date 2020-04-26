package com.bingo.dao;
/**
 * 
 * @ClassName: IAnnouncementDao
 * @Description: TODO(公告栏接口)
 * @author 25865
 * @date 2018年12月7日 下午3:03:09   <br/>  
 *       注意：本内容仅限于学习参考，禁止外泄以及用于其他的商业目
 */

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.Announcement;

@Repository(value = "iAnnouncementDao")
public interface IAnnouncementDao {
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
