package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.Custom;
import com.bingo.biz.ICustomBiz;
import com.bingo.dao.ICustomDao;

@Service(value = "customBizImpl")
public class CustomBizImpl implements ICustomBiz {
	@Resource(name = "iCustomDao")
	private ICustomDao icd;

	@Override
	public List<Custom> findAllCustom() {
		List<Custom> list = icd.findAllCustom();
		return list;
	}

	@Override
	public int insertCustom(Custom custom) {
		int row = icd.insertCustom(custom);
		return row;
	}

	@Override
	public int updateCustom(Custom custom) {
		int row = icd.updateCustom(custom);
		return row;
	}

	@Override
	public int deleteCustom(Integer id) {
		int row = icd.deleteCustom(id);
		return row;
	}

}
