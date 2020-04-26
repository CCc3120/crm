package com.bingo.test;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bingo.bean.Custom;
import com.bingo.bean.Dept;
import com.bingo.bean.Emp;
import com.bingo.bean.Product;
import com.bingo.bean.Serve;
import com.bingo.bean.SysPermission;
import com.bingo.bean.SysRole;
import com.bingo.bean.SysUser;
import com.bingo.biz.IServeBiz;
import com.bingo.dao.IOrdersDao;
import com.bingo.dao.IProductDao;
import com.bingo.dao.ISysPermissionDao;
import com.bingo.dao.ISysRoleDao;
import com.bingo.dao.ISysRolePermissionDao;
import com.bingo.dao.ISysUserDao;
import com.bingo.dao.ISysUserRoleDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring/appContext_biz.xml")
public class Testd {
	@Autowired
	private ISysUserDao ied;
	@Autowired
	private ISysRoleDao ird;
	@Autowired
	private ISysUserRoleDao isu;
	@Autowired
	private ISysPermissionDao isp;
	@Autowired
	private ISysRolePermissionDao isr;
	@Autowired
	private IOrdersDao iod;
	@Resource(name = "iProductDao")
	private IProductDao ipd;
	@Autowired
	private IServeBiz iServeBiz;

	@Test
	public void test() {
//		SysUser user = new SysUser(12, "aaa", "qwert", "qwert", null, 1);
//		ied.insertUser(user);
//		SysRole role = new SysRole(9, "**", "1");
//		ird.insertSysRole(role);
//		SysUserRole userRole=new SysUserRole(user, role);
//		isp.findAllMenus();
//		isu.deleteSysUserRole(12);
//		SysPermission sysPermission = new SysPermission();
//		sysPermission.setId(3);
//		SysRolePermission rolePermission=new SysRolePermission(role, sysPermission);
//		isr.deleteSysRolePermission(9);
//		ied.findAllUser().forEach(a -> System.out.println(a));
//		isp.findAllPermission().forEach(a -> System.out.println(a));
//		ird.findAllSysRole().forEach(a -> System.out.println(a));
//		iod.findAllOrders().forEach(a -> System.out.println(a));
//		Product product = ipd.findProductById(1);
//		System.out.println(product);
		Serve serve = new Serve();
//		serve.setContent("维修电脑");
//		serve.setCreateTime(new Date());
//		serve.setStauts(0);
//		Custom custom=new Custom();
//		custom.setId(1);
//		serve.setCustom(custom);
//		int row = iServeBiz.insertServe(serve);
//		System.out.println(row);

		serve.setId(1);
//		serve.setDistributionTime(new Date());
		serve.setStauts("2");
		serve.setEndTime(new Date());
		serve.setEvaluation("服务态度好");
//		Emp emp=new Emp();
//		emp.setId(1);
//		Dept dept=new Dept();
//		dept.setId(1);
//		serve.setDept(dept);
//		serve.setEmp(emp);
		iServeBiz.updateServe(serve);
	}

	@Test
	public void test1() {
		iServeBiz.findAllServe(null).forEach(a -> System.out.println(a));
	}

}
