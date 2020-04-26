<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	//确认框
	function sure() {
		if(confirm("Are you sure to modify?")){
			return true;
		}else{
			return false;
		}
	}
	/* 管理员 */
	
	//首页方法
	function userfirstPage() {
		var url = $("#userUrlPage").val();//获取跳转路径
		var pageNo = parseInt($("#userCurrentPage").val());//获取当前页
		if (parseInt(pageNo) == 1) {
			alert("已经是第一页了!");
		} else {
			window.location.href = url + "?pageNumUser=1";
		}
	}
	//尾页
	function userlastPage() {
		var url = $("#userUrlPage").val();//获取跳转路径
		var totalPage = $("#userTotalPage").val();//总页数
		var pageNo = parseInt($("#userCurrentPage").val());//当前页
		if (parseInt(pageNo) == parseInt(totalPage)) {
			alert("已经是最后一页了!!");
		} else {
			window.location.href = url + "?pageNumUser=" + totalPage;
		}
	}
	//指定页
	function userPointPage(pageNo) {
		var url = $("#userUrlPage").val();//获取跳转路径
		window.location.href = url + "?pageNumUser=" + pageNo;
	}
	//指定管理员拥有的角色信息
	function userDetail(obj) {
		 /*  data-toggle="modal"
		 data-target="#myModalUser" */
		 $("#myModalUser .modal-body table tr:eq(0) td:eq(1)").text("");
		 $("#myModalUser .modal-body table tr:eq(1) td:eq(1)").html("");
		 $("#myModalUser .modal-body table tr:eq(2) td:eq(1)").html("");
		 var id=$(obj).parents("tr").children("td:eq(0)").text();//用户编号
		 var userName=$(obj).parents("tr").children("td:eq(2)").text();;//用户名
		 var haveRole="";//已拥有的角色
		 var allRole="";//所有角色
		 $.ajax({
				url:"user/haveRole",
				type:"GET",
				async:false, //同步
				data:"id="+id,
				dataType:"json",//响应的类型
				success:function(data){
					if(data.length>0){
						$.each(data,function(i,item){
							haveRole+="<input disabled='disabled' value='"+item.id+"' type='checkbox' checked=ture >"+item.name;
						});
					}else{
						haveRole="该管理员未分配角色!";
					}
				}
		 });
		 $.ajax({
				url:"user/allRole",
				type:"GET",
				async:false, //同步
				dataType:"json",//响应的类型
				success:function(data){
					if(data.length>0){
						$.each(data,function(i,item){
							allRole+="<input name='roleIds' value='"+item.id+"' type='checkbox'>"+item.name;
						});
					}
				}
		 });
		 $("#myModalUser #userId").val(id);
		 $("#myModalUser .modal-body table tr:eq(0) td:eq(1)").text(userName);
		 $("#myModalUser .modal-body table tr:eq(1) td:eq(1)").html(haveRole);
		 $("#myModalUser .modal-body table tr:eq(2) td:eq(1)").html(allRole);
		 $("#myModalUser").modal("show");
	} 
	//修改管理员信息
	function userUpdate(userCode) {
		 $.ajax({
				url:"user/userDetali",
				data:"userCode="+userCode,
				type:"GET",
				async:false, //同步
				dataType:"json",//响应的类型
				success:function(data){
					$("#myModalUserIU .modal-body table tr:gt(0)").remove();
					var $user="<tr><td id='verticalMiddle'><input style='width:50px' name='id' type='text' value='"+data.id+"' readonly='readonly'></td><td id='verticalMiddle'><input style='width:80px' name='realName' type='text' value='"+data.realName+"' ></td><td id='verticalMiddle'><input style='width:80px' name='userCode' type='text' value='"+data.userCode+"' ></td><td id='verticalMiddle'><input style='width:80px' name='password' type='text' value='"+data.password+"' ></td><td id='verticalMiddle'><img style='display: inline-block; width: 50px; height: 50px;' alt='Picture' src='/pic/"+data.salt+"'><input style='width: 75px;display: inline-block;' type='file' name='pictureFile'></td></tr>";
					$("#myModalUserIU .modal-body table tr:eq(0)").after($user);
				}
		 });
		 $("#myModalUserIU").modal("show");
	}
	//添加管理员信息
	function insertSysUser() {
		$("#myModalUserIU .modal-body table tr:gt(0)").remove();
		var $user="<tr><td id='verticalMiddle'></td><td id='verticalMiddle'><input style='width:80px' name='realName' type='text' value=''></td><td id='verticalMiddle'><input style='width:80px' name='userCode' type='text' value='' ></td><td id='verticalMiddle'><input style='width:80px' name='password' type='text' value='' ></td><td id='verticalMiddle'><input style='width: 75px;display: inline-block;' type='file' name='pictureFile'></td></tr>";
		$("#myModalUserIU .modal-body table tr:eq(0)").after($user);
		$("#myModalUserIU").modal("show");
	}
	//删除管理员信息
	function userDelete(id) {
		if(confirm("Are you sure to delete it?")){
			window.location.href="user/userDelete?id="+id;
		}
	}
	//激活账号
	function userActivation(obj) {
		var userCode=$(obj).parents("tr").children("td:eq(2)").text();//用户名
		$.ajax({
				url:"user/userActivation",
				data:"userCode="+userCode,
				type:"GET",
				async:false, //同步
				dataType:"text",//响应的类型
				success:function(data){
					if(data==0){
						alert("操作失败!");
					}else if(data==1){
						alert("操作成功!");	
						var locked=$(obj).parents("tr").children("td:eq(4)").text();
						if(locked!="可用"){
							$(obj).parents("tr").children("td:eq(4)").text("可用");
							$(obj).text("锁定");
						}else{
							$(obj).parents("tr").children("td:eq(4)").text("不可用");
							$(obj).text("激活");
						}
					}
				}
		 });
	}
	
	/* 角色 */
	//首页方法
	function rolefirstPage() {
		var url = $("#roleUrlPage").val();//获取跳转路径
		var pageNo = parseInt($("#roleCurrentPage").val());//获取当前页
		if (parseInt(pageNo) == 1) {
			alert("已经是第一页了!");
		} else {
			window.location.href = url + "?pageNumRole=1";
		}
	}
	//尾页
	function rolelastPage() {
		var url = $("#roleUrlPage").val();//获取跳转路径
		var totalPage = $("#roleTotalPage").val();//总页数
		var pageNo = parseInt($("#roleCurrentPage").val());//当前页
		if (parseInt(pageNo) == parseInt(totalPage)) {
			alert("已经是最后一页了!!");
		} else {
			window.location.href = url + "?pageNumRole=" + totalPage;
		}
	}
	//指定页
	function rolePointPage(pageNo) {
		var url = $("#roleUrlPage").val();//获取跳转路径
		window.location.href = url + "?pageNumRole=" + pageNo;
	}
	//角色下的权限
	function roleDetail(obj) {
		$("#myModalRole .modal-body table tr:eq(0) td:eq(1)").text("");
		$("#myModalRole .modal-body table tr:eq(1) td:eq(1)").html("");
		$("#myModalRole .modal-body table tr:eq(2) td:eq(1)").html("");
		var id=$(obj).parents("tr").children("td:eq(0)").text();//角色编号;
		var perName=$(obj).parents("tr").children("td:eq(1)").text();//角色名称;
		var havaPer="";//已拥有的权限
		var allPer="";//所有权限
		$.ajax({
				url:"user/havePer",
				type:"GET",
				async:false, //同步
				data:"id="+id,
				dataType:"json",//响应的类型
				success:function(data){
					if(data.length>0){
						$.each(data,function(i,item){
							havaPer+="<input disabled='disabled' value='"+item.id+"' type='checkbox' checked=ture >"+item.name;
						});
					}else{
						havaPer="该角色未分配权限!";
					}
				}
		});
		$.ajax({
				url:"user/allPer",
				type:"GET",
				async:false, //同步
				dataType:"json",//响应的类型
				success:function(data){
					if(data.length>0){
						$.each(data,function(i,item){
							allPer+="<input name='roleIds' value='"+item.id+"' type='checkbox'>"+item.name;
						});
					}
				}
		});
		$("#myModalRole #roleId").val(id);
	    $("#myModalRole .modal-body table tr:eq(0) td:eq(1)").text(perName);
	    $("#myModalRole .modal-body table tr:eq(1) td:eq(1)").html(havaPer);
	    $("#myModalRole .modal-body table tr:eq(2) td:eq(1)").html(allPer);
	    $("#myModalRole").modal("show");
	}
	//修改角色信息
	function roleUpdate(obj) {
		var id=$(obj).parents("tr").children("td:eq(0)").text();
		var name=$(obj).parents("tr").children("td:eq(1)").text();
		var available=$(obj).parents("tr").children("td:eq(2)").text();
		$("#myModalRoleIU .modal-body table tr:gt(0)").remove();
		var $role="<tr><td id='verticalMiddle'><input style='width:50px' name='id' type='text' value='"+id+"' readonly='readonly'></td><td id='verticalMiddle'><input style='width:80px' name='name' type='text' value='"+name+"' ></td><td><select name='available'>";
		if(available=="可用"){
			$role+="<option value='1' selected='selected'>可用</option><option value='0'>不可用</option>";
		}else{
			$role+="<option value='0' selected='selected'>不可用</option><option value='1'>可用</option>";
		}
		$role+="</select></td></tr>";
		$("#myModalRoleIU .modal-body table tr:eq(0)").after($role);
		$("#myModalRoleIU").modal("show");
	}
	//添加角色信息
	function insertRole() {
		$("#myModalRoleIU .modal-body table tr:gt(0)").remove();
		var $role="<tr><td id='verticalMiddle'></td><td id='verticalMiddle'><input style='width:80px' name='name' type='text' value='' ></td><td><select name='available'><option value='2' selected='selected'>请选择</option><option value='1'>可用</option><option value='0'>不可用</option></select></td></tr>";
		$("#myModalRoleIU .modal-body table tr:eq(0)").after($role);
		$("#myModalRoleIU").modal("show");
	}
	//删除角色
	function roleDelete(id) {
		if(confirm("Are you sure to delete it?")){
			window.location.href="user/roleDelete?id="+id;
		}
	}
	/* 权限 */
	//首页方法
	function perfirstPage() {
		var url = $("#perUrlPage").val();//获取跳转路径
		var pageNo = parseInt($("#perCurrentPage").val());//获取当前页
		if (parseInt(pageNo) == 1) {
			alert("已经是第一页了!");
		} else {
			window.location.href = url + "?pageNumPer=1";
		}
	}
	//尾页
	function perlastPage() {
		var url = $("#perUrlPage").val();//获取跳转路径
		var totalPage = $("#perTotalPage").val();//总页数
		var pageNo = parseInt($("#perCurrentPage").val());//当前页
		if (parseInt(pageNo) == parseInt(totalPage)) {
			alert("已经是最后一页了!");
		} else {
			window.location.href = url + "?pageNumPer=" + totalPage;
		}
	}
	//指定页
	function perPointPage(pageNo) {
		var url = $("#perUrlPage").val();//获取跳转路径
		window.location.href = url + "?pageNumPer=" + pageNo;
	}
	
</script>
<div class="row">
	<!-- 管理员表 -->
	<div class="col-md-12">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px">管理员信息</caption>
			<tr>
				<th class="text-center">编号</th>
				<th class="text-center">真实姓名</th>
				<th class="text-center">账号</th>
				<th class="text-center">密码</th>
				<th class="text-center">账户是否可用</th>
				<th class="text-center">头像</th>
				<th class="text-center">操作</th>
			</tr>
			<c:forEach items="${pageInfoUser.list}" var="user">
				<tr>
					<td id="verticalMiddle">${user.id}</td>
					<td id="verticalMiddle">${user.realName}</td>
					<td id="verticalMiddle">${user.userCode}</td>
					<td id="verticalMiddle">${user.password}</td>
					<td id="verticalMiddle">${user.locked==1?'可用':'不可用'}</td>
					<td id="verticalMiddle"><img
						style="width: 50px; height: 50px;" alt="" src="/pic/${user.salt}"></td>
					<td id="verticalMiddle">
						<button type="button" onclick="userDetail(this)"
							class="btn btn-default">详情</button>
						<button type="button" onclick="userUpdate('${user.userCode}')"
							class="btn btn-default">修改</button>
						<button type="button" onclick="userDelete(${user.id})"
							class="btn btn-default">删除</button> <c:choose>
							<c:when test="${user.locked==1}">
								<button type="button" onclick="userActivation(this)"
									class="btn btn-default">锁定</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="userActivation(this)"
									class="btn btn-default">激活</button>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="7">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfoUser!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="insertSysUser()"
									class="btn" data-toggle="modal" data-target="#myModal">添加</a></li>
								<li><a href="javascript:void(0)" onclick="userfirstPage()"
									class="btn">首页</a></li>
								<c:choose>
									<c:when test="${pageInfoUser.getPages()<5}">
										<c:forEach var="i" begin="1"
											end="${pageInfoUser.getPageNum()-1}">
											<li><a href="javascript:void(0)"
												onclick="userPointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
										<li class="current"><a href="javascript:void(0)"
											class="btn"> <c:out value="${pageInfoUser.getPageNum()}"></c:out>
										</a></li>
										<c:forEach var="i" begin="${pageInfoUser.getPageNum()+1}"
											end="${pageInfoUser.getPages()}">
											<li><a href="javascript:void(0)"
												onclick="userPointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${pageInfoUser.getPageNum()<3}">
												<c:forEach var="i" begin="1"
													end="${pageInfoUser.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="userPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out
															value="${pageInfoUser.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfoUser.getPageNum()+1}"
													end="5">
													<li><a href="javascript:void(0)"
														onclick="userPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:when
												test="${pageInfoUser.getPageNum()<pageInfoUser.getPages()-1}">
												<c:forEach var="i" begin="${pageInfoUser.getPageNum()-2}"
													end="${pageInfoUser.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="userPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out
															value="${pageInfoUser.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfoUser.getPageNum()+1}"
													end="${pageInfoUser.getPageNum()+2}">
													<li><a href="javascript:void(0)"
														onclick="userPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:forEach begin="${pageInfoUser.getPages()-4}"
													end="${pageInfoUser.getPageNum()-1}" var="i">
													<li><a href="javascript:void(0)"
														onclick="userPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out
															value="${pageInfoUser.getPageNum()}"></c:out>
												</a></li>
												<c:forEach begin="${pageInfoUser.getPageNum()+1}"
													end="${pageInfoUser.getPages()}" var="i">
													<li><a href="javascript:void(0)"
														onclick="userPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<li><a href="javascript:void(0)" onclick="userlastPage()"
									class="btn">最后一页</a></li>
							</ul>
							<input type="hidden" id="userCurrentPage"
								value="${pageInfoUser.getPageNum()}" />
							<input type="hidden" id="userTotalPage"
								value="${pageInfoUser.getPages()}" />
							<input type="hidden" id="userUrlPage" value="user/per" />
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<!--  -->
<div class="row">
	<!-- 角色表 -->
	<div class="col-md-6">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">角色信息</caption>
			<tr>
				<th class="text-center">编号</th>
				<th class="text-center">角色名</th>
				<th class="text-center">是否可用</th>
				<th class="text-center">操作</th>
			</tr>
			<c:forEach items="${pageInfoRole.list}" var="role">
				<tr>
					<td id="verticalMiddle">${role.id}</td>
					<td id="verticalMiddle">${role.name}</td>
					<td id="verticalMiddle">${role.available==1?'可用':'不可用'}</td>
					<td id="verticalMiddle">
						<button type="button" onclick="roleDetail(this)"
							class="btn btn-default">详情</button>
						<button type="button" onclick="roleUpdate(this)"
							class="btn btn-default">修改</button>
						<button type="button" onclick="roleDelete(${role.id})"
							class="btn btn-default">删除</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="4">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfoRole!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="insertRole()"
									class="btn" data-toggle="modal" data-target="#myModal">添加</a></li>
								<li><a href="javascript:void(0)" onclick="rolefirstPage()"
									class="btn">首页</a></li>
								<c:choose>
									<c:when test="${pageInfoRole.getPages()<5}">
										<c:forEach var="i" begin="1"
											end="${pageInfoRole.getPageNum()-1}">
											<li><a href="javascript:void(0)"
												onclick="rolePointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
										<li class="current"><a href="javascript:void(0)"
											class="btn"> <c:out value="${pageInfoRole.getPageNum()}"></c:out>
										</a></li>
										<c:forEach var="i" begin="${pageInfoRole.getPageNum()+1}"
											end="${pageInfoRole.getPages()}">
											<li><a href="javascript:void(0)"
												onclick="rolePointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${pageInfoRole.getPageNum()<3}">
												<c:forEach var="i" begin="1"
													end="${pageInfoRole.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="rolePointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out
															value="${pageInfoRole.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfoRole.getPageNum()+1}"
													end="5">
													<li><a href="javascript:void(0)"
														onclick="rolePointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:when
												test="${pageInfoRole.getPageNum()<pageInfoRole.getPages()-1}">
												<c:forEach var="i" begin="${pageInfoRole.getPageNum()-2}"
													end="${pageInfoRole.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="rolePointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out
															value="${pageInfoRole.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfoRole.getPageNum()+1}"
													end="${pageInfoRole.getPageNum()+2}">
													<li><a href="javascript:void(0)"
														onclick="rolePointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:forEach begin="${pageInfoRole.getPages()-4}"
													end="${pageInfoRole.getPageNum()-1}" var="i">
													<li><a href="javascript:void(0)"
														onclick="rolePointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out
															value="${pageInfoRole.getPageNum()}"></c:out>
												</a></li>
												<c:forEach begin="${pageInfoRole.getPageNum()+1}"
													end="${pageInfoRole.getPages()}" var="i">
													<li><a href="javascript:void(0)"
														onclick="rolePointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<li><a href="javascript:void(0)" onclick="rolelastPage()"
									class="btn">最后一页</a></li>
							</ul>
							<input type="hidden" id="roleCurrentPage"
								value="${pageInfoRole.getPageNum()}" />
							<input type="hidden" id="roleTotalPage"
								value="${pageInfoRole.getPages()}" />
							<input type="hidden" id="roleUrlPage" value="user/per" />
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- 权限表 -->
	<div class="col-md-6">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">权限信息</caption>
			<tr>
				<th class="text-center">编号</th>
				<th class="text-center">权限名</th>
				<th class="text-center">是否可用</th>
			</tr>
			<c:forEach items="${pageInfoPer.list}" var="pers">
				<tr height="51px">
					<td id="verticalMiddle">${pers.id}</td>
					<td id="verticalMiddle">${pers.name}</td>
					<td id="verticalMiddle">${pers.available==1?'可用':'不可用'}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="4">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfoPer!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="perfirstPage()"
									class="btn">首页</a></li>
								<c:choose>
									<c:when test="${pageInfoPer.getPages()<5}">
										<c:forEach var="i" begin="1"
											end="${pageInfoPer.getPageNum()-1}">
											<li><a href="javascript:void(0)"
												onclick="perPointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
										<li class="current"><a href="javascript:void(0)"
											class="btn"> <c:out value="${pageInfoPer.getPageNum()}"></c:out>
										</a></li>
										<c:forEach var="i" begin="${pageInfoPer.getPageNum()+1}"
											end="${pageInfoPer.getPages()}">
											<li><a href="javascript:void(0)"
												onclick="perPointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${pageInfoPer.getPageNum()<3}">
												<c:forEach var="i" begin="1"
													end="${pageInfoPer.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="perPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out value="${pageInfoPer.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfoPer.getPageNum()+1}"
													end="5">
													<li><a href="javascript:void(0)"
														onclick="perPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:when
												test="${pageInfoPer.getPageNum()<pageInfoPer.getPages()-1}">
												<c:forEach var="i" begin="${pageInfoPer.getPageNum()-2}"
													end="${pageInfoPer.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="perPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out value="${pageInfoPer.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfoPer.getPageNum()+1}"
													end="${pageInfoPer.getPageNum()+2}">
													<li><a href="javascript:void(0)"
														onclick="perPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:forEach begin="${pageInfoPer.getPages()-4}"
													end="${pageInfoPer.getPageNum()-1}" var="i">
													<li><a href="javascript:void(0)"
														onclick="perPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out value="${pageInfoPer.getPageNum()}"></c:out>
												</a></li>
												<c:forEach begin="${pageInfoPer.getPageNum()+1}"
													end="${pageInfoPer.getPages()}" var="i">
													<li><a href="javascript:void(0)"
														onclick="perPointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<li><a href="javascript:void(0)" onclick="perlastPage()"
									class="btn">最后一页</a></li>
							</ul>
							<input type="hidden" id="perCurrentPage"
								value="${pageInfoPer.getPageNum()}" />
							<input type="hidden" id="perTotalPage"
								value="${pageInfoPer.getPages()}" />
							<input type="hidden" id="perUrlPage" value="user/per" />
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>


<!-- 管理员拥有的角色 -->
<div class="modal fade" id="myModalUser" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">详细信息</h4>
			</div>
			<form action="user/updateUserRole" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center"
						style="width: 98%">
						<tr>
							<td class="text-right" style="width: 120px">用户名</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right" style="width: 120px">已拥有的角色</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right" style="width: 120px">所有角色</td>
							<td class="text-left"></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
				<input type="hidden" id="userId" name="userId" />
			</form>
		</div>
	</div>
</div>
<!-- 添加/修改管理员 -->
<div class="modal fade" id="myModalUserIU" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">详细信息</h4>
			</div>
			<form action="user/insertOrUpdateSysUser" method="post" enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center"
						style="width: 98%">
						<tr>
							<th class="text-center">编号</th>
							<th class="text-center">真实姓名</th>
							<th class="text-center">账号</th>
							<th class="text-center">密码</th>
							<th class="text-center">头像</th>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 角色拥有的权限 -->
<div class="modal fade" id="myModalRole" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">详细信息</h4>
			</div>
			<form action="user/updateRolePer" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center"
						style="width: 98%">
						<tr>
							<td class="text-right" style="width: 120px">角色名</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right" style="width: 120px">已拥有的权限</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right" style="width: 120px">所有权限</td>
							<td class="text-left"></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
				<input type="hidden" id="roleId" name="roleId" />
			</form>
		</div>
	</div>
</div>
<!-- 添加/修改角色 -->
<div class="modal fade" id="myModalRoleIU" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">详细信息</h4>
			</div>
			<form action="user/insertOrUpdateSysRole" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center"
						style="width: 98%">
						<tr>
							<th class="text-center">编号</th>
							<th class="text-center">角色名</th>
							<th class="text-center">是否可用</th>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
			</form>
		</div>
	</div>
</div>
