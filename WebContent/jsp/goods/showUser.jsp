<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%@page import="java.util.List"%> 
 <%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<base href="<%=basePath%>">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<!-- Head BEGIN -->
<head>
<meta charset="utf-8">
<title>个人中心</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<meta content=" description" name="description">
<meta content=" keywords" name="keywords">
<meta content="keenthemes" name="author">

<meta property="og:site_name" content="-CUSTOMER VALUE-">
<meta property="og:title" content="-CUSTOMER VALUE-">
<meta property="og:description" content="-CUSTOMER VALUE-">
<meta property="og:type" content="website">
<meta property="og:image" content="-CUSTOMER VALUE-">
<!-- link to image for socio -->
<meta property="og:url" content="-CUSTOMER VALUE-">

<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="ls/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />

<link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="shortcut icon" href="favicon.ico">

<!-- Fonts START -->

<!--- fonts for slider on the index page -->
<!-- Fonts END -->

<!-- Global styles START -->
<link href="assets/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="assets/plugins/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Global styles END -->

<!-- Page level plugin styles START -->
<link href="assets/pages/css/animate.css" rel="stylesheet">
<link href="assets/plugins/fancybox/source/jquery.fancybox.css"
	rel="stylesheet">
<link href="assets/plugins/owl.carousel/assets/owl.carousel.css"
	rel="stylesheet">
<!-- Page level plugin styles END -->

<!-- Theme styles START -->
<link href="assets/pages/css/components.css" rel="stylesheet">
<link href="assets/pages/css/slider.css" rel="stylesheet">
<link href="assets/pages/css/style-shop.css" rel="stylesheet"
	type="text/css">
<link href="ls/registerAndLogin.css" rel="stylesheet"
	type="text/css">
	
<link href="assets/corporate/css/style.css" rel="stylesheet">
<link href="assets/corporate/css/style-responsive.css" rel="stylesheet">
<link href="assets/corporate/css/themes/red.css" rel="stylesheet"
	id="style-color">
<link href="assets/corporate/css/custom.css" rel="stylesheet">
<link href="ls/address.css" rel="stylesheet">
<script src="ls/city.js"></script>
<!-- Theme styles END -->

</head>
<!-- Head END -->

<!-- Body BEGIN -->
<body class="ecommerce">
<!-- 获取cookie -->
	<!-- BEGIN TOP BAR -->
	<jsp:include page="goods_head.jsp"></jsp:include>
	    <input type="hidden" value="" id="selectGoods">
	    <%
	    String biaoji =(String)request.getAttribute("next");
	      if(request.getAttribute("next")!=null){
	    	  out.print("<input type=hidden value="+biaoji+" id=next>");
	      }
	     
	    %>
	    
	
	<!-- END TOP BAR -->

	<!-- BEGIN HEADER -->
	

		
	<!-- Header END -->

	<div class="main">
		<div class="container">
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<!-- BEGIN SIDEBAR -->
				<div class="sidebar col-md-3 col-sm-3">
					<ul class="list-group margin-bottom-25 sidebar-menu">
						<li class="list-group-item clearfix"><a href="showUser.action"
							onclick="showUser()"><i class="fa fa-angle-right"></i> 个人信息展示</a></li>
						<li class="list-group-item clearfix"><a href="javascript:;"
							onclick="updateUser()"><i class="fa fa-angle-right"></i>
								修改个人信息</a></li>
						<li class="list-group-item clearfix"><a href="javascript:;"
							onclick="addressCon()"><i class="fa fa-angle-right"></i>
								管理收货地址</a></li>
								
						<li class="list-group-item clearfix">
						<a  onclick="selectOrder()" href="javascript:;">
						<i class="fa fa-angle-right">
						</i>
						查看我的销售记录
						</a></li>
						
						<li class="list-group-item clearfix">
						<a  onclick="sr()" href="searchAllOrder.action?userId=${cookie.userId.value}">
						<i class="fa fa-angle-right">
						</i>
						查看历史订单记录
						</a></li>
						
						
						<li class="list-group-item clearfix">
						<a  onclick="selectMyGoods()" href="javascript:;">
							<i class="fa fa-angle-right"></i> 查看我的商品</a>
						</li>
					</ul>
				</div>
				<!-- END SIDEBAR -->


				<!-- 展示个人信息的div -->
				<div class="col-md-9 col-sm-7">
                    
					<s:if test="user.guName!=null">
						<div id="showMsg">
							<jsp:include page="show.jsp"></jsp:include>
							<span style="margin-left: 650px"> <a
								href="javascript:;" style="color:#C80000" onclick="updateUser()">信息不全？请去补充信息</a>
							</span>
						   <input id="noLogin" type="hidden" value="yes"/>
						</div>
					</s:if>
					<!-- 用户没有登录的展示 -->
					<s:else>
						<div id="noUser" style="margin-top: 100px">
							<a href=reg2.jsp
								style="font-size: 17px; color: #C80000; margin-left: 100px;">
								对不起，你还没有登录，请先登录 </a>
						     <input id="noLogin" type="hidden" value="no"/>
						</div>
					</s:else>

					
               <!-- 新增/修改收货地址的展示页面 -->
					<div id="addAdress" class="address">
						<form id="addAddress" method="post" action="addAddress.action" onsubmit="return check()">
							<div class="addList">
								<label><span class="red">* </span>选择地区:</label>
								 <select id="province" name="receiveAddress.graProvince" onchange="getCity()">
									<option value="0">所在省</option>
									<option value="直辖市">直辖市</option>
									<option value="广东省">广东省</option>
									<option value="江苏省">江苏省</option>
									<option value="湖南省">湖南省</option>
								</select> <select id="city" name="receiveAddress.graCity" onchange="getDistrict()">
									<option value="0">所在市</option>
								</select> <select id="district" name="receiveAddress.graDistrict">
								</select>
							</div>
							<!--addList-->

							<div class="addList">
								<label><span class="red">* </span>详细地址:</label>
								 <input id="detail" type="text" name="receiveAddress.graStreet"/>
							</div>
							<!--addList-->
							<div class="addList">
								<label><span class="red">* </span>收件人:</label>
								 <input id="receiveUser" maxlength="5" type="text" name="receiveAddress.graName" />
							</div>
							<!--addList-->
							<div class="addList">
								<label><span class="red">* </span>手机号码:</label> 
								<input id="addPhone"
								 required="required" placeholder="请填写电话号码"  
				pattern="^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))[0-9]{8}$"
				 maxlength="11"
								  type="text" name="receiveAddress.graPhone"/>
								  
								  
							    <input type="hidden" value="" name="index" id="updateNum"/>
								
							</div>
							<!--addList-->
							<div class="addList2">
								<input type="image" src="ls/queren.jpg" width="100"
									height="32" />
							</div>
							<s:textfield type="hidden" name="receiveAddress.graUid" value="%{user.guId}"/>
						     
						</form>
					</div>
					
              
					<!-- 用户收货地址的展示 -->
					<table id="showAddress" class="vipAdress">
						<tr>
						   
							<th style="padding-left: 5px;">用户名</th>
							<th style="padding-left: 25px;">省份/直辖市</th>
							<th style="padding-left: 28px;">所在城市/地区</th>
							<th style="padding-left: 15px;">区县</th>
							<th style="padding-left: 23px;">详细地址</th>
							<th style="padding-left: 23px;">收货人</th>
							<th style="padding-left: 28px;">收货号码</th>	
							<th style="padding-left: 50px;">操作</th>
							
						</tr>
						
						<s:if test="#request.listAddress==null">
						<td><s:property value="user.guName"/></td>	
						<td>空</td>	
						<td>空</td>	
						<td>空</td>	
						<td>空</td>	
						<td>空</td>	
						<td>空</td>	
						<td><span
								class="green add">[添加]</span></td>
						</s:if>
						
						
					<s:else>
						<s:iterator var="address" value="#request.listAddress" status="st">
						<tr>
						    <td><s:property value="user.guName"/></td>
						    
						     <td><s:property value="#address.graProvince"/></td>	
						     <td><s:property value="#address.graCity"/></td>
						     <td><s:property value="#address.graDistrict"/></td>
						     <td><s:property value="#address.graStreet"/></td>	
						     <td><s:property value="#address.graName"/></td>	
						     <td><s:property value="#address. graPhone"/></td>	
						    	
							<td><a id="ss" onclick="updateAs(this)" href="javascript:void(0)" class="green upd">[修改]
							</a>|<a id="tt" href="javascript:void(0)" onclick="daleteAs(this)" 
							style="color:red" class="green detele">[删除]</a>
							
							<!-- <a id="vv" href="javascript:void(0)" onclick="daleteAs(this)" style="color:red">[删除]</a>  -->
							</td>
						
							<td id="xiugai" style="display:none"><s:property value="#st.index"/></td>
							
						 </tr>
						
						 </s:iterator>
						
					</s:else>
					
					
					</table>
                    <span id="addTj" class="green add">[添加]</span>
                    <s:textfield type="hidden" name="guId" value="%{user.guId}"/>
                    <!-- 修改个人信息的展示 -->
					<div id="updateMsg" class="address">
						<h2 class="oredrName">修改个人信息</h2>
						<form action="updateUser.action" method="post" onsubmit="return checkUpdateUser()">
							<div class="addList">
								<label>用户名:</label>
								 <s:textfield id="gname" name="guName" value="%{user.guName}"
									style="width: 150px;height: 26px;" />
								 <s:textfield type="hidden" id="lastName" name="uu" value="%{user.guName}"/>
								<span id="hh"></span>
									<s:textfield name="guId" type="hidden" value="%{user.guId}"/>
								     <s:textfield name="guPassword" type="hidden" value="%{user.guPassword}"/>
							</div>
							<!--addList-->
							<div class="addList">
								<label>性别:</label> 
								<s:textfield id="updateSex" name="guSex" value="%{user.guSex}"
									style="width: 150px;height: 26px;" />	
							</div>
							<!--addList-->
							<div class="addList">
								<label>电话:</label>
								<s:textfield id="phone" required="required" placeholder="请填写电话号码"  
				pattern="^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))[0-9]{8}$"
 maxlength="11"
								type="text" name="guPhone" value="%{user.guPhone}"
									style="width: 150px;height: 26px;" />

							</div>
							<div class="addList">
								<label>年龄:</label>
								<s:textfield id="updateAge"  type="text" name="guAge" value="%{user.guAge}"
							pattern="([1-9])|([1-9][0-9])|(1[01234][0-9])$"		style="width: 150px;height: 26px;" />

							</div>
							<div class="addList">
								<label>住址:</label>
								<s:textfield name="guAddress" value="%{user.guAddress}"
									style="width: 150px;height: 26px;" />
							</div>
							
							<div class="addList">
								<label>邮箱:</label>
								
							
								<s:textfield type="email" name="guEmail" value="%{user.guEmail}"
									required="required"  style="width: 150px;height: 26px;" />
							</div>
						
							<!-- 保存 -->
							<div class="addList2">

							<input type="image" src="ls/baocun.png"
								style="margin-left: 80px" class="vipSub" />
						    </div>
						</form>
					</div>
					<jsp:include page="MyGoods.jsp"></jsp:include>
					<jsp:include page="myOrderList.jsp"></jsp:include>
				</div>
	     	</div>
	     	
		</div>

		<jsp:include page="goods_footer.jsp"></jsp:include>
			
	
    
		<script src="assets/plugins/jquery.min.js" type="text/javascript"></script>
		<script src="assets/plugins/jquery-migrate.min.js"
			type="text/javascript"></script>
		<script src="assets/plugins/bootstrap/js/bootstrap.min.js"
			type="text/javascript"></script>
		<script src="assets/corporate/scripts/back-to-top.js"
			type="text/javascript"></script>
		<script
			src="assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
			type="text/javascript"></script>
		<!-- END CORE PLUGINS -->

		<!-- BEGIN PAGE LEVEL JAVASCRIPTS (REQUIRED ONLY FOR CURRENT PAGE) -->
		<script src="assets/plugins/fancybox/source/jquery.fancybox.pack.js"
			type="text/javascript"></script>
		<!-- pop up -->
		<script src="assets/plugins/owl.carousel/owl.carousel.min.js"
			type="text/javascript"></script>
		<!-- slider for products -->
		<script src="assets/plugins/zoom/jquery.zoom.min.js"
			type="text/javascript"></script>
		<!-- product zoom -->
		<script
			src="assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js"
			type="text/javascript"></script>
		<!-- Quantity -->

		<script src="assets/corporate/scripts/layout.js"
			type="text/javascript"></script>
		<script src="assets/pages/scripts/bs-carousel.js"
			type="text/javascript"></script>
		<script type="text/javascript">
			jQuery(document).ready(function() {
				Layout.init();
				Layout.initOWL();
				Layout.initImageZoom();
				Layout.initTouchspin();
				

				Layout.initFixHeaderWithPreHeader();
				Layout.initNavScrolling();
			});
		</script>

		<script type="text/javascript">
		var u = $("#next").val();
		if(u=="next"){
			$("#showAddress").hide();
			$("#addAdress").hide();
			$("#updateMsg").hide();
			$("#addTj").hide();
			$("#MyGoods").show();
			$("#show").hide();
			$("#MyOrder").hide();
		}else{
			$("#showAddress").hide();
			$("#addAdress").hide();
			$("#updateMsg").hide();
			$("#addTj").hide();
			$("#MyGoods").hide();
			$("#MyOrder").hide();
		}
		
		
		function  selectOrder(){
			$("#showAddress").hide();
			$("#addAdress").hide();
			$("#updateMsg").hide();
			$("#addTj").hide();
			$("#MyGoods").hide();
			$("#show").hide();
			$("#MyOrder").show();
			
		}
			
			//查看收货地址
			function addressCon() {
				$("#showMsg").hide();
				$("#noUser").hide();
				$("#showAddress").show();
				$("#updateMsg").hide();
				$("#addTj").show();
				$("#MyGoods").hide();
				$("#MyOrder").hide();
				
			}
			//新增收货地址
			$(".add").click(function(){
				
			    var length = $("#showAddress tr").length
				if(length>=5){
					alert("收货地址达到了上限");
					$("#addPhone").val("");								
					$("#receiveUser").val("");	
					$("#detail").val("") ;	
					$("#updateNum").val("");
					$("#MyGoods").hide();
					$("#MyOrder").hide();
					$("#addAdress").stop(true, true).slideUp();
				}else{
					$("#addAdress").stop(true, true).slideUp();
					$("#addPhone").val("");								
					$("#receiveUser").val("");	
					$("#detail").val("") ;	
					$("#updateNum").val("");
					$("#addAdress").stop(true, true).slideDown();
					$("#MyGoods").hide();
					$("#MyOrder").hide();
				}
				
			});

			//个人信息展示
			function showUser() {
				$("#showMsg").show();
				$("#noUser").show();
				$("#showAddress").hide();
				$("#updateMsg").hide();
				$("#addAdress").stop(true, true).slideUp();
				$("#addTj").hide();
				$("#MyGoods").hide();
				$("#MyOrder").hide();
			}
          
			//修改个人用户名字信息时 判断想修改的用户名有没有被使用
			$("#gname").blur(function(){
				var uname = $("#gname").val();
				var lastName = $("#lastName").val();
				if(uname.length<6||uname.indexOf(" ")!=-1){	
				   layer.tips('格式错误!','#gname',{time:2000,tips:3});
				   $("#hh").text(" ");
			  	}
			  	else{
			  		 
				$.ajax({
					 type: "get",	
					 url: "judge.action?uname="+uname,
					 success: function(data) {
					 	if(data=="用户已经存在"&&uname!=lastName){
					 		layer.tips('用户已经存在!','#gname',{time:2000,tips:3});
					 		 $("#hh").text("用户已经存在");
					         $("#hh").removeClass("myicon-tick-checked");		
					 	}else{		 
					 		 $("#hh").text("");
					         $("#hh").addClass("myicon-tick-checked");		               
					 	}
									
					 },
							 
				 });  		
				}
			});
			
			
			//修改个人信息页面
			function updateUser() {
				$("#showAddress").hide();
				$("#showMsg").hide();	
				$("#addAdress").stop(true, true).slideUp();
				$("#addTj").hide();
				$("#MyGoods").hide();
				$("#MyOrder").hide();
				var noLogin = $("#noLogin").val();
			
				if(noLogin=="no"){
					alert("11*");
					$("#noUser").show();			
				}else{
					
					$("#updateMsg").show();
				}
				
			}
			
			//判断修改个人信息是否能提交
			function checkUpdateUser(){
				var name = $("#hh").text();	
				
				var sex = $("#updateSex").val();
				var age = $("#updateAge").val();	
				if(!(sex=="男"||sex=="女")){
					layer.tips('性别格式错误','#updateSex',{time:2000,tips:3});
					return false;
				}
				if(parseInt(age)>parseInt("120")						
						||parseInt(age)<parseInt("0")){
					layer.tips('年龄必须在0-120','#updateAge',{time:2000,tips:3});
					return false;
				}
				if(name=="用户已经存在"||name==" "){	
					 return false;
				}
				
				
			}
			
			
			//表单提交的验证 必须都要填写 才能提交
			function check(){
				
				var detail = $("#detail").val();
				var receive = $("#receiveUser").val();
			
				if(detail==""||receive==""){
					 return false;
				}
			}
			
			//修改收货地址
			function updateAs(obj){
				$("#addAdress").stop(true, true).slideUp();
				var $this = $(obj);
				var t = ($this.parent().next().text());
			
				var $a = $this.parent().prev();
				var aText = $a.text();
				
				$("#addPhone").val(aText);				
				var $b = $a.prev();
				var bText = $b.text();				
				$("#receiveUser").val(bText);	
				var $c = $b.prev();
				var cText = $c.text();
				$("#detail").val(cText) ;
		
				$("#updateNum").val(t);
				$("#addAdress").stop(true, true).slideDown();
			}
			
			 //删除收货地址
			function  daleteAs(obj){
				
				var $this = $(obj);
				var index = ($this.parent().next().text());
				
				  $.ajax({
					 type: "get",	
					 url: "deleteShopAddress.action?index="+index,
					 success: function(data) {
						
					 	alert(data);
					 	if(data=="删除成功"){
					 		window.location.href = "${pageContext.request.contextPath}/showUser.action";
					 	}			
					 },
							 
				}); 
			  
			}
			 
			 //查看我的商品
			 function selectMyGoods(){
				   $("#showAddress").hide();
					$("#addAdress").hide();
					$("#updateMsg").hide();
					$("#addTj").hide();
					$("#show").hide();
					$("#MyGoods").show();
					$("#showMsg").hide();
					$("#MyOrder").hide();
			 } 
			 
			
		</script>
		<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>