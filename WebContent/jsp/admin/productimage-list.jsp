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
<title>图片列表</title>
<link href="lib/lightbox2/2.8.1/css/lightbox.css" rel="stylesheet" type="text/css" >
</head>
<body>
<jsp:include page="_header.jsp" flush="true" ></jsp:include>
<jsp:include page="_menu.jsp" flush="true" ></jsp:include>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 图片管理 <span class="c-gray en">&gt;</span> 图片列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="text-c"> 
		<input type="text" name="" id="keyword" placeholder="请输入关键字" style="width:250px" class="input-text">
		<button name="" id="" onclick="fuzzy_search()" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> </span> <span class="r">共有数据：${productimageListLength }<strong></strong> 条</span> </div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="40"><input name="" type="checkbox" value=""></th>
					<th width="80">图片ID</th>
					<th width="80">商品ID</th>
					<th>商品名称</th>
					<th width="100">图片</th>
					<th width="100">图片类型</th>
					<th width="100">上传用户</th>
					<th width="100">状态</th>
					<th width="100">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="productimage" items="${productimageList}" varStatus="i" step="1">
				<tr class="text-c">
					<td><input name="" type="checkbox" value=""></td>
					<td>${productimage.gpiId }</td>
					<td>${productList[i.index].gpId }</td>
					<td>${productList[i.index].gpName }</td>
					<td>
						<a href="${productimage.gpiUrl}" data-lightbox="gallery" data-title="${productList[i.index].gpName }:${productimage.gpiType}">
								<img width="60" class="picture-thumb" src="${productimage.gpiUrl}">
						</a>
						
					</td>
					<td>${productimage.gpiType }</td>
					<td>${productList[i.index].gpUid }</td>
					<td class="td-status">
						<c:if test="${productimage.gpiStatus==1 }">
						<span class="label label-success radius">已上架</span>
						</c:if> 
						<c:if test="${productimage.gpiStatus==0 }">
						<span class="label label-defaunt radius">已下架</span>
						</c:if>
					</td>
					<td class="td-manage">
						<c:if test="${productimage.gpiStatus==0 }">
						<a style="text-decoration:none" onClick="picture_start(this,'${productimage.gpiId }')" href="javascript:;" title="发布">
							<i class="Hui-iconfont">&#xe603;</i>
						</a>
						</c:if>
						<c:if test="${productimage.gpiStatus==1 }">
						<a style="text-decoration:none" onClick="picture_stop(this,'${productimage.gpiId }')" href="javascript:;" title="下架">
							<i class="Hui-iconfont">&#xe6de;</i>
						</a> 
						</c:if>
						<a style="text-decoration:none" class="ml-5" onClick="picture_edit('图库编辑','showProductimageUpdate.action?gpId=${productList[i.index].gpId }')">
							<i class="Hui-iconfont">&#xe6df;</i>
						</a> 
						<a style="text-decoration:none" class="ml-5" onClick="picture_del(this,'${productimage.gpiId }')" href="javascript:;" title="删除">
							<i class="Hui-iconfont">&#xe6e2;</i>
						</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper no-footer">
			<div class="dataTables_paginate paging_full_numbers" id="tablePage">
				<a class="paginate_button first disabled" aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0" id="firstPage" href="findProductimageList.action?nowPage=1">第一页</a>
				<a class="paginate_button previous disabled" aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0" id="previousPage" href="findProductimageList.action?nowPage=${nowPage-1 }">上一页</a>
				<span><a class="paginate_button current" aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${nowPage }/${allPage }</a></span>
				<a class="paginate_button next disabled" aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0" id="nextPage" href="findProductimageList.action?nowPage=${nowPage+1 }">下一页</a>
				<a class="paginate_button last disabled" aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0" id="lastPage" href="findProductimageList.action?nowPage=${allPage }">最后一页</a>
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
<script type="text/javascript" src="lib/lightbox2/2.8.1/js/lightbox.min.js"></script> 
<script type="text/javascript">

/*模糊搜索*/
function fuzzy_search(){
	if($("#keyword").val()==''){
		window.location.href="findProductimageList.action";
	}else{
		window.location.href="findProductimageListByFuzzy.action?keyword="+$("#keyword").val();
	}
	
}
/*图片-添加*/
function picture_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

/*图片-查看*/
function picture_show(title,url,id){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

/*图片-审核*/
function picture_shenhe(obj,id){
	layer.confirm('审核文章？', {
		btn: ['通过','不通过'], 
		shade: false
	},
	function(){
		$(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="picture_start(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
		$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
		$(obj).remove();
		layer.msg('已发布', {icon:6,time:1000});
	},
	function(){
		$(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="picture_shenqing(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
		$(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">未通过</span>');
		$(obj).remove();
    	layer.msg('未通过', {icon:5,time:1000});
	});	
}

/*图片-下架*/
function picture_stop(obj,id){
	
	layer.confirm('确认要下架吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'updateProductimageStatus.action',
			dataType: 'json',
			data:{
				gpiId:id,
				status:0,
			},
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="picture_start(this,'+id+')" href="javascript:;" title="上架"><i class="Hui-iconfont">&#xe603;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已下架</span>');
				$(obj).remove();
				layer.msg('已下架!',{icon: 5,time:1000});
			},
			error:function(data) {
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="picture_start(this,'+id+')" href="javascript:;" title="上架"><i class="Hui-iconfont">&#xe603;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已下架</span>');
				$(obj).remove();
				layer.msg('已下架!',{icon: 5,time:1000});
			},
		});
		
	});
}

/*图片-发布*/
function picture_start(obj,id){
	layer.confirm('确认要发布吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'updateProductimageStatus.action',
			dataType: 'json',
			data:{
				gpiId:id,
				status:1,
			},
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="picture_stop(this,'+id+')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已上架</span>');
				$(obj).remove();
				layer.msg('已上架', {icon:6,time:1000});
			},
			error:function(data) {
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="picture_stop(this,'+id+')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已上架</span>');
				$(obj).remove();
				layer.msg('已上架', {icon:6,time:1000});
				console.log(data.msg);
			},
		});
		
	});
}

/*图片-申请上线*/
function picture_shenqing(obj,id){
	$(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">待审核</span>');
	$(obj).parents("tr").find(".td-manage").html("");
	layer.msg('已提交申请，耐心等待审核!', {icon: 1,time:2000});
}

/*图片-编辑*/
function picture_edit(title,url,id){
	layer_show(title,url,'','510');	
	
}

/*图片-删除*/
function picture_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'updateProductimageStatus.action',
			dataType: 'json',
			data:{
				gpiId:id,
				status:2,
			},
			success: function(data){
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}
</script>
</body>
</html>