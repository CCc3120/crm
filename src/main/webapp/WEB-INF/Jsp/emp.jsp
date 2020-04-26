<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<script type="text/javascript">
	//确认框
	function sure() {
		if(confirm("Are you sure to modify?")){
			return true;
		}else{
			return false;
		}
	}
	//删除
	function empDelete(id) {
		if(confirm("Are you sure to delete it?")){
			window.location.href="user/empDelete?id="+id;
		}
	}
	//详情
	function empDetail(id) {
	 	var dept;
		$.ajax({
			url:"user/alldept",
			async:false, //同步
			type:"GET",
			dataType:"json",//响应的类型
			success:function(data){
				dept=data;
			}
		});
		
		$.ajax({
			url:"user/empDetail",
			type:"GET",
			data:"id="+id,
			dataType:"json",//响应的类型
			success:function(data){
				$("#myModal .modal-body table tr:gt(0)").remove();
				var $emp="<tr><td id='verticalMiddle'><input style='width: 30px' name='id' type='text' value='"+data.id+"' readonly='readonly'></td> <td id='verticalMiddle'><input style='width: 50px' name='name' type='text' value='"+data.name+"'></td> <td id='verticalMiddle'><input style='width: 50px' name='sex' type='text' value='"+data.sex+"'></td> <td id='verticalMiddle'><input style='width: 50px' name='age' type='text' value='"+data.age+"'></td><td id='verticalMiddle'><input style='width: 100px' name='address' type='text' value='"+data.address+"'></td><td id='verticalMiddle'><select name='deptno'>";
				if(!data.dept){
					$emp+="<option value='0' selected='selected'>请选择</option>";
					$.each(dept,function(i,item){
						$emp+="<option value='"+item.id+"'>"+item.name+"</option>";
					});
				}else{
					$emp+="<option value='0'>移出部门</option>";
					$.each(dept,function(i,item){
						if(item.id==data.dept.id){
							$emp+="<option value='"+item.id+"' selected='selected'>"+item.name+"</option>";
						}else{
							$emp+="<option value='"+item.id+"'>"+item.name+"</option>";
						}
					});
				}
				$emp+="</select></td></tr>";
				$("#myModal .modal-body table tr:eq(0)").after($emp);
			}
		});
	}
	//添加
	function insertEmp() {
		$.ajax({
			url:"user/alldept",
			type:"GET",
			dataType:"json",//响应的类型
			success:function(data){
				$("#myModal .modal-body table tr:gt(0)").remove();
				var $emp="<tr><td id='verticalMiddle'></td> <td id='verticalMiddle'><input style='width: 50px' name='name' type='text' value=''></td> <td id='verticalMiddle'><input style='width: 50px' name='sex' type='text' value=''></td> <td id='verticalMiddle'><input style='width: 50px' name='age' type='text' value=''></td><td id='verticalMiddle'><input style='width: 100px' name='address' type='text' value=''></td><td id='verticalMiddle'><select name='deptno'><option value='0' selected='selected'>请选择</option>";
				$.each(data,function(i,item){
					$emp+="<option value='"+item.id+"'>"+item.name+"</option>";
				});
				$emp+="</select></td></tr>";
				$("#myModal .modal-body table tr:eq(0)").after($emp);
			}
		});
		/* $("#myModal .modal-body table tr:gt(0)").remove(); */
		/* var $emp="<tr><td id='verticalMiddle'></td> <td id='verticalMiddle'><input style='width: 50px' name='name' type='text' value=''></td> <td id='verticalMiddle'><input style='width: 50px' name='sex' type='text' value=''></td> <td id='verticalMiddle'><input style='width: 50px' name='age' type='text' value=''></td><td id='verticalMiddle'><input style='width: 200px' name='address' type='text' value=''></td></tr>";
		$("#myModal .modal-body table tr:eq(0)").after($emp); */
	}
	//员工所在部门
	function empDept(id) { 
	/* 	data-toggle="modal"
		data-target="#myModaldept" */
		if(id==null){
			$("#myModaldept .modal-body table tr:gt(0)").remove();
			alert("暂无部门信息!");
		}else{
			$.ajax({
				url:"user/deptDetail",
				data:"id="+id,
				type:"GET",
				dataType:"json",//响应的类型
				success:function(data){
					$("#myModaldept .modal-body table tr:gt(0)").remove();
					var $dept="<tr><td id='verticalMiddle'>"+data.id+"</td> <td id='verticalMiddle'>"+data.name+"</td> <td id='verticalMiddle'>"+data.desc+"</td> <td id='verticalMiddle'>"+data.maxPerson+"</td> </tr>";
					$("#myModaldept .modal-body table tr:eq(0)").after($dept);
				}
			});
			$("#myModaldept").modal("show");
		}
	}
</script>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">员工管理</caption>
			<tr>
				<th class="text-center">员工编号</th>
				<th class="text-center">员工名称</th>
				<th class="text-center">员工性别</th>
				<th class="text-center">员工年龄</th>
				<th class="text-center">员工住址</th>
				<th class="text-center">所在部门</th>
				<th class="text-center">操作</th>
			</tr>
			<c:forEach items="${pageInfo.list}" var="emp">
				<tr>
					<td id="verticalMiddle">${emp.id}</td>
					<td id="verticalMiddle">${emp.name}</td>
					<td id="verticalMiddle">${emp.sex}</td>
					<td id="verticalMiddle">${emp.age}</td>
					<td id="verticalMiddle">${emp.address}</td>
					<td id="verticalMiddle">${emp.dept.name}</td>
					<td id="verticalMiddle">
						<button type="button" onclick="empDetail(${emp.id})"
							class="btn btn-default" data-toggle="modal"
							data-target="#myModal">详情</button>
						<button type="button" onclick="empDelete(${emp.id})"
							class="btn btn-default">删除</button>
						<button type="button" onclick="empDept(${emp.dept.id})"
							class="btn btn-default">部门信息</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="7">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfo!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="insertEmp()"
									class="btn" data-toggle="modal" data-target="#myModal">添加</a></li>
								<li><a href="javascript:void(0)" onclick="firstPage()"
									class="btn">首页</a></li>
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
								<li><a href="javascript:void(0)" onclick="lastPage()"
									class="btn">最后一页</a></li>
							</ul>
							<input type="hidden" id="currentPage"
								value="${pageInfo.getPageNum()}" />
							<input type="hidden" id="totalPage"
								value="${pageInfo.getPages()}" />
							<input type="hidden" id="urlPage" value="user/emp" />
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
			<form action="user/insertOrupdateEmp" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<th class="text-center">员工编号</th>
							<th class="text-center">员工名称</th>
							<th class="text-center">员工性别</th>
							<th class="text-center">员工年龄</th>
							<th class="text-center">员工住址</th>
							<th class="text-center">所在部门</th>
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
<!-- 某个员工对应的部门-->
<div class="modal fade" id="myModaldept" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">部门信息</h4>
			</div>
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
			</div>
		</div>
	</div>
</div>