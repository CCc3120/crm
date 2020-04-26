<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<base href="${basePath}">
<head>
<meta charset="UTF-8">
<title>CRM后台管理系统</title>
<link rel="stylesheet" type="text/css" href="../resources/css/style.css" />
<style type="text/css">
body {
	height: 100%;
	background: #16a085;
	overflow: hidden;
}

canvas {
	z-index: -1;
	position: absolute;
}
</style> 
<script type="text/javascript" src="../resources/bootstrap-3.3.7-dist/jq/jquery-1.8.3.js" ></script>
<script type="text/javascript" src="../resources/js/verificationNumbers.js"></script>
<script type="text/javascript" src="../resources/js/Particleground.js"></script>
<script type="text/javascript" src="../resources/js/jqsession.js"></script>
<script type="text/javascript"> 
	$(document).ready(function() {
		//粒子背景特效
		$('body').particleground({
			dotColor : '#5cbdaa',
			lineColor : '#5cbdaa'
		});
		createCode();
	});
</script>
</head>
<body>
	<form action="user/userlogin" method="post">
		<dl class="admin_login">
			<dt>
				<strong>CRM后台管理系统</strong> <em>Management System</em>
			</dt>
			<dd class="user_icon">
				<input type="text" name="username" placeholder="账号" class="login_txtbx" />
			</dd>
			<dd class="pwd_icon">
				<input type="password" name="password" placeholder="密码" class="login_txtbx" />
			</dd>
			<dd class="val_icon">
				<div class="checkcode">
					<input type="text" id="J_codetext" onblur="check()" name="randomcode" placeholder="验证码" maxlength="4" class="login_txtbx">
					<canvas class="J_codeimg" id="myCanvas" onclick="createCode()">对不起，您的浏览器不支持canvas，请下载最新版浏览器!</canvas>
				</div>
				<!-- <input type="button" value="验证码核验" class="ver_btn" onClick="validate();"> -->
			</dd>
			<dd>
				<input type="submit" value="立即登陆" class="submit_btn" />
			</dd>
		</dl>
	</form>
</body>
</html>