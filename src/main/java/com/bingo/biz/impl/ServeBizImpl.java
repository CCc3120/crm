package com.bingo.biz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bingo.bean.Serve;
import com.bingo.biz.IServeBiz;
import com.bingo.dao.IServeDao;

@Service
public class ServeBizImpl implements IServeBiz {
	@Autowired
	private IServeDao iServeDao;

	@Override
	public Serve findServeById(Integer id) {
		Serve serve = iServeDao.findServeById(id);
		return serve;
	}

	@Override
	public List<Serve> findAllServe(Serve serve) {
		List<Serve> list = iServeDao.findAllServe(serve);
		return list;
	}

	@Override
	public int insertServe(Serve serve) {
		int row = iServeDao.insertServe(serve);
		return row;
	}

	@Override
	public int updateServe(Serve serve) {
		int row = iServeDao.updateServe(serve);
		return row;
	}

}
