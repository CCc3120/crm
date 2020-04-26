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
  	
	function findServe() {
		var id= $("#serve_id").val();
		$.ajax({
			url:"serve/findById",
			data:"id="+id,
			type:"GET",
			dataType:"json",
			success:function(data){
				$("#serverManager tr:gt(1)").remove();
				var $serve="";
				if($.isEmptyObject(data)){
					$serve+="<tr><td colspan='10'>未找到相关记录!</td></tr>";
				}else{
					if(data.stauts=="未分配"){
						$serve+="<tr><td><a onclick='distServe("+data.id+")' href='javascript:void(0)' style='text-decoration:none;color:black;'>"+data.id+"</a></td><td>"+data.content+"</td><td>"+data.createTime+"</td><td>";
					}else if(data.stauts=="已分配"){
						$serve+="<tr><td><a onclick='updateServe("+data.id+")' href='javascript:void(0)' style='text-decoration:none;color:black;'>"+data.id+"</a></td><td>"+data.content+"</td><td>"+data.createTime+"</td><td>";
					}else{
						$serve+="<tr><td>"+data.id+"</td><td>"+data.content+"</td><td>"+data.createTime+"</td><td>";
					}
					if(data.evaluation==null){
						$serve+="</td><td>";
					}else{
						$serve+=data.evaluation+"</td><td>";
					}
					if(data.distributionTime==null){
						$serve+="</td><td>";
					}else{
						$serve+=data.distributionTime+"</td><td>";
					}
					if(data.endTime==null){
						$serve+="</td><td>";
					}else{
						$serve+=data.endTime+"</td><td>";
					}
					$serve+=data.custom.name+"</td><td>";
					if(data.emp==null){
						$serve+="</td><td>";
					}else{
						$serve+=data.emp.name+"</td><td>";
					}
					if(data.dept==null){
						$serve+="</td><td>";
					}else{
						$serve+=data.dept.name+"</td><td>";
					}
					$serve+=data.stauts+"</td></tr>";
				}
				$("#serverManager tr:eq(1)").after($serve);
			}
		});
	}
	
	function dynamicFind(obj) {
		var stauts=$("[name='stauts']").val();
		if(stauts=="3"){
			$("#serverManager tr:gt(1)").remove();
		}else{
			$("#serverManager tr:gt(1)").remove();
			$.ajax({
				url:"serve/selectServe",
				data:"stauts="+stauts,
				type:"GET",
				dataType:"json",
				success:function(data){
					var $serve="";
					if(data.length>0){
						$.each(data,function(i,item){
							if(item.stauts=="未分配"){
								$serve+="<tr><td><a onclick='distServe("+item.id+")' href='javascript:void(0)' style='text-decoration:none;color:black;'>"+item.id+"</a></td><td>"+item.content+"</td><td>"+item.createTime+"</td><td>";
							}else if(item.stauts=="已分配"){
								$serve+="<tr><td><a onclick='updateServe("+item.id+")' href='javascript:void(0)' style='text-decoration:none;color:black;'>"+item.id+"</a></td><td>"+item.content+"</td><td>"+item.createTime+"</td><td>";
							}else{
								$serve+="<tr><td>"+item.id+"</td><td>"+item.content+"</td><td>"+item.createTime+"</td><td>";
							}
							if(item.evaluation==null){
								$serve+="</td><td>";
							}else{
								$serve+=item.evaluation+"</td><td>";
							}
							if(item.distributionTime==null){
								$serve+="</td><td>";
							}else{
								$serve+=item.distributionTime+"</td><td>";
							}
							if(item.endTime==null){
								$serve+="</td><td>";
							}else{
								$serve+=item.endTime+"</td><td>";
							}
							$serve+=item.custom.name+"</td><td>";
							if(item.emp==null){
								$serve+="</td><td>";
							}else{
								$serve+=item.emp.name+"</td><td>";
							}
							if(item.dept==null){
								$serve+="</td><td>";
							}else{
								$serve+=item.dept.name+"</td><td>";
							}
							$serve+=item.stauts+"</td></tr>";
						});
					}else{
						$serve+="<tr><td colspan='10'>未找到相关记录!</td></tr>";
					}
					$("#serverManager tr:eq(1)").after($serve);
				}
			});
		}
	}
	function updateServe(id) {
		//$("#myModalServeUpdate")
		$.ajax({
			url:"serve/findById",
			data:"id="+id,
			type:"GET",
			async:false, //同步
			dataType:"json",
			success:function(data){
				$("#myModalServeUpdate input[name='serveid']").val("");
				$("#myModalServeUpdate table tr:lt(2) td:eq(1)").text("");
				
				$("#myModalServeUpdate input[name='serveid']").val(data.id);
				$("#myModalServeUpdate table tr:eq(0) td:eq(1)").text(data.custom.name);
				$("#myModalServeUpdate table tr:eq(1) td:eq(1)").text(data.content);
			}
		});
		$("#myModalServeUpdate").modal("show"); 
	}
	
	function distServe(id) {
		$.ajax({
			url:"serve/findById",
			data:"id="+id,
			type:"GET",
			async:false, //同步
			dataType:"json",
			success:function(data){
				$("#myModalServeDist input[name='serveid']").val("");
				$("#myModalServeDist table tr:lt(2) td:eq(1)").text("");
				
				$("#myModalServeDist input[name='serveid']").val(data.id);
				$("#myModalServeDist table tr:eq(0) td:eq(1)").text(data.custom.name);
				$("#myModalServeDist table tr:eq(1) td:eq(1)").text(data.content);
			}
		});
		
		$.ajax({
			url:"user/alldept",
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$("[name='deptid'] option:gt(0)").remove();
				$("[name='empid'] option:gt(0)").remove();
				var $dept="";
				$.each(data,function(i,item){
					$dept+="<option value='"+item.id+"'>"+item.name+"</option>";
				});
				$("[name='deptid'] option:eq(0)").after($dept);
			}
		});
		
		$("#myModalServeDist").modal("show"); 
	}
	
	function findEmp() {
		var id=$("#myModalServeDist table select option:selected").val();
		$.ajax({
			url:"user/deptemp",
			data:"id="+id,
			type:"GET",
			async:false, //同步
			dataType:"json",//响应的类型
			success:function(data){
				$("[name='empid'] option:gt(0)").remove();
				var emp="";
				if(data.length>0){
					$.each(data,function(i,item){
						emp+="<option value='"+item.id+"'>"+item.name+"</option>";
					});
					$("[name='empid'] option:eq(0)").after(emp);
				}else{
					alert("该部门下暂无员工");
				}
			}
		});
	}
</script>
<style type="text/css">
</style>


<div class="row">
	<div class="col-md-12">
		<table id="serverManager"
			class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">服务管理</caption>
			<tr>
				<th colspan="10">
					<div class="input-group" style="">
						<input type="text" id="serve_id" class="form-control"
							placeholder="请输入查询的服务编号"> <span class="input-group-btn">
							<button class="btn btn-default" type="button"
								onclick="findServe()">查询</button>
						</span> <select name="stauts" onchange="dynamicFind(this)"
							class="form-control">
							<option value="3" selected="selected">请选择</option>
							<option value="0">未分配</option>
							<option value="1">已分配</option>
							<option value="2">已完成</option>
						</select>
					</div>
				</th>
			</tr>
			<tr>
				<th class="text-center">服务编号</th>
				<th class="text-center">服务需求</th>
				<th class="text-center">申请时间</th>
				<th class="text-center">评价</th>
				<th class="text-center">分配时间</th>
				<th class="text-center">完成时间</th>
				<th class="text-center">申请客户</th>
				<th class="text-center">员工名</th>
				<th class="text-center">部门名</th>
				<th class="text-center">状态</th>
			</tr>
		</table>
	</div>
</div>

<div class="modal fade" id="myModalServeDist" tabindex="-1"
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
			<form action="serve/distServe" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<input type="hidden" name="serveid">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td>申请客户</td>
							<td></td>
						</tr>
						<tr>
							<td>客户需求</td>
							<td></td>
						</tr>
						<tr>
							<td>部门</td>
							<td><select onchange="findEmp()" name="deptid">
									<option value="0" selected="selected">请选择</option>
							</select></td>
						</tr>
						<tr>
							<td>员工</td>
							<td><select name="empid">
									<option value="0" selected="selected">请选择</option>
							</select></td>
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

<div class="modal fade" id="myModalServeUpdate" tabindex="-1"
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
			<form action="serve/updateServe" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<input type="hidden" name="serveid">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							<td>申请客户</td>
							<td></td>
						</tr>
						<tr>
							<td>客户需求</td>
							<td></td>
						</tr>
						<tr>
							<td>服务评价</td>
							<td>
								<input id="one" name="evaluation" value="1" type="radio"><label for="one">一星</label>
								<input id="two" name="evaluation" value="2" type="radio"><label for="two">二星</label>
								<input id="three" name="evaluation" value="3" type="radio"><label for="three">三星</label>
								<input id="four" name="evaluation" value="4" type="radio"><label for="four">四星</label>
								<input id="five" name="evaluation" value="5" type="radio"><label for="five">五星</label>
							</td>
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