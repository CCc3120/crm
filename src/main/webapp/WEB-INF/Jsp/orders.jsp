<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">
	//确认框
	function sure() {
		if(confirm("Are you sure to modify?")){
			return true;
		}else{
			return false;
		}
	}
	//删除订单
	function ordDelete(id) {
		if(confirm("Are you sure to delete it?")){
			window.location.href="order/ordDelete?id="+id;
		}
	}
	//订单详情
	function ordDetail(id) {
		$("#myModalOrder input[name=oid]").val("");//订单id
		$("#myModalOrder .modal-body table tr:eq(0) td:eq(1)").children().remove();//图片
		$("#myModalOrder .modal-body table tr:eq(1) td:eq(1)").text("");//商品名
		$("#myModalOrder .modal-body table tr:eq(2) td:eq(1)").text("");//单价
		$("#myModalOrder .modal-body table tr:eq(3) td:eq(1) input").val("");//数量
		$("#myModalOrder .modal-body table tr:eq(3) td:eq(1) small").text("");//库存
		$("#myModalOrder .modal-body table tr:eq(4) td:eq(1)").text("");//总价
		$("#myModalOrder .modal-body table tr:eq(5) td:eq(1)").text("");//下单时间
		$("#myModalOrder .modal-body table tr:eq(6) td:eq(1)").children().remove();//客户
		$("#myModalOrder .modal-body table tr:eq(7) td:eq(1)").children().remove();//部门
		$("#myModalOrder .modal-body table tr:eq(8) td:eq(1)").children().remove();//员工
		var order;
		$.ajax({
			url:"order/ordDetail",
			data:"id="+id,
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				if(!data){//非空判断  空
					alert("操作失败!");
				}else{
					order=data;
					$("#myModalOrder input[name=oid]").val(data.id);//订单id
					$("#myModalOrder .modal-body table tr:eq(0) td:eq(1)").html("<img style='width: 50px; height: 50px;display: inline-block;' alt='' src='/pic/"+data.product.pic+"'>");
					$("#myModalOrder .modal-body table tr:eq(1) td:eq(1)").text(data.product.name);//商品名
					$("#myModalOrder .modal-body table tr:eq(2) td:eq(1)").text(data.product.cost);//单价
					$("#myModalOrder .modal-body table tr:eq(3) td:eq(1) input").val(data.quantity);//数量
					$("#myModalOrder .modal-body table tr:eq(3) td:eq(1) small").text("剩"+data.product.stock+"件");//库存
					$("#myModalOrder .modal-body table tr:eq(4) td:eq(1)").text(data.pay);//总价
					$("#myModalOrder .modal-body table tr:eq(5) td:eq(1)").text(data.createTime);//下单时间
				}
			}
		});
		//客户
		var customs="<select name='customid'>";
		$.ajax({
			url:"custom/getAllCustom",
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$.each(data,function(i,item){
					if(order.custom.id==item.id){
						customs+="<option value='"+item.id+"' selected='selected'>"+item.name+"</option>";
					}else{
						customs+="<option value='"+item.id+"'>"+item.name+"</option>";
					}
				});
			}
		});
		customs+="</select>";
		$("#myModalOrder .modal-body table tr:eq(6) td:eq(1)").html(customs);
		//部门
		var depts="<select onchange='getEmp()' name='deptid'>";
		$.ajax({
			url:"user/alldept",
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$.each(data,function(i,item){
					if(order.dept.id==item.id){
						depts+="<option value='"+item.id+"' selected='selected'>"+item.name+"</option>";
					}else{
						depts+="<option value='"+item.id+"'>"+item.name+"</option>";
					}
				});
			}
		});
		depts+="</select>";
		$("#myModalOrder .modal-body table tr:eq(7) td:eq(1)").html(depts);
		//员工
		var emps="<select name='empid'>";
		$.ajax({
			url:"user/deptemp",
			data:"id="+order.dept.id,
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				if(data.length>0){
					$.each(data,function(i,item){
						if(order.emp.id==item.id){
							emps+="<option value='"+item.id+"' selected='selected'>"+item.name+"</option>";
						}else{
							emps+="<option value='"+item.id+"'>"+item.name+"</option>";
						}
					
					});
					emps+="</select>";
				}else{
					emps="该部门下暂无员工!"
				}
			}
		});
		$("#myModalOrder .modal-body table tr:eq(8) td:eq(1)").html(emps);
		$("#myModalOrder").modal("show"); 
	}
	//员工
	function getEmp(){
		$("#myModalOrder .modal-body table tr:eq(8) td:eq(1)").children().remove();//员工
		var id = $("#myModalOrder .modal-body table tr:eq(7) td:eq(1) select option:selected").val();  
		//alert(id);
		var emps="<select name='empid'><option value='0' selected='selected'>请选择</option>";
		$.ajax({
			url:"user/deptemp",
			data:"id="+id,
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				if(data.length>0){
					$.each(data,function(i,item){
						emps+="<option value='"+item.id+"'>"+item.name+"</option>";
					});
					emps+="</select>";
				}else{
					emps="该部门下暂无员工!"
				}
			}
		});
		$("#myModalOrder .modal-body table tr:eq(8) td:eq(1)").html(emps);
	}
	function getMoney(){
		var money=0;
		var quantity=$("#myModalOrder .modal-body table tr:eq(3) td:eq(1) input").val();
		var price=$("#myModalOrder .modal-body table tr:eq(2) td:eq(1)").text();
		money= Math.round(parseFloat(quantity)* parseFloat(price)*100)/100;
		$("#myModalOrder .modal-body table tr:eq(4) td:eq(1)").html("<input style='width:100px' name='pay' type='text' value='"+money+"' readonly='readonly'>");
	}
</script>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">订单记录</caption>
			<tr>
				<th class="text-center">商品图片</th>
				<th class="text-center">商品名</th>
				<th class="text-center">单价</th>
				<th class="text-center">购买数量</th>
				<th class="text-center">总价</th>
				<th class="text-center">下单时间</th>
				<th class="text-center">顾客名</th>
				<th class="text-center">员工名</th>
				<th class="text-center">部门</th>
				<th class="text-center">操作</th>
			</tr>
			<c:forEach items="${pageInfo.list}" var="ord">
				<tr>
					<td id="verticalMiddle">
						<img style="width: 50px; height: 50px;" alt="" src="/pic/${ord.product.pic}">
					</td>
					<td id="verticalMiddle">${ord.product.name}</td>
					<td id="verticalMiddle">${ord.product.cost}</td>
					<td id="verticalMiddle">${ord.quantity}</td>
					<td id="verticalMiddle">${ord.pay}</td>
					<td id="verticalMiddle"><fmt:formatDate value="${ord.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
					<td id="verticalMiddle">${ord.custom.name}</td>
					<td id="verticalMiddle">${ord.emp.name}</td>
					<td id="verticalMiddle">${ord.dept.name}</td>
					<td id="verticalMiddle">
						<button type="button" onclick="ordDetail(${ord.id})"
							class="btn btn-default">详情</button>
						<button type="button" onclick="ordDelete(${ord.id})"
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
							<input type="hidden" id="urlPage" value="order/getOrders" />
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="modal fade" id="myModalOrder" tabindex="-1" role="dialog"
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
			<form action="order/insertOrders" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<input name="oid" type="hidden">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td class="text-right" style="width: 120px">商品图片</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">商品名</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">单价</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">购买数量</td>
							<td class="text-left"><input onblur="getMoney()" type="text" name="quantity">&nbsp;&nbsp;&nbsp;<small></small></td>
						</tr>
						<tr>
							<td class="text-right">总价</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">下单时间</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">购买的客户</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">选择部门</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">选择员工</td>
							<td class="text-left"></td>
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