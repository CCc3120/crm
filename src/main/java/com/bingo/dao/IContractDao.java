package com.bingo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bingo.bean.Contract;

@Repository(value = "iContractDao")
public interface IContractDao {
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
