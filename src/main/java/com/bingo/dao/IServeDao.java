package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.Serve;

@Repository
public interface IServeDao {
	// 根据编号查询
	public Serve findServeById(Integer id);

	// 条件查询
	public List<Serve> findAllServe(Serve serve);

	// 添加服务记录
	public int insertServe(Serve serve);

	// 修改/分配服务任务
	public int updateServe(Serve serve);

}
