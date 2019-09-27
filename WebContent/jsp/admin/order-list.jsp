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
<title>订单信息</title>
</head>
<body>
<jsp:include page="_header.jsp" flush="true" ></jsp:include>
<jsp:include page="_menu.jsp" flush="true" ></jsp:include>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		订单管理 <span class="c-gray en">&gt;</span> 订单列表 <a
			class="btn btn-success radius r"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="text-c">
		 

			<input type="text" id="searchBtn"  class="input-text" style="width: 250px"
				placeholder="" id="search" name="search">
			<button type="submit" class="btn btn-success radius" name="searchBtn" onclick="search()">
				<i class="Hui-iconfont">&#xe665;</i> 搜订单
			</button> 
		 <span class="select-box" style="width:80px;"> 
				<select id="findChose" class="select" size="0.2" name="city">
					<option value="1" selected>订单号</option>
					<option value="2">下单人</option>
					<option value="3">收货人</option>
					<option value="4">收货地址</option>
					<option value="5">收货电话</option>
				</select>
				</span> 
		</div>
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			


			<span class="r">共有数据：<strong style="font-size: 25px;">${allNumber}</strong>
				条 &nbsp;&nbsp; &nbsp;&nbsp;
				<li class="dropDown dropDown_hover"><a href=""
					class="dropDown_A" onclick="return false"> <i
						class="Hui-iconfont"
						style="font-size: 25px; color: #5a98de; margin-right: 100px; margin-top: 10px;">&#xe641;</i></a>
					<ul class="dropDown-menu menu radius box-shadow">
						<li><a href="javascript:;" onClick="impUsers('onePage')">导出本页</a></li>
						<li><a href="javascript:;" onClick="impUsers('allPage')">全部导出</a></li>

					</ul></li>



			</span>


		</div>
		<div class="mt-20">
			<table style="table-layout: fixed;" 
				class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">
						
						<th width="40">订单ID</th>
						<th width="100">订单号</th>						
						<th width="100">收货地址</th>
						<th width="70">收货人</th>
						<th width="90">收货人电话</th>
						<th width="40">商品总价</th>
						<th width="60">下单人ID</th>				
						<th width="40">订单状态</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="order" items="${orderList}" varStatus="i" step="1">
						<tr class="text-c">
							<td>${order.goId }</td>
							<td><a style="text-decoration:none" href="javascript:;" 
								onClick="orderShow(${order.goId })"
								href="javascript:;" title="订单详情">
								<i class="Hui-iconfont">&#xe6c6;</i></a>
								${order.goOrderCode}</td>
							<td>${order.goAddress}</td>
							<td>${order.goReceiver }</td>
							<td>${order.goPhone }</td>
							<td>${order.goTotalPrice }</td>
							<td>${order.goUid }</td>
       			    	   <td class="td-status">
	       			    	 <c:if test="${order.goStatus==0 }">
	     			      	 <span class="label label-defaunt radius">已取消</span>
	     			      	 </c:if>
	     			      	 <c:if test="${order.goStatus==1 }">
	     			      	 <span class="label label-defaunt radius">待付款 </span>
	     			      	 </c:if>
	     			      	 <c:if test="${order.goStatus==2 }">
	     			      	 <span class="label label-defaunt radius">已发货 </span>
	     			      	 </c:if>
	     			      	 <c:if test="${order.goStatus==3 }">
	     			      	 <span class="label label-defaunt radius">待收货</span>
	     			      	 </c:if>
	     			      	 <c:if test="${order.goStatus==4 }">
	     			      	 <span class="label label-defaunt radius">待确认收货</span>
	     			      	 </c:if>
	     			      	 <c:if test="${order.goStatus==5 }">
	     			      	 <span class="label label-defaunt radius">待评论</span>
	     			      	 </c:if>
	     			      	 <c:if test="${order.goStatus>=6 }">
	     			      	 <span class="label label-success radius">已完成</span>
	     			      	 </c:if> 
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
						id="firstPage" href="orderListManagement.action?nowPage=1">第一页</a> <a
						class="paginate_button previous disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
						id="previousPage" href="orderListManagement.action?nowPage=${nowPage-1 }">上一页</a>
					<span><a class="paginate_button current"
						aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${nowPage }/${allPage }</a></span>
					<a class="paginate_button next disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
						id="nextPage" href="orderListManagement.action?nowPage=${nowPage+1 }">下一页</a>
					<a class="paginate_button last disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0"
						id="lastPage" href="orderListManagement.action?nowPage=${allPage}">最后一页</a>
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
	//搜订单
	function  search(){
		var strChose=$('#findChose').val();
		var str=$('#searchBtn').val(); 
		 location.href='orderListManagement.action?listChose=2&findKey='+str+'&strChose='+strChose; 
	}
		
		/*订单详情*/
		function orderShow(id) {				 
		layer_show('订单详情','manageShowOrder.action?order.goId='+id ,'','','510');			
		}

	
		/* 导出订单*/
		function impUsers(chose) {
			var tip;
			if (chose == "onePage") {
				tip = "本页";
			} else {
				tip = "全部";
			}

			layer.confirm('确认要导出' + tip + '数据吗？', function(index) {
				$.ajax({
					type : 'POST',
					url : 'importOrder.action?importChose=' + chose, 
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
		//隐藏多余字符  
		$(".myTit").each(function(){
		       var len=$(this).text().length;   //当前HTML对象text的长度
		       if(len>12){ 
		           var str="";
		           str=$(this).text().substring(0,12)+"..."; //使用字符串截取，获取前30个字符，多余的字符使用“......”代替
		           $(this).html(' <a  title="'+$(this).text()+'"style="text-decoration: none"	onclick="return false"	href="javascript:;" >'+str+'</a>');                   //将替换的值赋值给当前对象
		       }
		    });
	
	</script>
</body>
</html>
