<%@ page contentType="text/html;charset=utf-8" language="java" %>
<% String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>


<script type="text/javascript">


		$(function(){
			//日期插件
			$("#addBtn").click(function () {

				$(".time").datetimepicker({
					minView: "month",
					language: 'zh-CN',//语言包
					format: 'yyyy-mm-dd',//格式
					autoclose: true,
					todayBtn: true,
					pickerPosition: "bottom-left"
				})
				});

			pagelist(1,2);

			//加载创建时候的所有者信息，并在加载完毕后打开模态窗口
			$.ajax({
				url: "workbench/activity/getUserList.do",
				dataType: "json",
				type: "get",
				success: function (data) {
					var html = "<option></option>";
					$.each(data, function (i, e) {
						html += "<option value='"+e.id+"'>"+e.name+"</option>";
					})
					$("#create-owner").html(html);


					var id="${user.id}";

					$("#create-owner").val(id);

					//$("#createActivityModal").modal("show");
				}
			})
            //提交要保存的信息，通过ajax请求保存到后端数据库中，此时会调用pagelist（）方法
			$("#submit").click(function (){
				$.ajax({
					url: "workbench/activity/save.do",
					dataType: "json",
					type: "post",
					data:{
						"owner" : $.trim($("#create-owner").val()),
						"name" : $.trim($("#create-name").val()),
						"startDate" : $.trim($("#create-startDate").val()),
						"endDate" : $.trim($("#create-endDate").val()),
						"cost" : $.trim($("#create-cost").val()),
						"description" : $.trim($("#create-description").val()
						)},

					success: function (data) {
						if(data.success){
							$("#activityAddForm")[0].reset();
							$("#createActivityModal").modal("hide");
							pagelist(1,2);
						}else{
							alert("添加失败");
						}

						//$("#createActivityModal").modal("show");
					}
				})

			});

			//点击查询操作，通过ajax请求局部刷新页面
			$("#search").click(function (){
                              //将查询条件保存到隐藏区域
				$("#hidden-name").val($.trim($("#search-name").val()));
				$("#hidden-owner").val($.trim($("#search-owner").val()));
				$("#hidden-startDate").val($.trim($("#search-startDate").val()));
				$("#hidden-endDate").val($.trim($("#search-endDate").val()));
					pagelist(1,2);
		 								 })

			//复选框的全选和取消全选
			$("#qx").click(function (){//全选
				$("input[name=xz]").prop("checked",this.checked);
			})
		//动态生成的元素，要以on方法形式触发
		//	语法$(需要绑定的有效的外层方法).on("绑定事件的方式"，需要绑定的元素的juery对象，回调函数)
			$("#activityBody").on("click",$("input[name=xz]"),function (){
				if($("input[name=xz]").length==$("input[name=xz]:checked").length){
					$("#qx").prop("checked",true);
				}
				else{
					$("#qx").prop("checked",false);
				}
			})

			$("#delete-btn").click(function (){
				var $xz=$("input[name=xz]:checked");
				var param="";
				if($xz.length==0){
					alert("请选择要删除的项");
				}
				else {

					for(var i=0;i<$xz.length;i++){
						param+="id="+$($xz[i]).val();
						if(i<$xz.length-1){
							param+="&";
						}
					}
					if(confirm("确定删除所选中的项吗？")){
						$.ajax({
							url: "workbench/activity/delete.do",
							dataType: "json",
							type: "get",
							data:param,
							success: function (data) {
								if(data.success){
									//删除操作完成后进行页面的局部刷新
									pagelist(1,2);
								}
								else {
									alert("删除失败！")
								}
							}
						})
					}
				}


			})//点击删除按钮的一系列操作

			/*
			需要在以下清空调用pagelist
			点击市场活动页面加载时
			点击创建，修改删除时
			点击查询时
			点击分页操作时
			 */
			function pagelist(pageNo,pageSize){
				$("#qx").prop("checked",false);
				//pageNo每页页码，pageSize每页数量
				//取出隐藏域的值
				$("#search-name").val($.trim($("#hidden-name").val()));
				$("#search-owner").val($.trim($("#hidden-owner").val()));
				$("#search-startDate").val($.trim($("#hidden-startDate").val()));
				$("#search-endDate").val($.trim($("#hidden-endDate").val()));
				$.ajax({
					url: "workbench/activity/pageList.do",
					dataType: "json",
					data:{
						"pageNo":pageNo,
						"pageSize":pageSize,
						"name":$.trim($("#search-name").val()),
						"owner":$.trim($("#search-owner").val()),
						"startDate":$.trim($("#search-startDate").val()),
						"endDate":$.trim($("#search-endDate").val())
					},
					type: "get",
					success: function (data) {

						/*
                                    date 返回的数据应该包含总记录数，和市场活动信息
                                      {"total":100},"dataList":[{市场活动1},{市场活动2}]]
                         */
					var html="";
					$.each(data.datalist,function (i,e){
							html+='<tr class="active">';
							html+='<td><input type="checkbox" name="xz" value="'+e.id+'"/></td>';
							html+='<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.jsp\';">'+e.name+'</a></td>';
							html+='<td>'+e.owner+'</td>';
							html+='<td >'+e.startDate+'</td>';
							html+='<td >'+e.endDate+'</td>';
							html+='</tr>';

					})
						$("#activityBody").html(html);

						var totalPages=data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
						$("#activityPage").bs_pagination({
							currentPage: pageNo, // 页码
							rowsPerPage: pageSize, // 每页显示的记录条数
							maxRowsPerPage: 20, // 每页最多显示的记录条数
							totalPages: totalPages, // 总页数
							totalRows: data.total, // 总记录条数

							visiblePageLinks: 3, // 显示几个卡片

							showGoToPage: true,
							showRowsPerPage: true,
							showRowsInfo: true,
							showRowsDefaultInfo: true,

							onChangePage : function(event, data){
								pagelist(data.currentPage , data.rowsPerPage);
							}
						});

					}

				})

			}

			$("#edit-btn").click(function (){

				var $xz=$("input[name=xz]:checked");
				if($xz.length==0){
					alert("请选择需要修改的信息");
				}
				else if($xz.length>1){
					alert("只能选择一条信息作为修改项")
				}else{
					var id=$xz.val();
					$("#editActivityModal").modal("show");

					$.ajax({
						url: "workbench/activity/getUserListAndActivity.do",
						dataType: "json",
						type: "get",
						data:{
							"id":id
						},
						success: function (data) {
							/*
							date:{"userList":[{user1},{user2}...],"activity":activity}
							 */

							var html = "<option></option>";
							$.each(data.userList, function (i, e) {
								html += "<option value='"+e.id+"'>"+e.name+"</option>";
							})
							$("#edit-owner").html(html);
							var owner=data.activity.owner;
							$("#edit-owner").val(owner);

							$("#edit-name").val(data.activity.name);
							$("#edit-hidden-id").val(id);
							$("#edit-hidden-owner").val(data.activity.owner);
							$("#edit-startDate").val(data.activity.startDate);
							$("#edit-endDate").val(data.activity.endDate);
							$("#edit-cost").val(data.activity.cost);
							$("#edit-description").val(data.activity.description);

							//$("#createActivityModal").modal("show");

							//$("#createActivityModal").modal("show");
						}
					})
					//点击更新进行的ajax操作。
					update();
				}

			})

			function update(){
				var name="${user.name}";
				$("#update-btn").click(function (){
					$.ajax({
						url: "workbench/activity/update.do",
						dataType: "json",
						type: "get",
						data:{
							"username":name,
							"id":$("#edit-hidden-id").val(),
							"owner":$("#edit-hidden-owner").val(),
							"name":$("#edit-name").val(),
							"startDate":$("#edit-startDate").val(),
							"endDate":$("#edit-endDate").val(),
							"description":$("#edit-description").val(),
							"cost":$("#edit-cost").val()
						},
						success: function (data) {
							if(data.success){
								pagelist(1,2);
							}
							else{
								alert("信息修改失败，请重新尝试");
							}
							$("#editActivityModal").modal("hide");
						}
					})
				})
			}


		});

	
</script>
</head>
<body>
//创建隐藏区域保存值
<input type="hidden" id="hidden-name"/>
<input type="hidden" id="hidden-owner"/>
<input type="hidden" id="hidden-startDate"/>
<input type="hidden" id="hidden-endDate"/>

<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal" role="form">
						<input type="hidden" id="edit-hidden-id"/>
						<input type="hidden" id="edit-hidden-owner"/>
					<div class="form-group">
						<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-owner" >

							</select>
						</div>
						<label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-name" >
						</div>
					</div>

					<div class="form-group">
						<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control time" id="edit-startDate" readonly="readonly" >
						</div>
						<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control time" id="edit-endDate" readonly="readonly" >
						</div>
					</div>

					<div class="form-group">
						<label for="edit-cost" class="col-sm-2 control-label">成本</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-cost" >
						</div>
					</div>

					<div class="form-group">
						<label for="edit-describe" class="col-sm-2 control-label">描述</label>
						<div class="col-sm-10" style="width: 81%;">
							<!--textarea文本框当作表单类型去使用，在获取值时用.val()，而不是.html()-->
							<textarea class="form-control" rows="3" id="edit-description"></textarea>
						</div>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="update-btn" >更新</button>
			</div>
		</div>
	</div>
</div>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="activityAddForm">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group" id="addBtn">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" readonly="readonly" id="create-startDate">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" readonly="readonly" id="create-endDate">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="submit"  >保存</button>
				</div>
			</div>
		</div>
	</div>
	

	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon" id="search-owner">所有者</div>
				      <input class="form-control" type="text">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon" id="search-startDate">开始日期</div>
					  <input class="form-control time" readonly="readonly" type="text" id="startTime" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon" id="search-endDate">结束日期</div>
					  <input class="form-control time" readonly="readonly" type="text" id="endTime">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="search">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal"><span class="glyphicon glyphicon-plus" ></span> 创建</button>
				  <button type="button" class="btn btn-default" id="edit-btn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="delete-btn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td >开始日期</td>
							<td >结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">


					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>