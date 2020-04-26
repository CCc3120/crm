package com.bingo.shiro;

import java.util.LinkedHashMap;

/**
 * shiro过滤器链配置
 * 
 * @ClassName: FilterChainDefinitionsMapBuilder
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @author 25865
 * @date 2020年4月26日 上午12:00:11 <br/>
 *       注意：本内容仅限于学习参考，禁止外泄以及用于其他的商业目
 */
public class FilterChainDefinitionsMapBuilder {

	public LinkedHashMap<String, String> buildFilterChainDefinitionsMap() {
		// 顺序需要注意
		LinkedHashMap<String, String> map = new LinkedHashMap<>();
		// index.jsp = anon
		// user/login = anon
		// user/logout = logout

		// User.jsp = roles[user]
		// admin.jsp = roles[admin]

		// ** = authc
		map.put("/index.jsp", "anon");
		map.put("/user/login", "anon");
		map.put("/user/logout", "logout");
		map.put("/User.jsp", "authc,roles[user]");
		map.put("/admin.jsp", "authc,roles[admin]");
		map.put("/list.jsp", "user");
		map.put("/**", "authc");
		return map;
	}
}
