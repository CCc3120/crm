package com.bingo.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bingo.bean.Custom;
import com.bingo.bean.Dept;
import com.bingo.bean.Emp;
import com.bingo.bean.Serve;
import com.bingo.biz.IServeBiz;

@Controller
@RequestMapping("/serve")
public class ServeController {
	@Autowired
	private IServeBiz iServeBiz;

	@RequestMapping(value = "/{forName}")
	@RequiresPermissions("service:crud")
	public String servePage(@PathVariable String forName, Model model) {
		model.addAttribute("netpage", forName);
		return "first";
	}

	@RequestMapping(value = "/selectServe")
	@RequiresPermissions("service:crud")
	public @ResponseBody List<Serve> findServe(String stauts) {// 根据状态查询
		Serve serve = new Serve();
		serve.setStauts(stauts);
		List<Serve> list = iServeBiz.findAllServe(serve);
		if(list!=null) {
			for (Serve serve2 : list) {
				if (serve2.getStauts().equals("0")) {
					serve2.setStauts("未分配");
				} else if (serve2.getStauts().equals("1")) {
					serve2.setStauts("已分配");
				} else if (serve2.getStauts().equals("2")) {
					serve2.setStauts("已完成");
				}
			}
		}
		return list;
	}

	@RequestMapping(value = "/insertServe", method = RequestMethod.POST)
	@RequiresPermissions("service:crud")
	public void insertServe(Integer custom_id, String content, HttpServletResponse response) throws IOException {
		Serve serve = new Serve();
		serve.setContent(content);
		serve.setCreateTime(new Date());
		serve.setStauts("0");
		Custom custom = new Custom();
		custom.setId(custom_id);
		serve.setCustom(custom);
		int row = iServeBiz.insertServe(serve);
		if (row > 0) {
			response.getWriter().println("<script>alert('Operation is successful');history.back(-1);</script>");
		} else {
			response.getWriter().println("<script>alert('The operation failure');history.back(-1);</script>");
		}
	}

	@RequestMapping(value = "/findById", method = RequestMethod.GET)
	public @ResponseBody Serve findServeById(Integer id) {
		Serve serve = iServeBiz.findServeById(id);
		if(serve!=null) {
			if (serve.getStauts().equals("0")) {
				serve.setStauts("未分配");
			} else if (serve.getStauts().equals("1")) {
				serve.setStauts("已分配");
			} else if (serve.getStauts().equals("2")) {
				serve.setStauts("已完成");
			}
		}
		return serve;
	}

	@RequestMapping(value = "/distServe", method = RequestMethod.POST)
	@RequiresPermissions("service:dist")
	public void distServe(Integer serveid, Integer deptid, Integer empid, HttpServletResponse response)
			throws IOException {
		Serve serve = new Serve();
		serve.setId(serveid);
		serve.setDistributionTime(new Date());
		Dept dept = new Dept();
		dept.setId(deptid);
		Emp emp = new Emp();
		emp.setId(empid);
		serve.setEmp(emp);
		serve.setDept(dept);
		serve.setStauts("1");
		int row = iServeBiz.updateServe(serve);
		if (row > 0) {
			response.getWriter().println("<script>alert('Operation is successful');history.back(-1);</script>");
		} else {
			response.getWriter().println("<script>alert('The operation failure');history.back(-1);</script>");
		}
	}
	
	@RequestMapping(value="/updateServe",method=RequestMethod.POST)
	@RequiresPermissions("service:dist")
	public void updateServe(String evaluation, Integer serveid, HttpServletResponse response) throws IOException {
		Serve serve = new Serve();
		if(evaluation.equals("1")) {
			serve.setEvaluation("★");
		}else if(evaluation.equals("2")) {
			serve.setEvaluation("★★");
		}else if(evaluation.equals("3")) {
			serve.setEvaluation("★★★");
		}else if(evaluation.equals("4")) {
			serve.setEvaluation("★★★★");
		}else if(evaluation.equals("5")) {
			serve.setEvaluation("★★★★★");
		}
		serve.setId(serveid);
		serve.setEndTime(new Date());
		serve.setStauts("2");
		int row=iServeBiz.updateServe(serve);
		if (row > 0) {
			response.getWriter().println("<script>alert('Operation is successful');history.back(-1);</script>");
		} else {
			response.getWriter().println("<script>alert('The operation failure');history.back(-1);</script>");
		}
	}

}
