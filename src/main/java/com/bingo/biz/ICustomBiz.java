package com.bingo.biz;

import java.util.List;

import com.bingo.bean.Custom;

public interface ICustomBiz {
	public List<Custom> findAllCustom();

	public int insertCustom(Custom custom);

	public int updateCustom(Custom custom);

	public int deleteCustom(Integer id);
}
