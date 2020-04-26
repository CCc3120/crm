package com.bingo.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bingo.bean.ActiveUser;
import com.bingo.bean.Announcement;
import com.bingo.bean.Dept;
import com.bingo.bean.Emp;
import com.bingo.bean.SysPermission;
import com.bingo.bean.SysRole;
import com.bingo.bean.SysUser;
import com.bingo.biz.IAnnouncementBiz;
import com.bingo.biz.IDeptBiz;
import com.bingo.biz.IEmpBiz;
import com.bingo.biz.ISysPermissionBiz;
import com.bingo.biz.ISysRoleBiz;
import com.bingo.biz.ISysRolePermissionBiz;
import com.bingo.biz.ISysUserBiz;
import com.bingo.biz.ISysUserRoleBiz;
import com.bingo.exception.CustomException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/user")
public class UserController {
	private static int pageNums = 1;// 部门
	private static int empPageNums = 1;// 员工
	private static int annoPageNums = 1;// 公告
	private static int SysUserPageNums = 1;// 管理员
	private static int SysRolePageNums = 1;// 角色
	private static int SysPerPageNums = 1;// 权限
	@Resource(name = "sysUserBizImpl")
	private ISysUserBiz isu;
	@Resource(name = "deptBizImpl")
	private IDeptBiz idb;
	@Resource(name = "empBizImpl")
	private IEmpBiz ieb;
	@Resource(name = "announcementBizImpl")
	private IAnnouncementBiz iab;
	@Resource(name = "sysPermissionBizImpl")
	private ISysPermissionBiz isp;
	@Resource(name = "sysRoleBizImpl")
	private ISysRoleBiz isr;
	@Resource(name = "sysUserRoleBizImpl")
	private ISysUserRoleBiz sur;
	@Resource(name = "sysRolePermissionBizImpl")
	private ISysRolePermissionBiz isrp;

	@RequestMapping(value = "/userlogin")
	public String doLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// shiro在认证过程中出现错误后将异常类路径通过request返回
		String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
		System.out.println("doLogin");
		System.out.println(exceptionClassName);
		// 错误的名称去判断的相关信息
		if (exceptionClassName != null) {
			if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
				throw new CustomException("账号不存在");
			} else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
				throw new CustomException("用户名/密码错误");
			} else if ("randomCodeError".equals(exceptionClassName)) {
				throw new CustomException("验证码错误");
			} else {
				throw new Exception();// 最终在异常处理器生成未知错误
			}
		}
		// 控制器里不做 用户登录验证 交给 shiro 认证去完成
		return "login";
	}

	@RequestMapping(value = "/validateCode", method = RequestMethod.GET)
	public void validateCode(String validateCode, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		HttpSession session = request.getSession();
		System.out.println(validateCode);
		session.setAttribute("validateCode", validateCode);
		response.getWriter().println(1);
	}

	@RequestMapping(value = "/first")
//	@RequiresPermissions("per:crud")
	public String pointPage(HttpSession session) {
		Subject subject = SecurityUtils.getSubject();
		ActiveUser activeUser = (ActiveUser) subject.getPrincipal();
		session.setAttribute("activeUser", activeUser);
		return "first";
	}

	@RequestMapping(value = "/dept")
	@RequiresPermissions("dept:crud")
	public String getAllDept(Model model, Integer pageNum) {
		if (pageNum == null) {
			pageNum = pageNums;
		} else {
			pageNums = pageNum;
		}
		PageHelper.startPage(pageNum, 3);
		PageInfo<Dept> pageInfo = new PageInfo<>(idb.findAllDept());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("netpage", "dept");
		return "first";
	}

	@RequestMapping(value = "/deptDetail", method = RequestMethod.GET)
	@RequiresPermissions("dept:crud")
	public @ResponseBody Dept getDeptDetail(Integer id) throws CustomException {
		Dept dept = idb.findDeptById(id);
		if (dept == null) {
			throw new CustomException("部门信息不存在!");
		}
		return dept;
	}

	@RequestMapping(value = "/insertOrupdate", method = RequestMethod.POST)
	@RequiresPermissions("dept:crud")
	public void insertOrUpdate(Integer id, HttpServletResponse response, Dept dept) throws IOException {
		if (id != null) {
			int row = idb.updateDept(dept);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='dept';alert('修改成功!');</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to modify!');</script>");
			}
		} else {
			int row = idb.insertDept(dept);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='dept';</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to add!');</script>");
			}
		}
	}

	@RequestMapping(value = "/deptDelete", method = RequestMethod.GET)
	@RequiresPermissions("dept:crud")
	public void deleteDept(HttpServletResponse response, Integer id) throws IOException {
		int row = idb.deleteDept(id);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='dept';</script>");
		} else {
			response.getWriter().println("<script>alert('Try deleted information failed!');</script>");
		}
	}

	@RequestMapping(value = "/deptemp", method = RequestMethod.GET)
	@RequiresPermissions("dept:crud")
	public @ResponseBody List<Emp> getDeptEmp(Integer id) {
		List<Emp> list = ieb.findEmpByDeptNo(id);
		return list;
	}

	@RequestMapping(value = "/emp")
	@RequiresPermissions("emp:crud")
	public String getEmp(Model model, Integer pageNum) {
		if (pageNum == null) {
			pageNum = empPageNums;
		} else {
			empPageNums = pageNum;
		}
		PageHelper.startPage(pageNum, 4);
		PageInfo<Emp> pageInfo = new PageInfo<>(ieb.findAllEmp());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("netpage", "emp");
		return "first";
	}

	@RequestMapping(value = "/empDelete", method = RequestMethod.GET)
	@RequiresPermissions("emp:crud")
	public void deleteEmp(HttpServletResponse response, Integer id) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		int row = ieb.deleteEmp(id);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='emp';</script>");
		} else {
			response.getWriter().println("<script>alert('Try deleted information failed!');</script>");
		}
	}

	@RequestMapping(value = "/empDetail", method = RequestMethod.GET)
	@RequiresPermissions("emp:crud")
	public @ResponseBody Emp getEmpDetail(Integer id) throws CustomException {
		Emp emp = ieb.findEmpById(id);
		if (emp == null) {
			throw new CustomException("员工信息不存在!");
		}
		return emp;
	}

	@RequestMapping(value = "/insertOrupdateEmp", method = RequestMethod.POST)
	@RequiresPermissions("emp:crud")
	public void insertOrupdateEmp(Emp emp, Integer id, HttpServletResponse response, Integer deptno)
			throws IOException {
		if (deptno == 0) {
			emp.setDept(null);
		} else {
			Dept dept = idb.findDeptById(deptno);
			emp.setDept(dept);
		}
		if (id != null) {
			int row = ieb.updateEmp(emp);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='emp';</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to modify!');</script>");
			}
		} else {
			int row = ieb.insertEmp(emp);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='emp';</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to add!');</script>");
			}
		}
	}

	@RequestMapping(value = "/alldept", method = RequestMethod.GET)
	@RequiresPermissions("emp:crud")
	public @ResponseBody List<Dept> getAllDept() {
		List<Dept> list = idb.findAllDept();
		return list;
	}

	@RequestMapping(value = "/announ")
	//@RequiresPermissions("anno:crud")
	public String getAllAnnouncement(Model model, Integer pageNum) {
		if (pageNum == null) {
			pageNum = annoPageNums;
		} else {
			annoPageNums = pageNum;
		}
		PageHelper.startPage(pageNum, 4);
		PageInfo<Announcement> pageInfo = new PageInfo<>(iab.findAllAnnouncement());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("netpage", "announ");
		return "first";
	}

	@RequestMapping(value = "/insertAnnoun", method = RequestMethod.POST)
	@RequiresPermissions("anno:crud")
	public void addAnnouncement(HttpServletResponse response, Announcement announcement) throws IOException {
		announcement.setCreateTime(new Date());
		int row = iab.insertAnnouncement(announcement);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='announ';</script>");
		} else {
			response.getWriter().println("<script>alert('Fail to add!');</script>");
		}
	}

	@RequestMapping(value = "/annoDelete", method = RequestMethod.GET)
	@RequiresPermissions("anno:crud")
	public void deleteAnnouncement(HttpServletResponse response, Integer id) throws IOException {
		int row = iab.deleteAnnouncement(id);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='announ';</script>");
		} else {
			response.getWriter().println("<script>alert('Try deleted information failed!');</script>");
		}
	}

	@RequestMapping(value = "/per")
	@RequiresPermissions("per:crud")
	public String perManagement(Model model, Integer pageNumUser, Integer pageNumRole, Integer pageNumPer) {
		if (pageNumUser == null) {
			pageNumUser = SysUserPageNums;
		} else {
			SysUserPageNums = pageNumUser;
		}
		if (pageNumRole == null) {
			pageNumRole = SysRolePageNums;
		} else {
			SysRolePageNums = pageNumRole;
		}
		if (pageNumPer == null) {
			pageNumPer = SysPerPageNums;
		} else {
			SysPerPageNums = pageNumPer;
		}
		PageHelper.startPage(pageNumUser, 4);
		PageInfo<SysUser> pageInfoUser = new PageInfo<>(isu.findAllUser());
		model.addAttribute("pageInfoUser", pageInfoUser);
		PageHelper.startPage(pageNumRole, 4);
		PageInfo<SysRole> pageInfoRole = new PageInfo<>(isr.findAllSysRole());
		model.addAttribute("pageInfoRole", pageInfoRole);
		PageHelper.startPage(pageNumPer, 4);
		PageInfo<SysPermission> pageInfoPer = new PageInfo<>(isp.findAllMenus());
		model.addAttribute("pageInfoPer", pageInfoPer);
		model.addAttribute("netpage", "permission");
		return "first";
	}

	@RequestMapping(value = "/haveRole")
	@RequiresPermissions("per:crud")
	public @ResponseBody List<SysRole> haveRole(Integer id) {
		List<SysRole> list = isr.findSysRoleByUserId(id);
		return list;
	}

	@RequestMapping(value = "/allRole")
	@RequiresPermissions("per:crud")
	public @ResponseBody List<SysRole> allRole() {
		List<SysRole> list = isr.findAllSysRole();
		return list;
	}

	@RequestMapping(value = "/updateUserRole", method = RequestMethod.POST)
	@RequiresPermissions("per:crud")
	public void updateUserRole(HttpServletResponse response, Integer userId, String[] roleIds) throws IOException {
		sur.deleteSysUserRole(userId);
		int row = 0;
		try {
			row = sur.insertSysUserRole(roleIds, userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='per';</script>");
		} else {
			response.getWriter().println("<script>alert('Fail to modify!');</script>");
		}
	}

	@RequestMapping(value = "/userDetali", method = RequestMethod.GET)
	@RequiresPermissions("per:crud")
	public @ResponseBody SysUser getSysUser(String userCode) {
		SysUser sysUser = isu.findUserByUserCode(userCode);
		return sysUser;
	}

	@RequestMapping(value = "/insertOrUpdateSysUser", method = RequestMethod.POST)
	@RequiresPermissions("per:crud")
	public void insertOrUpdateSysUser(SysUser user, Integer id, HttpServletResponse response, MultipartFile pictureFile)
			throws IllegalStateException, IOException {
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
			user.setSalt(newFlieName);
		}
		if (id == null) {
			int row = isu.insertUser(user);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='per';</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to add!');</script>");
			}
		} else {
			int row = isu.updateUser(user);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='per';</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to modify!');</script>");
			}
		}
	}

	@RequestMapping(value = "/userDelete")
	@RequiresPermissions("per:crud")
	public void userDelete(Integer id, HttpServletResponse response) throws IOException {
		int row = isu.deleteUser(id);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='per';</script>");
		} else {
			response.getWriter().println("<script>alert('Try deleted information failed!');</script>");
		}
	}

	@RequestMapping(value = "/userActivation")
	@RequiresPermissions("per:crud")
	public void userActivation(HttpServletResponse response, String userCode) throws IOException {
		SysUser sysUser = isu.findUserByUserCode(userCode);
		if (sysUser.getLocked() == null || sysUser.getLocked() != 1) {// 激活
			sysUser.setLocked(1);
			int row = isu.updateUser(sysUser);
			if (row > 0) {
				response.getWriter().println(1);
			} else {
				response.getWriter().println(0);
			}
		} else {// 锁定
			sysUser.setLocked(0);
			int row = isu.updateUser(sysUser);
			if (row > 0) {
				response.getWriter().println(1);
			} else {
				response.getWriter().println(0);
			}
		}
	}

	@RequestMapping(value = "/havePer")
	@RequiresPermissions("per:crud")
	public @ResponseBody List<SysPermission> havePer(Integer id) {
		List<SysPermission> list = isp.findMenusByRoleId(id);
		return list;
	}

	@RequestMapping(value = "/allPer")
	@RequiresPermissions("per:crud")
	public @ResponseBody List<SysPermission> allPer() {
		List<SysPermission> list = isp.findAllMenus();
		return list;
	}

	@RequestMapping(value = "/updateRolePer", method = RequestMethod.POST)
	@RequiresPermissions("per:crud")
	private void updateRolePer(HttpServletResponse response, Integer roleId, String[] roleIds) throws IOException {
		isrp.deleteSysRolePermission(roleId);
		int row = 0;
		try {
			row = isrp.insertSysRolePermission(roleIds, roleId);
		} catch (Exception e) {
		}
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='per';</script>");
		} else {
			response.getWriter().println("<script>alert('Fail to modify!');</script>");
		}
	}

	@RequestMapping(value = "/insertOrUpdateSysRole", method = RequestMethod.POST)
	@RequiresPermissions("per:crud")
	public void insertOrUpdateSysRole(SysRole role, Integer id, HttpServletResponse response) throws IOException {
		if (id != null) {
			int row = isr.updateSysRole(role);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='per';</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to modify!');</script>");
			}
		} else {
			int row = isr.insertSysRole(role);
			if (row > 0) {
				response.getWriter().println("<script>window.location.href='per';</script>");
			} else {
				response.getWriter().println("<script>alert('Fail to add!');</script>");
			}
		}
	}

	@RequestMapping(value = "/roleDelete")
	@RequiresPermissions("per:crud")
	public void deleteRole(Integer id, HttpServletResponse response) throws IOException {
		int row = isr.deleteSysRole(id);
		if (row > 0) {
			response.getWriter().println("<script>window.location.href='per';</script>");
		} else {
			response.getWriter().println("<script>alert('Try deleted information failed!');</script>");
		}
	}
}
