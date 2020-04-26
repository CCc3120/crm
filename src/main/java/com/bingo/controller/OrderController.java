package com.bingo.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bingo.bean.Custom;
import com.bingo.bean.Dept;
import com.bingo.bean.Emp;
import com.bingo.bean.Orders;
import com.bingo.bean.Product;
import com.bingo.biz.IOrdersBiz;
import com.bingo.biz.IProductBiz;
import com.bingo.exception.CustomException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/order")
public class OrderController {
	private static Integer proPageNum = 1;// 商品
	private static Integer ordPageNum = 1;// 订单
	@Resource(name = "productBizImpl")
	private IProductBiz ipb;
	@Resource(name = "ordersBizImpl")
	private IOrdersBiz iob;

	@RequestMapping(value = "/gobuy")
	@RequiresPermissions("order:cr")
	public String getAllProduct(Model model, Integer pageNum) {
		if (pageNum == null) {
			pageNum = proPageNum;
		} else {
			proPageNum = pageNum;
		}
		PageHelper.startPage(pageNum, 5);
		PageInfo<Product> pageInfo = new PageInfo<>(ipb.findAllProduct());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("netpage", "prod");
		return "first";
	}

	@RequestMapping(value = "/prodetail", method = RequestMethod.GET)
	@RequiresPermissions("order:cr")
	public @ResponseBody Product getProductDetail(Integer id) {
		Product product = ipb.findProductById(id);
		return product;
	}

	@RequestMapping(value = "/insertOrupdateProduct", method = RequestMethod.POST)
	@RequiresPermissions("order:cr")
	public void insertOrupdateProduct(Product product, Integer id, MultipartFile pictureFile,
			HttpServletResponse response) throws IllegalStateException, IOException {
		// 非空判断 用户上传了图片才执行上传操作
		if (pictureFile != null && pictureFile.getOriginalFilename() != null
				&& pictureFile.getOriginalFilename().length() > 0) {
			// 图片上传地址
			String filePath = "D:\\Develop\\upload_img\\";
			// 上传文件原始名称
			String oldFileName = pictureFile.getOriginalFilename();
			// 给原始文件重新命名 +源文件的后缀
			String newFlieName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
			// 抽象文件
			File file = new File(filePath + newFlieName);
			// 将内存中的文件写入磁盘
			pictureFile.transferTo(file);
			// 将新文件的路径 保存到items对象
			product.setPic(newFlieName);
		}
		if (product.getDiscount() != null) {
			double cost = product.getPrice() * product.getDiscount() / 10;
			product.setCost(cost);
		}
		if (id != null) {
			int row = ipb.updateProduct(product);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='gobuy';</script>");
			} else {
				response.getWriter().println("<script>window.location.href='gobuy';alert('Fail to modify!');</script>");
			}
		} else {
			int row = ipb.insertProduct(product);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='gobuy';</script>");
			} else {
				response.getWriter().println("<script>window.location.href='gobuy';alert('Fail to add!');</script>");
			}
		}
	}

	@RequestMapping(value = "/proDelete")
	@RequiresPermissions("order:cr")
	public void proDelete(Integer id, HttpServletResponse response) throws IOException {
		int row = ipb.deleteProduct(id);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='gobuy';</script>");
		} else {
			response.getWriter()
					.println("<script>window.location.href='gobuy';alert('Try deleted information failed!');</script>");
		}
	}

	@RequestMapping(value = "/insertOrders", method = RequestMethod.POST)
	@RequiresPermissions("order:cr")
	public void insertOrders(Integer oid, Double pay, Integer quantity, Integer empid, Integer pid, Integer deptid,
			Integer customid, HttpServletResponse response) throws CustomException, IOException {
		Emp emp = new Emp();
		emp.setId(empid);
		Dept dept = new Dept();
		dept.setId(deptid);
		Custom custom = new Custom();
		custom.setId(customid);
		if (oid == null) {
			Product product = ipb.findProductById(pid);
			Orders order = new Orders(quantity, pay, new Date(), emp, dept, product, custom);
			int row = iob.insertOrders(order);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='gobuy';</script>");
			} else {
				response.getWriter().println(
						"<script>window.location.href='gobuy';alert('Try deleted information failed!');</script>");
			}
		} else {
			Orders oldOrder = iob.findOrdersById(oid);
			Orders order = new Orders(oid, quantity, pay, new Date(), emp, dept, oldOrder.getProduct(), custom);
			int row = iob.updateOrders(order, oldOrder.getQuantity());
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='getOrders';</script>");
			} else {
				response.getWriter().println(
						"<script>window.location.href='getOrders';alert('Try deleted information failed!');</script>");
			}
		}
	}

	@RequestMapping(value = "/getOrders")
	@RequiresPermissions("order:cud")
	public String getAllOrders(Model model, Integer pageNum) {
		if (pageNum == null) {
			pageNum = ordPageNum;
		} else {
			ordPageNum = pageNum;
		}
		PageHelper.startPage(pageNum, 5);
		PageInfo<Orders> pageInfo = new PageInfo<>(iob.findAllOrders());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("netpage", "order");
		return "first";
	}

	@RequestMapping(value = "/ordDelete")
	@RequiresPermissions("order:cud")
	public void ordDelete(Integer id, HttpServletResponse response) throws IOException {
		int row = iob.deleteOrders(id);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='getOrders';</script>");
		} else {
			response.getWriter().println(
					"<script>window.location.href='getOrders';alert('Try deleted information failed!');</script>");
		}
	}

	@RequestMapping(value = "/ordDetail")
	@RequiresPermissions("order:cud")
	public @ResponseBody Orders getOrdersById(Integer id) {
		Orders order = iob.findOrdersById(id);
		return order;
	}
}
