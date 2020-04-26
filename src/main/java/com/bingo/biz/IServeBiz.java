package com.bingo.biz;

import java.util.List;

import com.bingo.bean.Serve;

public interface IServeBiz {
		//根据编号查询
		public Serve findServeById(Integer id);
		//条件查询
		public List<Serve> findAllServe(Serve serve);
		//添加服务记录
		public int insertServe(Serve serve);
		//修改/分配服务任务
		public int updateServe(Serve serve);
}
