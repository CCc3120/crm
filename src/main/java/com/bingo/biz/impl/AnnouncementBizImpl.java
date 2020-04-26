package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.Announcement;
import com.bingo.biz.IAnnouncementBiz;
import com.bingo.dao.IAnnouncementDao;

@Service(value = "announcementBizImpl")
public class AnnouncementBizImpl implements IAnnouncementBiz {
	@Resource(name = "iAnnouncementDao")
	private IAnnouncementDao iad;

	@Override
	public List<Announcement> findAllAnnouncement() {
		List<Announcement> list = iad.findAllAnnouncement();
		return list;
	}

	@Override
	public Announcement findAnnouncementById(Integer id) {
		Announcement announcement = iad.findAnnouncementById(id);
		return announcement;
	}

	@Override
	public int insertAnnouncement(Announcement anno) {
		int row = iad.insertAnnouncement(anno);
		return row;
	}

	@Override
	public int deleteAnnouncement(Integer id) {
		int row = iad.deleteAnnouncement(id);
		return row;
	}

	@Override
	public int updateAnnouncement(Announcement anno) {
		int row = iad.updateAnnouncement(anno);
		return row;
	}

}
