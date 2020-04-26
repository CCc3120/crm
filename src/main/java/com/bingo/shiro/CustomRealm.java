package com.bingo.shiro;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.bingo.bean.ActiveUser;
import com.bingo.bean.SysPermission;
import com.bingo.bean.SysUser;
import com.bingo.biz.ISysPermissionBiz;
import com.bingo.biz.ISysUserBiz;

public class CustomRealm extends AuthorizingRealm {
	@Resource(name = "sysUserBizImpl")
	private ISysUserBiz isu;

	@Resource(name = "sysPermissionBizImpl")
	private ISysPermissionBiz isp;

	// 认证
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		// 从token中 获取用户身份信息
		String userCode = (String) token.getPrincipal();
		System.out.println("========进入shiro==========");
		System.out.println(userCode);
		SysUser user = isu.findUserByUserCode(userCode);
		if (user == null) {
			
			return null;
		}
		if(user.getLocked()==0) {
			throw new AuthenticationException("账户信息异常!");
		}
		// 查询菜单栏
		ActiveUser activeUser = new ActiveUser();
		activeUser.setId(user.getId());
		activeUser.setUserCode(user.getUserCode());
		activeUser.setPassword(user.getPassword());
		activeUser.setRealName(user.getRealName());
		activeUser.setSalt(user.getSalt());
		List<SysPermission> menus = isp.findUserMenus(user.getId());// 一级菜单
		for (SysPermission sysPermission : menus) {
			List<SysPermission> Permission = isp.findSysMenusBypid(sysPermission.getParentids());// 二级菜单
			sysPermission.setSysPermission(Permission);
		}
		activeUser.setMenus(menus);
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(activeUser, user.getPassword(), this.getName());
		return info;
	}

	// 授权
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		System.out.println("==============授权");
		ActiveUser activeUser = (ActiveUser) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		List<SysPermission> lists = activeUser.getMenus();
		for (SysPermission permissions : lists) {
			List<SysPermission> list = permissions.getSysPermission();
			for (SysPermission permission : list) {
				if (permission.getPerCode() != null && !permission.getPerCode().equals("")) {
//					System.out.println(permission);
					info.addStringPermission(permission.getPerCode());
				}
			}
		}
		return info;
	}
}
