package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.Custom;

@Repository(value = "iCustomDao")
public interface ICustomDao {
	public List<Custom> findAllCustom();

	public int insertCustom(Custom custom);

	public int updateCustom(Custom custom);

	public int deleteCustom(Integer id);
}
