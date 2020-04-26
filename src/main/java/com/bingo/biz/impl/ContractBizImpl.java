package com.bingo.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bingo.bean.Contract;
import com.bingo.biz.IContractBiz;
import com.bingo.dao.IContractDao;

@Service(value = "contractBizImpl")
public class ContractBizImpl implements IContractBiz {
	@Resource(name = "iContractDao")
	private IContractDao icd;

	@Override
	public List<Contract> findAllContract() {
		List<Contract> list = icd.findAllContract();
		return list;
	}

	@Override
	public Contract findContractById(Integer id) {
		Contract contract = icd.findContractById(id);
		return contract;
	}

	@Override
	public int insertContract(Contract contract) {
		int row = icd.insertContract(contract);
		return row;
	}

	@Override
	public int updateContract(Contract contract) {
		int row = icd.updateContract(contract);
		return row;
	}

	@Override
	public int deleteContract(Integer id) {
		int row = icd.deleteContract(id);
		return row;
	}

}
