<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html PUBLIC "
-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<base href="<%=basePath%>">
<head>
<title>登录</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="ls/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="ls/registerAndLogin.css" rel="stylesheet" type="text/css" media="all" />
<!-- font-awesome icons -->
<link href="ls/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
<!-- js -->

<!-- //js -->
<link href='http://fonts.googleapis.com/css?family=Raleway:400,100,100italic,200,200italic,300,400italic,500,500italic,600,600italic,700,700italic,800,800italic,900,900italic' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<!-- start-smoth-scrolling -->
<script type="text/jscript" src="ls/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="ls/move-top.js"></script>

<script type="text/javascript" src="ls/easing.js"></script>

<script type="text/javascript" src="ls/bootstrap.min.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event){		
			event.preventDefault();
			$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
		});
	});
</script>

<style type="text/css">

   .register{
       background:url(ls/bgloginp.png) 5px center no-repeat;
   }

</style>

<!-- start-smoth-scrolling -->

</head>
	
<body>
<!-- header -->
	<div class="agileits_header">
		<div class="container">
			
			<div class="agile-login">
				
				<ul>
					<li><a href="jsp/goods/register.jsp">注册用户</a></li>
					<li><a href="contact.html">帮助</a></li>
					
				</ul>
			</div>
			<div class="product_list_header">  
					<form action="#" method="post" class="last"> 
						<input type="hidden" name="cmd" value="_cart">
						<input type="hidden" name="display" value="1">
						<button class="w3view-cart" type="submit" name="submit" value="">
					<!-- 	<i class="fa fa-cart-arrow-down" aria-hidden="true"></i></button> -->
					</form>  
			</div>
			
		</div>
	</div>

	<div class="logo_products">
		<div class="container">
		<div class="w3ls_logo_products_left1">
			
			</div>
			<div class="w3ls_logo_products_left">
				<h1><a href="index.html">二手交易网站</a></h1>
			</div>
		<div class="w3l_search">
			<form action="#" method="post">
				<input type="search" name="Search" placeholder="搜索" required="">
				<button type="submit" class="btn btn-default search" aria-label="Left Align">
					<i class="fa fa-search" aria-hidden="true"> </i>
				</button>
				
			</form>
		</div>
			
			<div class="clearfix"> </div>
		</div>
	</div>
<!-- //header -->
<!-- navigation -->
	<div class="navigation-agileits">
		<div class="container">
			<nav class="navbar navbar-default">
							<!-- Brand and toggle get grouped for better mobile display -->
							<div class="navbar-header nav_2">
								<button type="button" class="navbar-toggle collapsed navbar-toggle1" data-toggle="collapse" data-target="#bs-megadropdown-tabs">
									<span class="sr-only">Toggle navigation</span>
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>
								</button>
							</div> 
							<div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
								<ul class="nav navbar-nav">
									<li class="active"><a href="jsp/goods/mainGoods.jsp" class="act">主页</a></li>	
									<!-- Mega Menu -->
									<li class="dropdown">
										<a href="jsp/goods/mainGoods.jsp" class="dropdown-toggle" >商城</a>
									</li>
									
								</ul>
							</div>
							</nav>
			</div>
		</div>
		
<!-- //navigation -->
<!-- breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<ol class="breadcrumb breadcrumb1 animated wow slideInLeft" data-wow-delay=".5s">
				<li><a href="jsp/goods/mainGoods.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>主页</a></li>
				<li class="active">登录页面</li>
			</ol>
		</div>
	</div>
<!-- //breadcrumbs -->
<!-- register -->
	<div class="register">
		<div class="container">
			<h2>登录</h2>
			
				
			<div class="login-form-grids animated wow slideInUp" data-wow-delay=".5s">
				<form action="login.action" method="post" id="form1" style="width: 600px;" onsubmit="return check(true)">
					<input id="uname" name="name" type="text" style="margin-left: 70px;" placeholder="用户名不能小于6位" required="required" >
					<span id="ff"  style="color: red;font-size: 14px;"></span>
					<input style="margin-left: 70px;" name="loginPassword" type="password" placeholder="密码" required="required" >
					<input style="margin-left: 70px;" size="10" type="text" name="code" placeholder="验证码" required="required" >
					
					<s:if test="#session.error!=null">
					<script type="text/javascript">
					alert('<s:property value="#session.error" escape="false"/>')
					</script>
					</s:if>
					
					
					<img style="margin-left: 360px;margin-top:12px" id="yzm"  name="yzm" alt="" src="${pageContext.request.contextPath}/validation.action"/>
					<span style="font-size:10px;margin-top:12px"><a href="#" id="qh">看不清？</a></span>
					<div class="forgot">
	
                      
						
					</div>
					<input style="margin-left: 63px;" type="submit" value="登录">
				</form>	
			</div>
			
		</div>
	</div>
<!-- //register -->
<!-- //footer -->
<div class="footer">
		<div class="container">
			<div class="w3_footer_grids">
				<div class="col-md-3 w3_footer_grid">
					<h3>关于我们</h3>
					
					<ul class="address">
						<li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i><a href="mailto:info@example.com">我们的邮箱</a></li>
						<li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>110</li>
					</ul>
				</div>
				<div class="col-md-3 w3_footer_grid">
					<h3>交易网介绍</h3>
					<ul class="info"> 
						<li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="about.html">关于我们</a></li>
					</ul>
				</div>
				<div class="col-md-3 w3_footer_grid">
					<h3>商品分类</h3>
					<ul class="info"> 
						<li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="groceries.html">分类一</a></li>
						<li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="household.html">分类二</a></li>
					</ul>
				</div>
				<div class="col-md-3 w3_footer_grid">
					<h3>详情</h3>
					<ul class="info"> 
						<li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="products.html">商品展示中心</a></li>
						<li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="login.html">Login</a></li>
					</ul>
					
					
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
		
		<div class="footer-copy">
			
			<div class="container">
			</div>
		</div>
		
	</div>	
	<div class="footer-botm">
			<div class="container">
				<div class="w3layouts-foot">
					<ul>
						<li><a href="#" class="w3_agile_facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
						<li><a href="#" class="agile_twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
						<li><a href="#" class="w3_agile_dribble"><i class="fa fa-dribbble" aria-hidden="true"></i></a></li>
						<li><a href="#" class="w3_agile_vimeo"><i class="fa fa-vimeo" aria-hidden="true"></i></a></li>
					</ul>
				</div>
				<div class="payment-w3ls">	
					<!-- <img src="images/card.png" alt=" " class="img-responsive"> -->
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>




<!-- main slider-banner -->
<script type="text/javascript">

	//刷新验证码
	 var i = 1;
	 document.getElementById("qh").onclick=function(){
	 document.getElementById("yzm").src = "${pageContext.request.contextPath}/validation.action?i=" + i;
     i++;
     return false;
	 }; 
	
//判断账号格式是否正确
$("#uname").blur(function(){	
	   var  uname =	$("#uname").val();
	   if(uname.length<6||uname.indexOf(" ")!=-1){
		   $("#ff").text("*用户格式不正确");
		   $("#ff").removeClass("myicon-tick-checked");
	   }else{
		   $("#ff").text("");
		   $("#ff").addClass("myicon-tick-checked");
	   }
});

function check(flag){
	return flag;
}

$("#form1").submit(function(){
	
	 var test = $("#ff").text();
	 if(test!=""){
		 return check(false);
	 }
	
});


</script>
<!-- //main slider-banner --> 

</body>
</html>