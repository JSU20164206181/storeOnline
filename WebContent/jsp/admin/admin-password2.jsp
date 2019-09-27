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
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
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
<!--/meta 作为公共模版分离出去-->

<title>修改密码 - 会员管理 - H-ui.admin v3.1</title>
<meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<%
String userId=request.getParameter("userId");

%>
<body>
<article class="page-container">
	<form class="form form-horizontal" id="form-change-password"> 
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">账户：</label>
			<div class="formControls col-xs-8 col-sm-9"> ${admin.gaName } </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>初始密码：</label>
			<div class="formControls col-xs-8 col-sm-7">
				<input type="password" class="input-text" required="required" 
				 placeholder="请填写密码(6-16字)" pattern="^[a-zA-Z0-9_-]{6,16}$" maxlength="16" id="pws1" name="admin.gaPassword"   maxlength="16">
			</div>
		</div>	
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认密码：</label>
			<div class="formControls col-xs-8 col-sm-7">
				<input type="password" class="input-text" required="required" 
				 placeholder="请填写密码(6-16字)" pattern="^[a-zA-Z0-9_-]{6,16}$" maxlength="16"  id="pws2"  maxlength="20">
			</div>
		</div>	
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;保存&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>  
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer /作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script> 
<script type="text/javascript">
//密码验证2
$("#pws2").blur(function(){		
	   var  pws2 =	$("#pws2").val();
	   var  pws1 =	$("#pws1").val();
	  	if( pws2.length<6){  		
	  		layer.tips('格式错误!请输入6-12位数字，字母','#pws2',{time:2000,tips:3});
	  	}
	  	else if(pws2!=pws1){  		
	  		layer.tips('两次输入不一致','#pws2',{time:2000,tips:3});
	  	}
	  	});
//密码验证
$("#pws1").blur(function(){		
	   var  pws1 =	$("#pws1").val(); 
	  	if(pws1.length<6||pws1.indexOf(" ")!=-1){  		
	  		layer.tips('格式错误!请输入6-12位数字，字母','#pws1',{time:2000,tips:3});
	  	}
	  	});
$('#form-change-password').submit(function(){
	
	  var  pws2 =	$("#pws2").val();
	   var  pws1 =	$("#pws1").val();
	  	 if(pws2!=pws1){  		
	  		layer.tips('两次输入不一致','#pws2',{time:2000,tips:3});
	  		return false; 
	  	}
	var data =$('#form-change-password').serialize(); 
	$(this).ajaxSubmit({
		type : 'POST',
		url : 'updataAdmin.action', 
		dataType : 'json',
		data : data,

    success : function(data) {		
	        if(data=="sucess2"){
			var index = parent.layer.getFrameIndex(window.name);
			parent.location.reload(); 
			parent.layer.close(index); 	
			return true;  
	        }else{  
	        return false;  
	        }			
		},
		error : function(data) {			
			var index = parent.layer.getFrameIndex(window.name);
			parent.location.reload();
			parent.layer.close(index); 
			 
		},
	});
	
	
});
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>