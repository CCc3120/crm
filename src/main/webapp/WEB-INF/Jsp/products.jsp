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
	//添加
	function insertProduct() {
		$("input[name=id]").val("");
		$("#myModal .modal-body table tr:eq(0) td:eq(1)").children().remove();
		$("#myModal .modal-body table tr:eq(1) td:eq(1)").children().remove();
		$("#myModal .modal-body table tr:eq(2) td:eq(1) textarea").text("");
		$("#myModal .modal-body table tr:eq(3) td:eq(1)").children().remove();
		$("#myModal .modal-body table tr:eq(4) td:eq(1)").children().remove();
		$("#myModal .modal-body table tr:eq(5) td:eq(1)").children().remove();
		$("#myModal .modal-body table tr:eq(6) td:eq(1)").children().remove();
		$("#myModal .modal-body table tr:eq(0) td:eq(1)").html("<input type='file' name='pictureFile'>");
		$("#myModal .modal-body table tr:eq(1) td:eq(1)").html("<input type='text' name='name'>");
		$("#myModal .modal-body table tr:eq(3) td:eq(1)").html("<input type='text' name='price'>$");
		$("#myModal .modal-body table tr:eq(4) td:eq(1)").html("<input type='text' name='stock'>");
		$("#myModal .modal-body table tr:eq(5) td:eq(1)").html("<input type='text' name='discount'>");
		$("#myModal .modal-body table tr:eq(6) td:eq(1)").html("<input type='text' name='cost' placeholder='可不输,系统会进行验证'>$");
		$("#myModal").modal("show");
	}
	//详情
	function proDetail(id) {
		$.ajax({
			url:"order/prodetail",
			data:"id="+id,
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$("#myModal input[name=id]").val("");
				$("#myModal .modal-body table tr:eq(0) td:eq(1)").children().remove();
				$("#myModal .modal-body table tr:eq(1) td:eq(1)").children().remove();
				$("#myModal .modal-body table tr:eq(2) td:eq(1) textarea").text("");
				$("#myModal .modal-body table tr:eq(3) td:eq(1)").children().remove();
				$("#myModal .modal-body table tr:eq(4) td:eq(1)").children().remove();
				$("#myModal .modal-body table tr:eq(5) td:eq(1)").children().remove();
				$("#myModal .modal-body table tr:eq(6) td:eq(1)").children().remove();
				$("#myModal input[name=id]").val(data.id);
				$("#myModal .modal-body table tr:eq(0) td:eq(1)").html("<img style='width: 50px; height: 50px;display: inline-block;' alt='' src='/pic/"+data.pic+"'><input style='display: inline-block;' type='file' name='pictureFile'>");
				$("#myModal .modal-body table tr:eq(1) td:eq(1)").html("<input type='text' name='name' value='"+data.name+"'>");
				$("#myModal .modal-body table tr:eq(2) td:eq(1) textarea").text(data.desc);
				$("#myModal .modal-body table tr:eq(3) td:eq(1)").html("<input type='text' name='price' value='"+data.price+"'>$");
				$("#myModal .modal-body table tr:eq(4) td:eq(1)").html("<input type='text' name='stock' value='"+data.stock+"'>");
				if(!data.discount){
					$("#myModal .modal-body table tr:eq(5) td:eq(1)").html("<input type='text' name='discount' value=''>");
				}else{
					$("#myModal .modal-body table tr:eq(5) td:eq(1)").html("<input type='text' name='discount' value='"+data.discount+"'>");
				}
				if(!data.cost){
					$("#myModal .modal-body table tr:eq(6) td:eq(1)").html("<input type='text' name='cost' value=''>$");
				}else{
					$("#myModal .modal-body table tr:eq(6) td:eq(1)").html("<input type='text' name='cost' value='"+data.cost+"'>$");
				}
				$("#myModal").modal("show");
			}
		});
	}
	//删除
	function proDelete(id) {
		if(confirm("Are you sure to delete it?")){
			window.location.href="order/proDelete?id="+id;
		}
	}
	//购买
	function proBuy(id) {
		$.ajax({
			url:"order/prodetail",
			data:"id="+id,
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$("#myModalbuy input[name=pid]").val("");//商品id
				$("#myModalbuy .modal-body table tr:eq(0) td:eq(1)").children().remove();//图片
				$("#myModalbuy .modal-body table tr:eq(1) td:eq(1)").text("");//商品名
				$("#myModalbuy .modal-body table tr:eq(2) td:eq(1)").text("");//商品描述
				$("#myModalbuy .modal-body table tr:eq(3) td:eq(1)").text("");//单价
				$("#myModalbuy .modal-body table tr:eq(4) td:eq(1) input").val("");//数量
				$("#myModalbuy .modal-body table tr:eq(4) td:eq(1) small").text("");//库存
				$("#myModalbuy .modal-body table tr:eq(5) td:eq(1)").text("");//总价
				$("#myModalbuy .modal-body table tr:eq(6) td:eq(1)").children().remove();//客户
				$("#myModalbuy .modal-body table tr:eq(7) td:eq(1)").children().remove();//部门
				$("#myModalbuy .modal-body table tr:eq(8) td:eq(1)").children().remove();//员工
				$("#myModalbuy input[name=pid]").val(data.id);//商品id
				$("#myModalbuy .modal-body table tr:eq(0) td:eq(1)").html("<img style='width: 50px; height: 50px;display: inline-block;' alt='' src='/pic/"+data.pic+"'>");
				$("#myModalbuy .modal-body table tr:eq(1) td:eq(1)").text(data.name);//商品名
				$("#myModalbuy .modal-body table tr:eq(2) td:eq(1)").text(data.desc);//商品描述
				$("#myModalbuy .modal-body table tr:eq(3) td:eq(1)").text(data.cost);//单价
				$("#myModalbuy .modal-body table tr:eq(4) td:eq(1) small").text("剩"+data.stock+"件");//库存
			}
		});
		//客户
		var customs="<select name='customid'><option value='0' selected='selected'>请选择</option>";
		$.ajax({
			url:"custom/getAllCustom",
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$.each(data,function(i,item){
					customs+="<option value='"+item.id+"'>"+item.name+"</option>";
				});
			}
		});
		customs+="</select>";
		$("#myModalbuy .modal-body table tr:eq(6) td:eq(1)").html(customs);
		//部门
		var depts="<select onchange='getEmp()' name='deptid'><option value='0' selected='selected'>请选择</option>";
		$.ajax({
			url:"user/alldept",
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$.each(data,function(i,item){
					depts+="<option value='"+item.id+"'>"+item.name+"</option>";
				});
			}
		});
		depts+="</select>";
		$("#myModalbuy .modal-body table tr:eq(7) td:eq(1)").html(depts);
		
		$("#myModalbuy").modal("show");
	}
	//员工
	function getEmp(){
		var id = $('#myModalbuy .modal-body table tr:eq(7) td:eq(1) select option:selected').val();  
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
		$("#myModalbuy .modal-body table tr:eq(8) td:eq(1)").html(emps);
	}
	/* $(document).ready(function(){
		$("#myModalbuy .modal-body table tr:eq(7) td:eq(1) select").on("onchange",function(){
			var id = $('#myModalbuy .modal-body table tr:eq(7) td:eq(1) select option:selected').val();  
			alert(id);
		});
	});  */
	
	function getMoney(){
		var money=0;
		var quantity=$("#myModalbuy .modal-body table tr:eq(4) td:eq(1) input").val();
		var price=$("#myModalbuy .modal-body table tr:eq(3) td:eq(1)").text();
		money= Math.round(parseFloat(quantity)* parseFloat(price)*100)/100;
		$("#myModalbuy .modal-body table tr:eq(5) td:eq(1)").html("<input style='width:100px' name='pay' type='text' value='"+money+"' readonly='readonly'>");
	}
</script>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">商品列表</caption>
			<tr>
				<th class="text-center">商品图片</th>
				<th class="text-center">商品名</th>
				<th class="text-center">商品描述</th>
				<th class="text-center">商品价格</th>
				<th class="text-center">库存</th>
				<th class="text-center">折扣</th>
				<th class="text-center">折后价</th>
				<th class="text-center">操作</th>
			</tr>
			<c:forEach items="${pageInfo.list}" var="pro">
				<tr>
					<td id="verticalMiddle"><img
						style="width: 50px; height: 50px;" alt="" src="/pic/${pro.pic}"></td>
					<td id="verticalMiddle">${pro.name}</td>
					<td id="verticalMiddle">${pro.desc}</td>
					<td id="verticalMiddle">${pro.price}$</td>
					<td id="verticalMiddle">${pro.stock}</td>
					<td id="verticalMiddle">${pro.discount!=null?pro.discount:''}</td>
					<td id="verticalMiddle">${pro.cost!=null?pro.cost:''}</td>
					<td id="verticalMiddle">
						<button type="button" onclick="proDetail(${pro.id})"
							class="btn btn-default">详情</button>
						<button type="button" onclick="proDelete(${pro.id})"
							class="btn btn-default">删除</button>
						<button type="button" onclick="proBuy(${pro.id})"
							class="btn btn-default">购买</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="8">
					<!-- 分页 -->
					<div class="pager" style="margin: 0px;">
						<c:if test="${pageInfo!=null}">
							<ul style="margin: 0px;">
								<li><a href="javascript:void(0)" onclick="insertProduct()"
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
							<input type="hidden" id="urlPage" value="order/gobuy" />
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<!-- 添加/修改商品 -->
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
			<form action="order/insertOrupdateProduct" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<input name="id" type="hidden">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td style="width: 120px" class="text-right">商品图片</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">商品名</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">商品描述</td>
							<td class="text-left"><textarea name="desc" rows="3"
									cols="50"></textarea></td>
						</tr>
						<tr>
							<td class="text-right">商品价格</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">库存</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">是否有折扣</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">折后价</td>
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
<!-- 购买 -->
<div class="modal fade" id="myModalbuy" tabindex="-1" role="dialog"
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
					<input name="pid" type="hidden">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td class="text-right">商品图片</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">商品名</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">商品描述</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">单价</td>
							<td class="text-left"></td>
						</tr>
						<tr>
							<td class="text-right">数量</td>
							<td class="text-left"><input onblur="getMoney()" type="text" name="quantity">&nbsp;&nbsp;&nbsp;<small></small></td>
						</tr>
						<tr>
							<td class="text-right">总价</td>
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


