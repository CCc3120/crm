package com.bingo.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class CustomExceptionResolver implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		// 打印 异常堆栈信息
		ex.printStackTrace();
		// 自定义的异常
		CustomException customException = null;
		// 如果抛出的是系统自定义异常则直接转换
		if (ex instanceof CustomException) {
			customException = (CustomException) ex;
		} else if (ex instanceof UnauthorizedException) {
			customException = new CustomException("抱歉,您无权访问！");
		} else {
			// 如果抛出的不是系统自定义异常 则重新构造一个系统错误异常。
			customException = new CustomException("系统错误，请与系统管理员联系！");
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("message", customException.getMessage());
		modelAndView.setViewName("error/error");
		return modelAndView;
	}

}
