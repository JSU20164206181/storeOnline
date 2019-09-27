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
<title>查看</title>
<link href="lib/lightbox2/2.8.1/css/lightbox.css" rel="stylesheet" type="text/css" >
</head>
<body>
<div class="cl pd-20" style=" background-color:#5bacb6">
	<img class="avatar size-XL l" src="${product.titleImg}">
	<dl style="margin-left:80px; color:#fff">
		<dt>
			<span class="f-18">${product.gpName}</span>
			
		</dt>
		
		<dd class="pt-10 f-12" style="margin-left:0">商品介绍：${product.gpIntroduce}</dd>
		<dd class="pt-10 f-12" style="margin-left:0">原价：${product.gpOriginalPrice}￥</dd>
		<dd class="pt-10 f-12" style="margin-left:0">促销价：${product.gpPromotePrice}￥</dd>
	</dl>
</div>
<div class="page-container">
<div class="portfolio-content">
		<ul class="cl portfolio-area">
			<c:forEach var="productimage" items="${productimageList}" varStatus="i" step="1">
				<li class="item">
					<div class="portfoliobox">
						
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
</script>
</body>
</html>