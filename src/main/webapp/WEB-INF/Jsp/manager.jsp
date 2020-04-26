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

 	function allServe() {
		$.ajax({
			url:"serve/selectServe",
			type:"GET",
			dataType:"json",
			success:function(data){
				$("#serverManager tr:gt(1)").remove();
				var $serve="";
				if(data.length>0){
					$.each(data,function(i,item){
						$serve+="<tr><td>"+item.id+"</td><td>"+item.content+"</td><td>"+item.createTime+"</td><td>";
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
 	
 	function findServe() {
		var stauts=$("[name='stauts']").val();
		if(stauts=="3"){
			alert("请选择需要查询的类型!");
		}else{
			$.ajax({
				url:"serve/selectServe",
				data:"stauts="+stauts,
				type:"GET",
				dataType:"json",
				success:function(data){
					$("#serverManager tr:gt(1)").remove();
					var $serve="";
					if(data.length>0){
						$.each(data,function(i,item){
							$serve+="<tr><td>"+item.id+"</td><td>"+item.content+"</td><td>"+item.createTime+"</td><td>";
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
 	
 	function insertServe() {
		//先查询所有客户
		$.ajax({
			url:"custom/getAllCustom",
			type:"GET",
			dataType:"json",
			success:function(data){
				$("#myModalServe [name='custom_id'] option:gt(0)").remove();
				var $custom="";
				$.each(data,function(i,item){
					$custom+="<option value='"+item.id+"'>"+item.name+"</option>";
				});
				$("#myModalServe [name='custom_id'] option:eq(0)").after($custom);
			}
			
		});
		//弹出模态框
		$("#myModalServe").modal("show");
	}
</script>
<style type="text/css">
 
</style>


<div class="row">
	<div class="col-md-12">
		<table id="serverManager" class="table table-bordered table-hover text-center">
			<caption style="font-weight: bold; font-size: 20px;">服务管理</caption>
			<tr>
				<th colspan="10">
					<div class="input-group" style="">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="insertServe()">添加</button>
						</span>
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="allServe()">全部</button>
						</span>
						<select name="stauts" class="form-control">
							<option value="3" selected="selected">请选择</option>	
							<option value="0">未分配</option>
							<option value="1">已分配</option>
							<option value="2">已完成</option>
						</select> 
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="findServe()">查询</button>
						</span>
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

<!-- 模态框 -->
<div class="modal fade" id="myModalServe" tabindex="-1" role="dialog"
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
			<form action="serve/insertServe" method="post"
				enctype="multipart/form-data" onsubmit="return sure()">
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<tr>
							 <td>申请客户</td>
							 <td>
							 	<select name="custom_id">
							 		<option value="0" selected="selected">请选择</option>
							 	</select>
							 </td>
						</tr>
						<tr>
							 <td>客户需求</td>
							 <td><textarea name="content" rows="3" cols="50"></textarea></td>
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