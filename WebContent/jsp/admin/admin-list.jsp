<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css"
	href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css"
	href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css"
	href="static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>管理员信息</title>
</head>
<body>
<jsp:include page="_header.jsp" flush="true" ></jsp:include>
<jsp:include page="_menu.jsp" flush="true" ></jsp:include>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		管理员<span class="c-gray en">&gt;</span> 管理员管理 <a
			class="btn btn-success radius r"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="text-c"></div>
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"> <a href="javascript:;" onClick="delAdmins()"
				class="btn btn-danger radius"> <i class="Hui-iconfont">&#xe6e2;</i>批量删除
			</a> <a class="btn btn-primary radius" data-title="添加管理员"
				onclick="adminAdd('添加管理员','jsp/admin/admin-add.jsp','','','510')"
				href="javascript:;"> <i class="Hui-iconfont">&#xe600;</i> 添加管理员
			</a>
			</span> <span class="l" style="margin-left: 20px;"> </span>


			<span class="r">共有数据：<strong style="font-size: 25px;">${allNumber}</strong>
				条 &nbsp;&nbsp; &nbsp;&nbsp;
				<li class="dropDown dropDown_hover"><a href=""
					class="dropDown_A" onclick="return false"> <i
						class="Hui-iconfont"
						style="font-size: 25px; color: #5a98de; margin-right: 100px; margin-top: 10px;">&#xe641;</i></a>
					<ul class="dropDown-menu menu radius box-shadow">
						<li><a href="javascript:;" onClick="impAdmins('onePage')">导出本页</a></li>
						<li><a href="javascript:;" onClick="impAdmins('allPage')">全部导出</a></li>

					</ul>
					</li>
			</span>


		</div>
		<div class="mt-20">
			<table style="table-layout: fixed;" 
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" value="" id="delAll"
							name="" onclick="deleteAll()"></th>
						<th width="40">ID</th>
						<th width="80">账号</th>						
						<th width="80">密码</th>
						<th width="60">权限</th>
						<th width="60">状态</th>					
						<th width="90">操作</th>
                        

					</tr>
				</thead>
				<tbody>

					<c:forEach var="admin" items="${adminList}" varStatus="i" step="1">
						<tr class="text-c">
							<td><input type="checkbox" class="deleteOne"
								onclick="deleteOne()" value="${admin.gaId }"></td>
								<td>${admin.gaId }</td>
							<td>${admin.gaName }</td>
							<td class="myTit">${admin.gaPassword }</td>
							<c:if test="${admin.gaRank ==1}">
							<td class="td-status2">普通管理员</td>
							</c:if>
							<c:if test="${admin.gaRank ==9}">
							<td class="td-status2"><span style="color: #DAA520;">超级管理员</span></td> 
							</c:if>	
							 <c:if test="${admin.gaStatus==0}">
	       			    	  <td class="td-status">
	     			      	 <span class="label label-defaunt radius">已停用</span>
	     			      	 </td>
	     		      	 	</c:if>
	     		      	 	 <c:if test="${admin.gaStatus==1}">
	     		      	 	  <td class="td-status">
	     			      	 <span class="label label-success radius">已启用</span>
	     			      	 </td>
	      			     	 </c:if>
	           	             
			
							
							<td class="td-manage">
							<c:if test="${admin.gaStatus==1}">	
	     			      	<a  class="td-manage2" style="text-decoration:none" href="javascript:;" 
								onClick="stopAndStart(${admin.gaStatus},${admin.gaId},this)"
								href="javascript:;" title="停用">
								<i style="color:#dd514c;" class="Hui-iconfont">&#xe631;</i>
								</a>
	     		      	 	</c:if>
	     		      	 	 <c:if test="${admin.gaStatus==0}">
	     			      	   <a class="td-manage2"  style="text-decoration:none" href="javascript:;" 
								onClick="stopAndStart(${admin.gaStatus},${admin.gaId},this)"
								href="javascript:;" title="启用"> 
								<i style="color:green;" class="Hui-iconfont">&#xe6e1;</i>
								</a>
	      			     	 </c:if>
	      			     	 <c:if test="${admin.gaRank ==9}">	
	      			     	 	<a style="text-decoration:none" href="javascript:;" 
								onClick="upAndDown(${admin.gaRank},${admin.gaId},this)"
								href="javascript:;" title="降低权限">
								<i class="Hui-iconfont" >&#xe674;</i>
								</a>
	     		      	 	</c:if>
	     		      	 	
	     		      	 	 <c:if test="${admin.gaRank ==1}">
	     			      	   <a style="text-decoration:none" href="javascript:;" 
								onClick="upAndDown(${admin.gaRank},${admin.gaId},this)"
								href="javascript:;" title="提升权限"> 
								<i class="Hui-iconfont" style="color:#5a98de;">&#xe679;</i>
								</a>
	      			     	 </c:if>
		                        <a title="删除管理员"
								onclick="delAdmins(${admin.gaId})" 
								href="javascript:;" style="text-decoration: none"
								> <i style="color:#5a98de;" class="Hui-iconfont">&#xe6e2;</i>
								</a>	
								 <a title="修改密码" style="text-decoration:none"
                                  onClick="changePassword('修改密码',${admin.gaId})" href="javascript:;" >
                                 <i style="color:#5a98de;" class="Hui-iconfont">&#xe63f;</i>
                                 </a>
						    </td>
                            
						</tr>
					</c:forEach>

				</tbody>
			</table>
			<div id="DataTables_Table_0_wrapper"
				class="dataTables_wrapper no-footer">
				<div class="dataTables_paginate paging_full_numbers" id="tablePage">
					<a class="paginate_button first disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0"
						id="firstPage" href="adminList.action?nowPage=1">第一页</a> <a
						class="paginate_button previous disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
						id="previousPage" href="adminList.action?nowPage=${nowPage-1 }">上一页</a>
					<span><a class="paginate_button current"
						aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${nowPage }/${allPage }</a></span>
					<a class="paginate_button next disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
						id="nextPage" href="adminList.action?nowPage=${nowPage+1 }">下一页</a>
					<a class="paginate_button last disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0"
						id="lastPage" href="adminList.action?nowPage=${allPage}">最后一页</a>
				</div>
			</div>


		</div>
	</div>
	</section>
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
	<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript"
		src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
	<script type="text/javascript"
		src="lib/datatables/1.10.15/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript">
	/*修改密码*/
	function changePassword(title,id) {
		layer_show(title, 'changeAdminPassword.action?adminId=' + id, 600, 270);

	}
		/*添加管理员*/
		function adminAdd(title, url, id, w, h) {
			layer_show(title, url, w, 500);

		}
		/*删除-全选与取消全选*/
		var check = $(".deleteOne");
		var checkNum = 0;
		function deleteAll() {
			if ($('#delAll').is(':checked')) {
				$(".deleteOne").prop("checked", true);//全选		 
				checkNum = check.length;

			} else {
				$(this).prop("checked", false);
				$(".deleteOne").prop("checked", false);//取消全选 		
				checkNum = 0;
			}
		}
		function deleteOne() {
			checkNum = 0;
			$(".deleteOne").each(function() {
				if ($(this).is(':checked')) {
					checkNum++;
				}
			});
			if (checkNum == check.length) {
				$("#delAll").prop("checked", true);
			} else {
				$("#delAll").prop("checked", false)
			}
		}
		//删除操作
		function delAdmins(id) {
			var ch = "";
			var dnumber = 0;
			  if(id!=null){
	            	ch = ch + id+ ",";
					dnumber++;
	            }
			  else{
			$(".deleteOne").each(function() {
				if ($(this).is(':checked')) {
					ch = ch + $(this).val() + ",";
					dnumber++;

				}
			});
			  }
			if (dnumber == 0) {
				layer.confirm('<i class="Hui-iconfont" style="font-size:30px; color:#fdd107;" >&#xe656;</i>,至少选择一条数据哦！');
			} else {
				layer.confirm('确认要删除' + dnumber + '条数据吗？', function(index) {
					$.ajax({
						type : 'POST',
						url : 'deleteAdmins.action?adminsId=' + ch,
						success : function(data) {
							window.location.reload(); 
							$(".deleteOne").prop("checked", false);//取消全选  
							layer.msg('已删除!', {
								icon : 1,
								time : 1000
							});
						},
						error : function(data) {

							layer.msg('删除失败!', {
								icon : 2,
								time : 1000
							});
						},
					});
				});
			}
		}
		
		/* 导出用户*/
		function impAdmins(chose) {
			var tip;
			if (chose == "onePage") {
				tip = "本页";
			} else {
				tip = "全部";
			}

			layer.confirm('确认要导出' + tip + '数据吗？', function(index) {
				$.ajax({
					type : 'POST',
					url : 'importAdmins.action?importChose=' + chose,
					success : function(data) {
						/* if(data!=null){
							alert(data); 
							window.open(data);
							
						}  */

						layer.msg('导出成功!<p>' + data + '</p>', {
							icon : 1,
							time : 2000
						});
					},
					error : function(data) {
						layer.msg('导出失败!', {
							icon : 2,
							time : 2000
						});
					},
				});
			});

		}
		//隐藏密码
		$(".myTit").each(function(){ 
		           var str="";
		           str="******"; 
		         
		           $(this).html(' <a  title="'+$(this).text()+'"style="text-decoration: none"	onclick="return false"	href="javascript:;" >'+str+'</a>');                   //将替换的值赋值给当前对象
		          
		    });
		//停用与启用
		function stopAndStart(chose,id,obj) {
			var tip;
			if (chose == 1) {
				tip="停用";
			} else {
				tip="启用";	
			} 

			layer.confirm('确认要' + tip + '该管理员吗？', function(index) {
				$.ajax({
					type : 'POST', 
					url : 'stopAdmin.action?adminId=' + id,  
					success : function(data) { 
						if (chose == 1) {
							
							$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="stopAndStart(0,'+id+',this)" href="javascript:;" title="启用"><i style="color:green;" class="Hui-iconfont">&#xe6e1;</i></a>');
							$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已停用</span>'); 
							$(obj).remove();
						} else {
							
							$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="stopAndStart(1,'+id+',this)" href="javascript:;" title="停用"><i style="color:#dd514c;" class="Hui-iconfont">&#xe631;</i></a>');
							$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
							$(obj).remove();
						}
						
						layer.msg(tip+'成功!', {
							icon : 1,
							time : 2000
						});

					},
					error : function(data) {
						layer.msg(tip+'失败!', {
							icon : 2,
							time : 2000
						});
					},
				});
			});

		}
		//提升与降低
		function upAndDown(chose,id,obj) {
			var tip;
			if (chose == 1) {
				tip="提升";
			} else {
				tip="降低";	
			} 

			layer.confirm('确认要' + tip + '该管理员权限吗？', function(index) {
				$.ajax({
					type : 'POST', 
					url : 'upAndDownAdmin.action?adminId=' + id,  
					success : function(data) { 
						if (chose == 1) {
							
							$(obj).parents("tr").find(".td-manage2").after('<a style="text-decoration:none" onClick="upAndDown(9,'+id+',this)" href="javascript:;" title="降低权限"><i class="Hui-iconfont">&#xe674;</i></a>');
							$(obj).parents("tr").find(".td-status2").html('<span style="color: #DAA520;">超级管理员</span>'); 
							$(obj).remove();
						} else {
							
							$(obj).parents("tr").find(".td-manage2").after('<a style="text-decoration:none" onClick="upAndDown(1,'+id+',this)" href="javascript:;" title="提升权限"><i class="Hui-iconfont"style="color:#5a98de;">&#xe679;</i></a>');
							$(obj).parents("tr").find(".td-status2").html('普通管理员 ');
							$(obj).remove();
						}
						
						layer.msg(tip+'成功!', {
							icon : 1,
							time : 2000
						});

					},
					error : function(data) {
						layer.msg(tip+'失败!', {
							icon : 2,
							time : 2000
						});
					},
				});
			});

		}
	</script>
</body>
</html>
