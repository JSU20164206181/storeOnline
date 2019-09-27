<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String path = request.getContextPath(); 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"; 
%> 

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>商品审核</title>
</head>
<body>
<jsp:include page="_header.jsp" flush="true" ></jsp:include>
<jsp:include page="_menu.jsp" flush="true" ></jsp:include>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 商品管理 <span class="c-gray en">&gt;</span> 商品审核 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="text-c">
		
		<input type="text" name="" id="keyword" placeholder="请输入关键字" style="width:250px" class="input-text">
		<button name="" id="" onclick="fuzzy_search()" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<span class="l"> 
			<a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont"></i> 批量删除</a>
			</span> 
		<span class="r">共有数据：<strong>${productListLength }</strong> 条</span> 
		
	</div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" name="" value=""></th>
					<th width="80">ID</th>
					<th width="80">名称</th>
					<th>介绍</th>
					<th width="80">原价</th>
					<th width="80">促销价</th>
					<th width="60">库存</th>
					<th width="60">类型</th>
					<th width="60">上传用户</th>
					<th width="120">创建时间</th>
					<th width="60">状态</th>
					<th width="60">操作${str}</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="product" items="${productList}" varStatus="i" step="1">
				<tr class="text-c">
					<td><input type="checkbox" value="1" name=""></td>
					<td>${product.gpId }</td>
					
					<td><u style="cursor:pointer" class="text-primary" onclick="click_title('查看','showProduct.action?gpId=${product.gpId }')" title="查看">${product.gpName }</u></td>
					
					<td>${product.gpIntroduce }</td>
					<td>${product.gpOriginalPrice }￥</td>
					<td>${product.gpPromotePrice }￥</td>
					<td>${product.gpStock }</td>
					<td>
						<c:forEach var="category" items="${categoryList}" varStatus="i" step="1">
							<c:if test="${product.gpCid==category.gcId }">
								${category.gcName }
							</c:if>
						</c:forEach>
					
					</td>
					<td>${product.gpUid }</td>
					<td><fmt:formatDate value="${product.gpCreateDate }" pattern="yyyy-MM-dd HH:mm"/></td>
					<td class="td-status">
						
						<c:if test="${product.gpStatus==2 }">
						<span class="label label-success radius">审核中</span>
						</c:if>
						<c:if test="${product.gpStatus==3 }"> 
						<span class="label label-danger radius">未通过</span>
						</c:if>
					</td>
					
					<td class="td-manage">
						
						<a style="text-decoration:none" onclick="product_audit(this,'${product.gpId }')" href="javascript:;" title="审核">审核</a>
						
						<a title="删除" href="javascript:;" onclick="product_del(this,'${product.gpId }')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper no-footer">
			<div class="dataTables_paginate paging_full_numbers" id="tablePage">
				<a class="paginate_button first disabled" aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0" id="firstPage" href="findAuditProductList.action?nowPage=1">第一页</a>
				<a class="paginate_button previous disabled" aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0" id="previousPage" href="findAuditProductList.action?nowPage=${nowPage-1 }">上一页</a>
				<span><a class="paginate_button current" aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${nowPage }/${allPage }</a></span>
				<a class="paginate_button next disabled" aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0" id="nextPage" href="findAuditProductList.action?nowPage=${nowPage+1 }">下一页</a>
				<a class="paginate_button last disabled" aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0" id="lastPage" href="findAuditProductList.action?nowPage=${allPage }">最后一页</a>
			</div>
		</div>
	</div>
</div>
</section>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="lib/datatables/1.10.15/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
/*模糊搜索*/
function fuzzy_search(){
	if($("#keyword").val()==''){
		window.location.href="findAuditProductList.action";
	}else{
		window.location.href="findAuditProductListByFuzzy.action?keyword="+$("#keyword").val();
	}
	
}

/* //获取发布的商品
$().ready(function(){
	$.ajax({
		type: 'POST',
		url: 'findSubjectList.action',
		dataType: 'json',
		success: function(data){
			
		},
		error:function(data) {
			
			console.log(data.msg);
		},
	});
});
 */
/*点击标题查看商品*/

function click_title(title,url){	
	layer_show(title,url,'','510');	
}





/*商品-审核*/
function product_audit(obj,id){
	layer.confirm('审核商品？', {
		btn: ['通过','不通过','取消'],
		shade: false,
		closeBtn: 0
	},
	function(){
		
		$.ajax({
			type: 'POST',
			url: 'updateProductStatus.action',
			dataType: 'json',
			data:{
				productID:id,
				status:1,
			},
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="product_stop(this,'+id+')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已上架</span>');
				$(obj).remove();
				layer.msg('已上架', {icon:6,time:1000});
			},
			error:function(data) {
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="product_stop(this,'+id+')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已上架</span>');
				$(obj).remove();
				layer.msg('已上架', {icon:6,time:1000});
				console.log(data.msg);
			},
		});
		
	},
	function(){
	
		
		$.ajax({
			type: 'POST',
			url: 'updateProductStatus.action',
			dataType: 'json',
			data:{
				productID:id,
				status:2,
			},
			success: function(data){
				$(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">未通过</span>');
				
				layer.msg('未通过', {icon:5,time:1000});
			},
			error:function(data) {
				$(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">未通过</span>');
				
				layer.msg('未通过', {icon:5,time:1000});
				console.log(data.msg);
			},
		});
    	
	});
}
/*商品-下架*/
function product_stop(obj,id){
	layer.confirm('确认要下架吗？',function(index){
		
		$.ajax({
			type: 'POST',
			url: 'updateProductStatus.action',
			dataType: 'json',
			data:{
				productID:id,
				status:0,
			},
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="product_start(this,'+id+')" href="javascript:;" title="上架"><i class="Hui-iconfont">&#xe603;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已下架</span>');
				$(obj).remove();
				layer.msg('已下架!',{icon: 5,time:1000});
			},
			error:function(data) {
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="product_start(this,'+id+')" href="javascript:;" title="上架"><i class="Hui-iconfont">&#xe603;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已下架</span>');
				$(obj).remove();
				layer.msg('已下架!',{icon: 5,time:1000});
				console.log(data.msg);
			},
		});
		
	});
}

/*商品-上架*/
function product_start(obj,id){
	layer.confirm('确认要上架吗？',function(index){
		
		$.ajax({
			type: 'POST',
			url: 'updateProductStatus.action',
			dataType: 'json',
			data:{
				productID:id,
				status:1,
			},
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="product_stop(this,'+id+')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已上架</span>');
				$(obj).remove();
				layer.msg('已上架!',{icon: 6,time:1000});
			},
			error:function(data) {
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="product_stop(this,'+id+')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已上架</span>');
				$(obj).remove();
				layer.msg('已上架!',{icon: 6,time:1000});
				console.log(data.msg);
			},
		});
		
	});
}
/*商品-删除*/
function product_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'updateProductStatus.action',
			dataType: 'json',
			data:{
				productID:id,
				status:3,
			},
			success: function(data){
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
			},
			error:function(data) {
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
				console.log(data.msg);
			},
		});
	});
}




</script>
</body>
</html>
