<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>添加管理员</title>
</head>
<%
String id=request.getParameter("id");

%>
<body>
<article class="page-container">
	<form class="form form-horizontal" id="form-admin-add">    
	    
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>账号：</label>
			<div class="formControls col-xs-8 col-sm-7">
				
			<input id="name" type="text" required="required" pattern="^[a-zA-Z0-9_-]{6,16}$" maxlength="16" class="input-text" value="" placeholder="请填写账号(6-12位数字，字母)"  name="admin.gaName" >
			
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>密码：</label>
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
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>管理员等级：</label>
			<div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
				<select class="select" size="0.5" name="admin.gaRank" id="sort">
					
				
					<option value="1">普通管理员</option>
					<option value="9">超级管理员</option>
				</select>
				</span> </div>
		</div>
		
	
		<div class="row cl" style="padding-left:45%">
				<input id="submit"  class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;确定&nbsp;&nbsp;">
				
			</div>
			
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script>
<!-- 城市多级联动 -->
<script type="text/javascript" src="lib/city/jquery.provincesCity.js"></script>  
<script type="text/javascript" src="lib/city/provincesData.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
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
	  //账号验证
	   $("#name").blur(function(){
	   var  uname =	$("#name").val();
	  	if(uname.length<6||uname.indexOf(" ")!=-1){  		
	  		layer.tips('格式错误!请输入6-12位数字，字母','#name',{time:2000,tips:3});
	  	}
	  	else{
	  	 $.ajax({
		 type: 'POST',	
		 url: "adminCheckName.action?admin.gaName="+uname,
		 success: function(data) {
			
		 	if(data=="success"){		 		
		 	}else if(data=="hava"){	
		 		$("#name").val("");
		 		layer.msg('账号已存在!', {  
					icon : 2,
					time : 2000
				});	  
		 	
		 	}
						
		 },
				 
	   });  		
	  }	 	
	 });
	 
});
	  
$(function(){
	$('input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	});

	
	

	$('#form-admin-add').submit(function(){
		
		  var  pws2 =	$("#pws2").val();
		   var  pws1 =	$("#pws1").val();
		  	 if(pws2!=pws1){  		
		  		layer.tips('两次输入不一致','#pws2',{time:2000,tips:3});
		  		return false; 
		  	}
	 	var data =$('#form-admin-add').serialize();  
		$(this).ajaxSubmit({
			type : 'POST',
			url : 'addAdmin.action', 
			dataType : 'json',
			data : data,

	success : function(data) {
				
				var index = parent.layer.getFrameIndex(window.name);
				parent.location.reload(); 
				parent.layer.close(index); 
				layer.msg('添加成功!', { 
					icon : 1,
					time : 2000
				});
				
			},
			error : function(data) {
				var index = parent.layer.getFrameIndex(window.name);
				parent.location.reload();
				parent.layer.close(index);
				layer.msg('添加失败!', { 
					icon : 2,
					time : 2000
				});
			},
		});
		alert("添加成功");
		return true; 
	});
</script>

<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>