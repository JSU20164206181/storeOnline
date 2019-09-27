<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<html>
<head>
<base href="<%=basePath%>">
<title>注册</title>
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

<!-- start-smoth-scrolling -->


<style type="text/css">
    .register{
      background:url(ls/regty.jpg) 5px center no-repeat;
    
    }

</style>
</head>
	
<body>
<!-- header -->
	<div class="agileits_header">
		<div class="container">
			<div class="w3l_offers">
				
			</div>
			<div class="agile-login">
				
				<ul>
					
					<li><a href="jsp/goods/login.jsp">登录</a></li>
					<li><a href="contact.html">帮助</a></li>		
				</ul>
			</div>
			<div class="product_list_header">  
					<form action="#" method="post" class="last"> 
						<input type="hidden" name="cmd" value="_cart">
						<input type="hidden" name="display" value="1">
						<button class="w3view-cart" type="submit" name="submit" value="">
						<!-- <i class="fa fa-cart-arrow-down" aria-hidden="true"></i></button> -->
					</form>  
			</div>
			<div class="clearfix"> </div>
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
				<div class="clearfix"></div>
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
									<li class="active"><a href="jsp/goods/mainGoods.jsp" class="act">商城主页</a></li>	
									<!-- Mega Menu -->
									<li class="dropdown">
										
									</li>
									<li class="dropdown">
										
									</li>
									<li class="dropdown">
									</li>
									<li class="dropdown">
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
				<li><a href="jsp/goods/mainGoods.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>商城主页</a></li>
				<li class="active">注册页面</li>
			</ol>
		</div>
	</div>
<!-- //breadcrumbs -->
<!-- register -->
	<div class="register">
		<div class="container">
			<h2>二手交易网站</h2>
			<div class="login-form-grids">
				<h5>注册页面</h5>
				
				<form action="add.action" method="post" style="width: 600px;" id="form" onsubmit="return check()">
					
				<input size="1" id="one" name="guName" type="text" placeholder="用户名不能小于6位" required="required" style="margin-bottom: 13px;">
					<span id="bb"></span>
				
					<input id="password" name="guPassword"  type="password" placeholder="密码" required="required" style="margin-bottom: 13px;margin-left:45px">
					<span id="dd" style="color: red;font-size: 14px;"></span>
					<input id="rePassword" type="password" placeholder="确认密码" required="required" style="margin-bottom: 13px;">
					<span id="cc"></span>
				   
					<input type="email" name="guEmail" placeholder="邮箱" required="required" >
					
					<div class="register-check-box">
						<div class="check">
							<label class="checkbox">
							<input type="checkbox" id="pass" name="checkbox" />
							<!-- <i></i> -->
								<span style="margin-left:6px;">我已阅读该协议</span>
							</label>
						</div>
					</div>
					<input id="reg" type="submit" value="注册">
				</form>
			</div>
			<div class="register-home">
				<a href="jsp/goods/mainGoods.jsp">商城主页</a>
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
						<li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="login.jsp">Login</a></li>
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
					<img src="lib/ls/images/card.png" alt=" " class="lib/ls/images/img-responsive">
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
<!-- //footer -->	

<script type="text/javascript">

//判断用户名是否可以注册
$(document).ready(function(){
	 
	   $("#one").blur(function(){
		//获取 输入的用户名
	   var  uname =	$("#one").val();
	 
	   //用户账户长度大于6或者不能包含空格
	  	if(uname.length<6||uname.indexOf(" ")!=-1){
		    $("#bb").text("*用户格式不正确");
		    $("#bb").removeClass("myicon-tick-checked");
		    bid();
	  	}
	  	else{
	  		
	  		$("#bb").addClass("myicon-tick-checked");
	  		$("#bb").text("");
	  	
	  	 $.ajax({
		 type: "get",	
		 url: "judge.action?uname="+uname,
		 success: function(data) {
			
		 	if(data=="用户已经存在"){
		 		 $("#bb").removeClass("myicon-tick-checked");
	  		     $("#bb").text("*用户已存在");
	  		     bid(); 
		 	}else{		 
		 		 $("#bb").text("");
		         $("#bb").addClass("myicon-tick-checked");		               
		 	}
						
		 },
				 
	   });  		
	  }	 	
	 });
	 
});


//判断注册的两个密码是否一致而且没有空格
 $("#rePassword").blur(function(){
	//获取密码框的值
	var  password =	$("#password").val();
	if(password.indexOf(" ")!=-1){
		$("#dd").text("*密码不能包含空格");
		$("#dd").removeClass("myicon-tick-checked");
	}else{
		$("#dd").text("");
		$("#dd").addClass("myicon-tick-checked");
	}
    //获取重复密码的值
    var  rePassword = $("#rePassword").val();
	if(password==rePassword){
		 $("#cc").text("");
		 $("#cc").addClass("myicon-tick-checked");
		}else{ 
		$("#cc").text("*两次密码不一致");
		$("#cc").removeClass("myicon-tick-checked");
	
	 }
	 
 });
 
 
 
 
 function getObj(id) {
	 var Obj = $(id).text();
	
	 return Obj;
  }
 
 //判断当五个条件都成立的时候 表单才能提交 验证表单
   function check() {
	   var pass = document.querySelector("#pass");
	   var cc =  getObj("#cc");
	   var bb =  getObj("#bb");
	   var dd =  getObj("#dd");
	   
		   if(pass.checked&&cc==""&&bb==""&&dd==""){
			   //选中
			   
		   }else{
			   //未选中
			 
			   return false;
		   }
	
	}


</script>


</body>
</html>