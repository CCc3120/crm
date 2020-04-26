<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- request.getSchema()可以返回当前页面使用的协议，http 或是 https;

     request.getServerName()可以返回当前页面所在的服务器的名字;

	 request.getServerPort()可以返回当前页面所在的服务器使用的端口,就是80;

	 request.getContextPath()可以返回当前页面所在的应用的名字 -->
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta charset="UTF-8">
<title>CRM首页</title>
<link href="resources/assets/css/bootstrap.css" rel="stylesheet" />
<link href="resources/assets/css/font-awesome.css" rel="stylesheet" />
<link href="resources/assets/css/basic.css" rel="stylesheet" />
<link href="resources/assets/css/custom.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<script type="text/javascript"
	src="resources/bootstrap-3.3.7-dist/jq/jquery-1.8.3.js"></script>
<script type="text/javascript" src="resources/assets/js/bootstrap.js"></script>
<script type="text/javascript"
	src="resources/assets/js/jquery.metisMenu.js"></script>
<script type="text/javascript" src="resources/assets/js/custom.js"></script>
<script type="text/javascript">
	function showTime() {
		nowtime = new Date();
		year = nowtime.getFullYear();
		month = nowtime.getMonth() + 1;
		date = nowtime.getDate();
		document.getElementById("mytime").innerText = year + " 年 " + month
				+ " 月 " + date + "  " + nowtime.toLocaleTimeString();
	}
	setInterval("showTime()", 500);
	//首页跳转方法
	function firstPage() {
		var url = $("#urlPage").val();//获取跳转路径
		var pageNo = parseInt($("#currentPage").val());//获取当前页
		if (parseInt(pageNo) == 1) {
			alert("已经是第一页了!");
		} else {
			window.location.href = url + "?pageNum=1";
		}
	}
	//尾页
	function lastPage() {
		var url = $("#urlPage").val();//获取跳转路径
		var totalPage = $("#totalPage").val();//总页数
		var pageNo = parseInt($("#currentPage").val());//当前页
		if (parseInt(pageNo) == parseInt(totalPage)) {
			alert("已经是最后一页了!!");
		} else {
			window.location.href = url + "?pageNum=" + totalPage;
		}
	}
	//指定页
	function pointPage(pageNo) {
		var url = $("#urlPage").val();//获取跳转路径
		window.location.href = url + "?pageNum=" + pageNo;
	}
</script>
<style type="text/css">
#verticalMiddle {
	vertical-align: middle;
}

.current a {
	font-weight: bold;
	color: #630;
}
</style>
</head>
<body>
	<div id="wrapper">
		<nav class="navbar navbar-default navbar-cls-top " role="navigation"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".sidebar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="user/first">COMPANY NAME</a>
			</div>
			<div class="header-right">
				<div style="margin-top: -10px">
					<span id="mytime"></span>
				</div>
				<div>
					<a href="user/userexit" class="btn btn-success" title="Logout"
						style="margin-left: 160px">退出</a>
				</div>
			</div>
		</nav>
		<!-- /. NAV TOP  -->
		<nav class="navbar-default navbar-side" role="navigation">
			<div class="sidebar-collapse">
				<ul class="nav" id="main-menu">
					<li>
						<div class="user-img-div">
							<%-- <img src="/pic/${activeUser.salt}" class="img-thumbnail" /> --%>
							<div class="inner-text">
								${activeUser.realName} <br /><br /> <small>Welcome back
									&nbsp;&nbsp;!</small>
							</div>
						</div>
					</li>
					<li><a class="active-menu" href="user/first"><i
							class="fa fa-dashboard "></i>首页</a></li>
					<c:set value="${activeUser.menus}" var="act"></c:set>
					<c:forEach items="${act}" var="a">
						<li><a href="#"><i class="fa fa-desktop "></i>${a.name}<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<c:forEach items="${a.sysPermission}" var="sy">
									<li><a href="${sy.url}">${sy.name}</a></li>
								</c:forEach>
							</ul></li>
					</c:forEach>
				</ul>
			</div>
		</nav>
		<div id="page-wrapper">
			<div id="page-inner">
				<c:choose>
					<c:when test="${netpage=='dept'}">
						<%@ include file="dept.jsp"%>
					</c:when>
					<c:when test="${netpage=='emp'}">
						<%@ include file="emp.jsp"%>
					</c:when>
					<c:when test="${netpage=='announ'}">
						<%@ include file="anno.jsp"%>
					</c:when>
					<c:when test="${netpage=='permission'}">
						<%@ include file="permission.jsp"%>
					</c:when>
					<c:when test="${netpage=='prod'}">
						<%@ include file="products.jsp"%>
					</c:when>
					<c:when test="${netpage=='order'}">
						<%@ include file="orders.jsp"%>
					</c:when>
					<c:when test="${netpage=='cust'}">
						<%@ include file="customs.jsp"%>
					</c:when>
					<c:when test="${netpage=='contract'}">
						<%@ include file="contract.jsp"%>
					</c:when>
					<c:when test="${netpage=='manager'}">
						<%@ include file="manager.jsp"%>
					</c:when>
					<c:when test="${netpage=='distribution'}">
						<%@ include file="distribution.jsp"%>
					</c:when>
					<c:otherwise>
						<div class="row">
							<div class="col-md-10 col-md-offset-1">
								<div class="row">
									<div class="col-md-12">
										<div class="panel panel-default">
											<div id="carousel-example" class="carousel slide"
												data-ride="carousel" style="border: 5px solid #000;">
												<div class="carousel-inner">
													<div class="item active">
														<img src="/pic/1.jpg" style="width: 100%" alt="" />
													</div>
													<div class="item">
														<img src="/pic/2.jpg" style="width: 100%" alt="" />
													</div>
													<div class="item">
														<img src="/pic/3.jpg" style="width: 100%" alt="" />
													</div>
												</div>
												<ol class="carousel-indicators">
													<li data-target="#carousel-example" data-slide-to="0"
														class="active"></li>
													<li data-target="#carousel-example" data-slide-to="1"></li>
													<li data-target="#carousel-example" data-slide-to="2"></li>
												</ol>
												<a class="left carousel-control" href="#carousel-example"
													data-slide="prev"> <span
													class="glyphicon glyphicon-chevron-left"></span>
												</a> <a class="right carousel-control" href="#carousel-example"
													data-slide="next"> <span
													class="glyphicon glyphicon-chevron-right"></span>
												</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div id="footer-sec">&copy; 2018 CRM management system</div>
</body>
</html>