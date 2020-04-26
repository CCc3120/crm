<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
	//确认框
	function sure() {
		if(confirm("Are you sure to modify?")){
			return true;
		}else{
			return false;
		}
	}
	
	function insertCustom() {
		$("#myModalCustom").modal("show"); 
	}
	
	function cusDelete(obj) {
		var id=$(obj).parents("td").children("input").val();
		if(sure()){
			$.ajax({
				url:"custom/delCustom",
				data:"id="+id,
				type:"GET",
				dataType:"text",
				success:function(data){
					if(data==1){
						alert("Operation is successful");
						$(obj).parents("tr").remove();
					}else{
						alert("The operation failure");
					}
				}
			});
		}
	}
	
	function cusDetail(obj) {
		var id=$(obj).parents("td").children("input").val();
		var name=$(obj).parents("tr").find("td:eq(0)").text();
		var address=$(obj).parents("tr").find("td:eq(2)").text();
		var sex=$(obj).parents("tr").find("td:eq(1)").text();
		var birthday=$(obj).parents("tr").find("td:eq(3)").text();
		$("#myModalCustomUpdate input[name='id']").val(id);
		$("#myModalCustomUpdate table tr:eq(0) td:eq(1) input").val(name);
		if(sex=="男"){
			$("#myModalCustomUpdate table tr:eq(1) td:eq(1) #man").attr("checked","checked");
		}else{
			$("#myModalCustomUpdate table tr:eq(1) td:eq(1) #woman").attr("checked","checked");
		}
		$("#myModalCustomUpdate table tr:eq(2) td:eq(1) input").val(address);
		$("#myModalCustomUpdate table tr:eq(3) td:eq(1) input").val(birthday);
		
		$("#myModalCustomUpdate").modal("show"); 
		
	}
</script>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">客户信息</caption>
			<tr>
				<th class="text-center">客户名</th>
				<th class="text-center">性别</th>
				<th class="text-center">住址</th>
				<th class="text-center">生日</th>
				<th class="text-center">操作</th>
			</tr>
			<c:forEach items="${pageInfo.list}" var="cus">
				<tr>
					<td id="verticalMiddle">${cus.name}</td>
					<td id="verticalMiddle">${cus.sex}</td>
					<td id="verticalMiddle">${cus.address}</td>
					<td id="verticalMiddle"><fmt:formatDate
							value="${cus.birthday}" pattern="yyyy-MM-dd" /></td>
					<td id="verticalMiddle">
						<input type="hidden" value="${cus.id}">
		 				<button type="button" onclick="cusDetail(this)"
							class="btn btn-default">修改</button>
						<button type="button" onclick="cusDelete(this)"
							class="btn btn-default">删除</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="10">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfo!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="insertCustom()"
									class="btn">添加</a></li>
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
							<input type="hidden" id="urlPage" value="custom/customs" />
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="modal fade" id="myModalCustom" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">详细信息</h4>
			</div>
			<form action="custom/insertCustom" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td>客户名</td>
							<td><input value="" type="text" name="name"></td>
						</tr>
						<tr>
							<td>性别</td>
							<td>
								<input id="man" name="sex" value="1" type="radio"><label for="man">先生</label>
								<input id="woman" name="sex" value="2" type="radio"><label for="woman">女士</label>
							</td>
						</tr>
						<tr>
							<td>住址</td>
							<td><input value="" type="text" name="address"></td>
						</tr>
						<tr>
							<td>出生日期</td>
							<td><input value="" type="date" name="birthday"></td>
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

<div class="modal fade" id="myModalCustomUpdate" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">详细信息</h4>
			</div>
			<form action="custom/updateCustom" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<input type="hidden" name="id" value="">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td>客户名</td>
							<td><input disabled="disabled" type="text" name="name"></td>
						</tr>
						<tr>
							<td>性别</td>
							<td>
								<input id="man" name="sex" value="1" type="radio"><label for="man">先生</label>
								<input id="woman" name="sex" value="2" type="radio"><label for="woman">女士</label>
							</td>
						</tr>
						<tr>
							<td>住址</td>
							<td><input value="" type="text" name="address"></td>
						</tr>
						<tr>
							<td>出生日期</td>
							<td><input value="" type="date" name="birthday"></td>
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