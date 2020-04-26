package com.bingo.controller;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bingo.bean.Contract;
import com.bingo.biz.IContractBiz;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/contract")
public class ContractController {
	private static int conPageNum = 1;

	@Resource(name = "contractBizImpl")
	private IContractBiz icb;

	@RequestMapping("/contracts")
	@RequiresPermissions("con:crud")
	public String findAllContract(Integer pageNum, Model model) {
		if (pageNum == null) {
			pageNum = conPageNum;
		} else {
			conPageNum = pageNum;
		}
		PageHelper.startPage(pageNum, 1);
		PageInfo<Contract> pageInfo = new PageInfo<>(icb.findAllContract());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("netpage", "contract");
		return "first";
	}

	@RequiresPermissions("con:crud")
	@RequestMapping(value = "/insertContract", method = RequestMethod.POST)
	public void insertContract(Contract contract, HttpServletResponse response) throws IOException {
		contract.setCreateTime(new Date());
		int row = icb.insertContract(contract);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='contracts';</script>");
		} else {
			response.getWriter().println("<script>alert('Fail to add!');</script>");
		}
	}
}
