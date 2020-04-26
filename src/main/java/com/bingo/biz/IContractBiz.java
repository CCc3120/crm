package com.bingo.biz;

import java.util.List;

import com.bingo.bean.Contract;

public interface IContractBiz {
	/**
	 * 
	 * @Title: findAllContract
	 * @Description: TODO(查询所有合同)
	 * @return List<Contract>
	 */
	public List<Contract> findAllContract();

	public Contract findContractById(Integer id);

	public int insertContract(Contract contract);

	public int updateContract(Contract contract);

	public int deleteContract(Integer id);
}
