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
<title>修改商品图片</title>
<link href="lib/lightbox2/2.8.1/css/lightbox.css" rel="stylesheet" type="text/css" >
</head>
<body>

<div class="page-container">
<div class="cl pd-5 bg-1 bk-gray mt-20"> 
	<span class="l"> 
		<a class="btn btn-primary radius" onclick="picture_add('添加图片','showProductimageAdd.action?gpId=${product.gpId}')" href="javascript:;">
			<i class="Hui-iconfont">&#xe600;</i> 添加图片
		</a>
		<a href="javascript:;" onclick="edit('setToCover.action?gpId=${product.gpId}')" class="btn btn-primary radius">
			<i class="Hui-iconfont">&#xe6df;</i> 设为封面
		</a> 
		<a href="javascript:;" onclick="datadel('deleteProductimage.action?gpId=${product.gpId}')" class="btn btn-danger radius">
			<i class="Hui-iconfont">&#xe6e2;</i> 批量删除
		</a> 
		<a href="jsp/admin/closeWindow.jsp" class="btn btn-default radius">
			&nbsp;&nbsp;返回&nbsp;&nbsp;
		</a> 
		
	</span> 
	
</div>
<form id="form"  method="post">
<div class="portfolio-content">
		<ul class="cl portfolio-area">
			<c:forEach var="productimage" items="${productimageList}" varStatus="i" step="1">
				<li class="item">
					<div class="portfoliobox">
						<input class="checkbox" name="productimageIdList" type="checkbox" value="${productimage.gpiId}">
						<div class="picbox">
							<a href="${productimage.gpiUrl}" data-lightbox="gallery" data-title="${productimage.gpiType}">
								<img src="${productimage.gpiUrl}">
							</a>
						</div>
						<div class="textbox">${productimage.gpiType} </div>
					</div>
				</li>
			
			</c:forEach>
		</ul>
		
</div>
</form>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> 
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/lightbox2/2.8.1/js/lightbox.min.js"></script> 
<script type="text/javascript">
$(function(){
	$(".portfolio-area li").Huihover();
});

/*图片-添加*/
function picture_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
	
}
/*图片-设为封面*/
function edit(url){
	var data = $('#form').serialize();
	var length = $("input[type='checkbox']:checked").length;
	if(length==1){
		console.log(data)
		$.ajax({
			type: 'POST',
			url: url,
			dataType: 'json',
			data:data,
			success: function(data){
				
				location.reload();
				
			},
			error:function(data) {
				
				
				location.reload();
				
				console.log(data.msg);
			},
		});
	}else if(length==0){
		layer.msg("请选择一张图片", {icon:5});
		
	}else{
		layer.msg("只能设置一张图为封面", {icon:5});
	}
}
/*图片-删除*/
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
				
				location.reload();
			},
			error:function(data) {
				
				location.reload();
				console.log(data.msg);
			},
		});
	}else{
		layer.msg("请选择一张图片", {icon:5});
		
	}
}
</script>
</body>
</html>