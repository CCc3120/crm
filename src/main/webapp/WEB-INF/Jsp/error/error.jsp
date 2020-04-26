<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<base href="${basePath}">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function back() {
		window.history.back(-1);
	}
</script>
</head>
<body>
	<h3>您的操作出现错误如下：</h3>
	<br /> ${message}
	<br />
	<a href="user/userexit">退出</a>
	<br />
	<a href="javascript:void(0)" onclick="back()">返回上一层</a>
</body>
</html>