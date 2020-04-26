<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	//详细信息
	function deptDetail(id) {
		$.ajax({
			url:"user/deptDetail",
			type:"GET",
			data:"id="+id,
			dataType:"json",//响应的类型
			success:function(data){
				$("#myModal .modal-body table tr:gt(0)").remove();
				var $dept="<tr><td id='verticalMiddle'><input style='width: 30px' name='id' type='text' value='"+data.id+"' readonly='readonly'></td> <td id='verticalMiddle'><input style='width: 100px' name='name' type='text' value='"+data.name+"'></td> <td id='verticalMiddle'><input style='width: 200px' name='desc' type='text' value='"+data.desc+"'></td> <td id='verticalMiddle'><input style='width: 50px' name='maxPerson' type='text' value='"+data.maxPerson+"'></td> </tr>";
				$("#myModal .modal-body table tr:eq(0)").after($dept);
			}
		});
	}
	//确认框
	function sure() {
		if(confirm("Are you sure to modify?")){
			return true;
		}else{
			return false;
		}
	}
	//添加
	function insertDept() {
		$("#myModal .modal-body table tr:gt(0)").remove();
		var $dept="<tr><td id='verticalMiddle'></td> <td id='verticalMiddle'><input style='width: 100px' name='name' type='text' value=''></td> <td id='verticalMiddle'><input style='width: 200px' name='desc' type='text' value=''></td> <td id='verticalMiddle'><input style='width: 50px' name='maxPerson' type='text' value=''></td></tr>";
		$("#myModal .modal-body table tr:eq(0)").after($dept);
	}
	//删除
	function deptDelete(id) {
		if(confirm("Are you sure to delete it?")){
			window.location.href="user/deptDelete?id="+id;
		}
	}
	//部门下的员工信息
	function deptEmp(id) {
		/* data-toggle="modal"
		data-target="#myModalemp" */
		$.ajax({
			url:"user/deptemp",
			type:"GET",
			data:"id="+id,
			dataType:"json",//响应的类型
			success:function(data){
				/* var json = JSON.stringify(data);
				alert(json);
				console.log(data); */
				if(data.length>0){
					$("#myModalemp .modal-body table tr:gt(0)").remove();
					var $emp="";
					$.each(data,function(i,item){
						$emp+="<tr> <td class='text-center'>"+item.id+"</td> <td class='text-center'>"+item.name+"</td> <td class='text-center'>"+item.sex+"</td> <td class='text-center'>"+item.age+"</td> <td class='text-center'>"+item.address+"</td> </tr>";
					});
					$("#myModalemp .modal-body table tr:eq(0)").after($emp);
					$("#myModalemp").modal("show");
				}else{
					alert("该部门下没有员工!");
				}
			}
		});
	}
</script>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">部门管理</caption>
			<tr>
				<th class="text-center">部门编号</th>
				<th class="text-center">部门名称</th>
				<th class="text-center">部门描述</th>
				<th class="text-center">最大人数</th>
				<th class="text-center">操作</th>
			</tr>
			<c:forEach items="${pageInfo.list}" var="dept">
				<tr>
					<td id="verticalMiddle">${dept.id}</td>
					<td id="verticalMiddle">${dept.name}</td>
					<td id="verticalMiddle">${dept.desc}</td>
					<td id="verticalMiddle">${dept.maxPerson}</td>
					<td id="verticalMiddle">
						<button type="button" onclick="deptDetail(${dept.id})"
							class="btn btn-default" data-toggle="modal"
							data-target="#myModal">详情</button>
						<button type="button" onclick="deptDelete(${dept.id})"
							class="btn btn-default">删除</button>
						<button type="button" onclick="deptEmp(${dept.id})"
							class="btn btn-default" >员工信息</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfo!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="insertDept()"
									class="btn" data-toggle="modal" data-target="#myModal">添加</a></li>
								<li><a href="javascript:void(0)" onclick="firstPage()"
									class="btn">首页</a></li>
								<!-- <li><a href="javascript:void(0)" onclick="upPage()" class="btn">上一页</a></li> -->
								<c:choose>
									<c:when test="${pageInfo.getPages()<5}">
										<c:forEach var="i" begin="1" end="${pageInfo.getPageNum()-1}">
											<li><a href="javascript:void(0)"
												onclick="pointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
										<li class="current"><a href="javascript:void(0)"
											class="btn"> <c:out value="${pageInfo.getPageNum()}"></c:out>
										</a></li>
										<c:forEach var="i" begin="${pageInfo.getPageNum()+1}"
											end="${pageInfo.getPages()}">
											<li><a href="javascript:void(0)"
												onclick="pointPage(${i})" class="btn"> <c:out
														value="${i}"></c:out>
											</a></li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${pageInfo.getPageNum()<3}">
												<c:forEach var="i" begin="1"
													end="${pageInfo.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="pointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out value="${pageInfo.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfo.getPageNum()+1}"
													end="5">
													<li><a href="javascript:void(0)"
														onclick="pointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:when test="${pageInfo.getPageNum()<pageInfo.getPages()-1}">
												<c:forEach var="i" begin="${pageInfo.getPageNum()-2}"
													end="${pageInfo.getPageNum()-1}">
													<li><a href="javascript:void(0)"
														onclick="pointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out value="${pageInfo.getPageNum()}"></c:out>
												</a></li>
												<c:forEach var="i" begin="${pageInfo.getPageNum()+1}"
													end="${pageInfo.getPageNum()+2}">
													<li><a href="javascript:void(0)"
														onclick="pointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:forEach begin="${pageInfo.getPages()-4}"
													end="${pageInfo.getPageNum()-1}" var="i">
													<li><a href="javascript:void(0)"
														onclick="pointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
												<li class="current"><a href="javascript:void(0)"
													class="btn"> <c:out value="${pageInfo.getPageNum()}"></c:out>
												</a></li>
												<c:forEach begin="${pageInfo.getPageNum()+1}"
													end="${pageInfo.getPages()}" var="i">
													<li><a href="javascript:void(0)"
														onclick="pointPage(${i})" class="btn"> <c:out
																value="${i}"></c:out>
													</a></li>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<!-- <li><a href="javascript:void(0)" onclick="downPage()" class="btn">下一页</a></li> -->
								<li><a href="javascript:void(0)" onclick="lastPage()"
									class="btn">最后一页</a></li>
							</ul>
							<input type="hidden" id="currentPage"
								value="${pageInfo.getPageNum()}" />
							<input type="hidden" id="totalPage"
								value="${pageInfo.getPages()}" />
							<input type="hidden" id="urlPage" value="user/dept" />
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<!-- 模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
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
			<form action="user/insertOrupdate" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<th class="text-center">部门编号</th>
							<th class="text-center">部门名称</th>
							<th class="text-center">部门描述</th>
							<th class="text-center">最大人数</th>
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
<!-- 某个部门下的员工 -->
<div class="modal fade" id="myModalemp" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">员工信息</h4>
			</div>
			<div class="modal-body">
				<table class="table table-bordered table-hover text-center">
					<tr>
						<th class="text-center">员工编号</th>
						<th class="text-center">员工名称</th>
						<th class="text-center">员工性别</th>
						<th class="text-center">员工年龄</th>
						<th class="text-center">员工住址</th>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>