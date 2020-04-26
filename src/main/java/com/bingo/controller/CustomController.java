package com.bingo.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bingo.bean.Custom;
import com.bingo.biz.ICustomBiz;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/custom")
public class CustomController {
	private static int cusPageNum = 1;
	@Resource(name = "customBizImpl")
	private ICustomBiz icb;

	@RequestMapping(value = "/getAllCustom", method = RequestMethod.GET)
	public @ResponseBody List<Custom> getAllCustom() {
		List<Custom> list = icb.findAllCustom();
		return list;
	}

	@RequestMapping(value = "/customs")
	@RequiresPermissions("cus:crud")
	public String customs(Integer pageNum, Model model) {
		if (pageNum == null) {
			pageNum = cusPageNum;
		} else {
			cusPageNum = pageNum;
		}
		PageHelper.startPage(pageNum, 5);
		PageInfo<Custom> pageInfo = new PageInfo<>(icb.findAllCustom());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("netpage", "cust");
		return "first";
	}

	@RequestMapping(value = "/insertCustom", method = RequestMethod.POST)
	@RequiresPermissions("cus:crud")
	public void insertCustom(String name, String sex, String address, Date birthday, HttpServletResponse response)
			throws IOException {
		Custom custom = new Custom();
		custom.setName(name);
		if (sex.equals("1")) {
			custom.setSex("男");
		} else {
			custom.setSex("女");
		}
		custom.setAddress(address);
		custom.setBirthday(birthday);
		int row = icb.insertCustom(custom);
		if (row > 0) {
			response.getWriter().println("<script>alert('Operation is successful');history.back(-1);</script>");
		} else {
			response.getWriter().println("<script>alert('The operation failure');history.back(-1);</script>");
		}
	}

	@RequestMapping(value = "/delCustom", method = RequestMethod.GET)
	@RequiresPermissions("cus:crud")
	public void deleteCustom(Integer id, HttpServletResponse response) throws IOException {
		int row = icb.deleteCustom(id);
		if (row > 0) {
			response.getWriter().println("1");
		} else {
			response.getWriter().println("0");
		}
	}

	@RequestMapping(value = "/updateCustom", method = RequestMethod.POST)
	@RequiresPermissions("cus:crud")
	public void updateCustomMsg(Custom custom, HttpServletResponse response) throws IOException {
		if (custom.getSex().equals("1")) {
			custom.setSex("男");
		} else {
			custom.setSex("女");
		}
		int row = icb.updateCustom(custom);
		if (row > 0) {
			response.getWriter().println("<script>alert('Operation is successful');history.back(-1);</script>");
		} else {
			response.getWriter().println("<script>alert('The operation failure');history.back(-1);</script>");
		}
	}
}
