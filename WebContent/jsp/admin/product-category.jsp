<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>商品分类</title>
<link href="lib/lightbox2/2.8.1/css/lightbox.css" rel="stylesheet" type="text/css" >
<style type="text/css">
	.portfolio-area li .portfoliobox.redborder{
		border:2px solid red;
	}
</style>
</head>
<body>
<jsp:include page="_header.jsp" flush="true" ></jsp:include>
<jsp:include page="_menu.jsp" flush="true" ></jsp:include>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 产品管理 <span class="c-gray en">&gt;</span> 产品分类 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
<div class="text-c">
	<input type="text" name="" id="keyword" placeholder="请输入关键字" style="width:250px" class="input-text">
		<button name="" id="" onclick="fuzzy_search()" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
</div>
	
<div class="cl pd-5 bg-1 bk-gray mt-20"> 
	<span class="l"> 
		<a class="btn btn-primary radius" onclick="picture_add('添加分类','showCategoryAdd.action')" href="javascript:;">
			<i class="Hui-iconfont">&#xe600;</i> 添加分类
		</a>
		<a href="javascript:;" onclick="edit('编辑','findCategoryById.action?gcId=')" class="btn btn-primary radius">
			<i class="Hui-iconfont">&#xe6df;</i> 编辑
		</a> 
		
		<a href="javascript:;" onclick="datadel('deleteCategoryList.action')" class="btn btn-danger radius">
			<i class="Hui-iconfont">&#xe6e2;</i> 批量删除
		</a> 
		
	</span> 
	<span class="r">共有数据：<strong>${categoryListLength }</strong> 条</span> 
	
</div>
<form id="form"  method="post">
<div class="portfolio-content">
		<ul class="cl portfolio-area">
			<c:forEach var="category" items="${categoryList}" varStatus="i" step="1">
				<li class="item hover" style="height: 50px">
					<div class="portfoliobox" id="${category.gcId}">
						<input class="checkbox" name="gcIdList" type="checkbox" value="${category.gcId}" id="gcId">
						<div>${category.gcName} </div>
					</div>
				</li>
			
			</c:forEach>
		</ul>
		
</div>
</form>
</div>
</section>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> 
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/lightbox2/2.8.1/js/lightbox.min.js"></script> 
<script src="static/h-ui/js/H-ui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
/*模糊搜索*/
function fuzzy_search(){
	if($("#keyword").val()==''){
		window.location.href="findCategoryList.action";
	}else{
		window.location.href="findCategoryListByFuzzy.action?keyword="+$("#keyword").val();
	}
	
}
$("input[type='checkbox']").click(function(){
	var lis = $(".portfolio-area li .portfoliobox.redborder");
	for(var i = 0; i < lis.length; i++){
		$(lis[i]).removeClass("redborder");
	}
})
/*分类-添加*/
function picture_add(title,url){
	layer_show(title,url,'','210');	
}
/*分类-编辑*/
function edit(title,url){
	
	var length = $("input[type='checkbox']:checked").length;
	if(length==1){
		var id = $("input[type='checkbox']:checked").val();
		
		layer_show(title,url+id,'','210');	
	}else if(length==0){
		layer.msg('请选择一个分类', {icon:5});
		
	}else{
		layer.msg('只能编辑一个分类', {icon:5});
		
	}
}
/*分类-删除*/
function datadel(url){
	var data = $('#form').serialize();
	var length = $("input[type='checkbox']:checked").length;
	if(length>0){
		$.ajax({
			type: 'POST',
			url: url,
			dataType: 'json',
			data:data,
			success: function(data){
				var removeLis = $("input[type='checkbox']:checked");
				
				var categorydel = true;
				for(var i = 0; i < data.length; i++){
					var divId = "#"+data[i].gcId;
					$(divId).addClass("redborder");
					categorydel = false;
					
				}
				if(categorydel){
					layer.msg('删除成功', {icon:1});
				}else{
					layer.msg('无法删除使用中的分类', {icon:2});
				}
				for(var i = 0; i < removeLis.length; i++){
					var remove = true;
					for(var j = 0; j < data.length; j++){
						
						if($(removeLis[i]).parent().attr("id")==data[j].gcId){
							remove = false;	
						}		
					}
					if(remove){
						$(removeLis[i]).removeAttr('checked');
						$(removeLis[i]).parent().parent().remove();
					}
				}
				
				
			},
			error:function(data) {
				location.reload();
				console.log(data.msg);
			},
		});
	}else{
		layer.msg('至少选择一个分类', {icon:5});
		
	}
}
</script>
</body>
</html>