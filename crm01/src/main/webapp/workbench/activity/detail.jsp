<%@ page contentType="text/html;charset=utf-8" language="java" %>
<% String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
		//动态加载添加删除键
		$("#remarkBody").on("mouseover",".remarkDiv",function(){
			$(this).children("div").children("div").show();
		})
		$("#remarkBody").on("mouseout",".remarkDiv",function(){
			$(this).children("div").children("div").hide();
		})

		RemarkList();
		$("#saveRemark").click(function (){

			$.ajax({
				url: "workbench/activity/saveRemark.do",
				dataType: "json",
				data:{
					"id":"${a.id}",
					"noteContent":$.trim($("#remark").val())
				},
				type: "post",
				success: function (data) {
					/**
					 * data{"success":true.{ar}}
					 */
					if(data.success){
						var html="";
						html+='<div id="'+data.ar.id+'" class="remarkDiv" style="height: 60px;">';
						html+='<img title="" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
						html+='<div style="position: relative; top: -40px; left: 40px;" >';
						html+='<h5 id="e'+data.ar.id+'">'+data.ar.noteContent+'</h5>';
						html+='<font color="gray">市场活动</font> <font color="gray">-</font> <b>${a.name}</b> <small style="color: gray;id="s"'+data.ar.id+'"> '+data.ar.createTime+'由'+data.ar.createBy+'</small>';
						html+='<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
						html+='<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" onclick="editRemark(\''+data.ar.id+'\')"  style="font-size: 20px; color: #FF0000;"></span></a>';
						html+='&nbsp;&nbsp;&nbsp;&nbsp;';//											动态拼接的参数需要用引号引起来，\',\用来转义		\'  '+e.id+'    \'
						html+='<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" onclick="deleteRemark(\''+data.ar.id+'\')" style="font-size: 20px; color: #FF0000;"></span></a>';
						html+='</div>';
						html+='</div>';
						html+='</div>';
						$("#append").append(html);
						$("#remark").val("");
					}
					else{
						alert("添加失败");
					}
				}

			})
		})



	});

	function RemarkList(){
		$.ajax({
			url: "workbench/activity/getRemarkListById.do",
			dataType: "json",
			data:{
				"id":"${a.id}"
			},
			type: "get",
			success: function (data) {
				//[{备注1},{备注2},{3}]
				var html="";

				$.each(data,function (i,e){
					html+='<div id="'+e.id+'" class="remarkDiv" style="height: 60px;">';
					html+='<img title="" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
					html+='<div style="position: relative; top: -40px; left: 40px;" >';
					html+='<h5 id="e'+e.id+'">'+e.noteContent+'</h5>';
					html+='<font color="gray">市场活动</font> <font color="gray">-</font> <b>${a.name}</b> <small style="color: gray;" id="s"'+e.id+'> '+(e.editFlag==0?e.createTime:e.editTime)+'由'+(e.editFlag==0?e.createBy:e.editBy)+'</small>';
					html+='<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
					html+='<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" onclick="editRemark(\''+e.id+'\')"  style="font-size: 20px; color: #FF0000;"></span></a>';
					html+='&nbsp;&nbsp;&nbsp;&nbsp;';//											动态拼接的参数需要用引号引起来，\',\用来转义		\'  '+e.id+'\'
					html+='<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" onclick="deleteRemark(\''+e.id+'\')" style="font-size: 20px; color: #FF0000;"></span></a>';
					html+='</div>';
					html+='</div>';
					html+='</div>';
				})
				$("#remarkDiv").before(html);
			}

		})

	}
	function  deleteRemark(id){
		$.ajax({
			url: "workbench/activity/deleteRemark.do",
			dataType: "json",
			data:{
				"id":id
			},
			type: "get",
			success: function (data) {
				if(data.success){
					//RemarkList();//删除成功刷新备注列表
					$("#"+id).remove();

				}
				else{
					alert("删除失败");
				}

			}

		})
	}
	function  editRemark(id){
		$("#editRemarkModal").modal("show");
		var noteContent=$("#e"+id).html();
		$("#noteContent").val(noteContent);
		$("#updateRemarkBtn").click(function (){
			$.ajax({
				url: "workbench/activity/updateRemark.do",
				dataType: "json",
				data:{
					"id":id,
					"noteContent":$.trim($("#noteContent").val())
				},
				type: "get",
				success: function (data) {
					/**
					 * data{"success":true,{ar}}
					 */

					if(data.success){
						$("#e"+id).html(data.ar.noteContent);

						$("#s"+id).html(data.ar.editTime+" 由"+data.ar.editBy);

						//更新内容之后，关闭模态窗口
						$("#editRemarkModal").modal("hide");


					}
					else{

						alert("修改失败");
					}

				}

			})

		})

	}

</script>

</head>
<body>

	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">修改备注</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="noteContent"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
                </div>
            </div>
        </div>
    </div>



	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>市场活动-${a.name} <small>${a.startDate} ~ ${a.endDate}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.name}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.startDate}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.endDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.cost}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-18 10:10:10</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-19 10:10:10</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${a.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;" id="remarkBody">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		<!-- 备注1 -->
		<div id="append">

		</div>
		

		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveRemark">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>