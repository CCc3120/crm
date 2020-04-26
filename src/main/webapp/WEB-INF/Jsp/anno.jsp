<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	//删除
	function annoDelete(id) {
		if(confirm("Are you sure to delete it?")){
			window.location.href="user/annoDelete?id="+id;
		}
	}
</script>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered table-hover text-center">
			<tr>
				<th colspan="2" class="text-center"><h1>公&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;告</h1></th>
			</tr>
			<c:forEach items="${pageInfo.list}" var="anno">
			<tr>
				<td id="verticalMiddle" >
					<div class="row"> 
					    <p style="font-size: 22px;display: inline-block;">${anno.title}</p>
					 	<p class="text-right" style="display: inline-block;"> <small><fmt:formatDate value="${anno.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></small></p>
					</div>
					<p class="" style="text-align:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${anno.content}</p>
				</td>
				<td id="verticalMiddle" style="width: 100px">
					<button type="button" onclick="annoDelete(${anno.id})" class="btn btn-default">删除</button>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="5">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfo!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="insertDept()" class="btn" data-toggle="modal" data-target="#myModal">添加</a></li>
								<li><a href="javascript:void(0)" onclick="firstPage()" class="btn">首页</a></li>
								<!-- <li><a href="javascript:void(0)" onclick="upPage()" class="btn">上一页</a></li> -->
								<c:choose>
									<c:when test="${pageInfo.getPages()<5}">
										<c:forEach var="i" begin="1" end="${pageInfo.getPageNum()-1}">
											<li>
												<a href="javascript:void(0)" onclick="pointPage(${i})" class="btn">
													<c:out value="${i}"></c:out>
												</a>
											</li>
										</c:forEach>
										<li class="current">
											<a href="javascript:void(0)" class="btn">
												<c:out value="${pageInfo.getPageNum()}"></c:out>
											</a>
										</li>
										<c:forEach var="i" begin="${pageInfo.getPageNum()+1}" end="${pageInfo.getPages()}">
											<li>
												<a href="javascript:void(0)" onclick="pointPage(${i})" class="btn">
													<c:out value="${i}"></c:out>
												</a>
											</li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${pageInfo.getPageNum()<3}">
												<c:forEach var="i" begin="1" end="${pageInfo.getPageNum()-1}">
													<li>
														<a href="javascript:void(0)" onclick="pointPage(${i})" class="btn">
															<c:out value="${i}"></c:out>
														</a>
													</li>
												</c:forEach>
												<li class="current">
													<a href="javascript:void(0)" class="btn">
														<c:out value="${pageInfo.getPageNum()}"></c:out>
													</a>
												</li>
												<c:forEach var="i" begin="${pageInfo.getPageNum()+1}" end="5">
													<li>
														<a href="javascript:void(0)" onclick="pointPage(${i})"
														class="btn"> <c:out value="${i}"></c:out>
													</a>
													</li>
												</c:forEach>
											</c:when>
											<c:when test="${pageInfo.getPageNum()<pageInfo.getPages()-1}">
												<c:forEach var="i" begin="${pageInfo.getPageNum()-2}" end="${pageInfo.getPageNum()-1}">
													<li>
														<a href="javascript:void(0)" onclick="pointPage(${i})" class="btn">
															<c:out value="${i}"></c:out>
														</a>
													</li>
												</c:forEach>
												<li class="current">
													<a href="javascript:void(0)" class="btn">
														<c:out value="${pageInfo.getPageNum()}"></c:out>
													</a>
												</li>
												<c:forEach var="i" begin="${pageInfo.getPageNum()+1}" end="${pageInfo.getPageNum()+2}">
													<li>
														<a href="javascript:void(0)" onclick="pointPage(${i})" class="btn">
															<c:out value="${i}"></c:out>
														</a>
													</li>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:forEach begin="${pageInfo.getPages()-4}" end="${pageInfo.getPageNum()-1}" var="i">
													<li>
														<a href="javascript:void(0)" onclick="pointPage(${i})" class="btn">
															<c:out value="${i}"></c:out>
														</a>
													</li>
												</c:forEach>
												<li class="current">
													<a href="javascript:void(0)" class="btn">
														<c:out value="${pageInfo.getPageNum()}"></c:out>
													</a>
												</li>
												<c:forEach begin="${pageInfo.getPageNum()+1}" end="${pageInfo.getPages()}" var="i">
													<li>
														<a href="javascript:void(0)" onclick="pointPage(${i})" class="btn">
															<c:out value="${i}"></c:out>
														</a>
													</li>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<!-- <li><a href="javascript:void(0)" onclick="downPage()" class="btn">下一页</a></li> -->
								<li><a href="javascript:void(0)" onclick="lastPage()" class="btn">最后一页</a></li>
							</ul>
							<input type="hidden" id="currentPage" value="${pageInfo.getPageNum()}" />
							<input type="hidden" id="totalPage" value="${pageInfo.getPages()}" />
							<input type="hidden" id="urlPage" value="user/announ" />
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
			<form action="user/insertAnnoun" method="post" enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td>标题:</td>
							<td><input type="text" name="title"></td>
						</tr>
						<tr>
							<td>内容:</td>
							<td><textarea name="content" rows="10" cols="60"></textarea></td>
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