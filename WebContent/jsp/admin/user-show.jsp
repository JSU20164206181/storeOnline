<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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


<title>用户详情</title>
</head>
<body>
	<div class="cl pd-20" style="background-color: #5bacb6">
		<img class="avatar size-XL l"
			src="static/h-ui/images/ucnter/avatar-default.jpg">
		<dl style="margin-left: 80px; color: #fff">
			<dt>
				<span class="f-18">用户名：${user.guName }</span>
               
			</dt>
		</dl>
	</div>
	<article class="page-container">
	<form class="form form-horizontal" id="form-user-updata">      
	     <input value="${user.guId}" type="hidden" />
		 <input value="${user.guStatus}" type="hidden" />
		 
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>密码：</label>
			<div class="formControls col-xs-8 col-sm-7">
				<input type="text"  class="input-text" required="required"  readonly="readonly"
				 placeholder="请填写密码(6-20字)" id="title" name="user.guPassword" value="${user.guPassword}"   maxlength="20">
			</div>
		</div>	
		<div class="row cl" >
		<label class="form-label col-xs-3 col-sm-3">性别：</label>
			<div class="formControls col-xs-7 col-sm-7 skin-minimal">
		<c:if test="${user.guSex=='男'}">
	           	<div class="radio-box" id="vt1">
					<input name="user.guSex" type="radio" id="type-1" checked value="男"/>
					<label for="type-1">男</label>
				</div>
				<div class="radio-box" id="vt2">
					<input name="user.guSex" type="radio" id="type-2" value="女"/>
					<label for="type-2">女</label>
				</div>	
			
			</c:if>
	      <c:if test="${user.guSex=='女'}">
		
				<div class="radio-box" id="vt1">
					<input name="user.guSex" type="radio" id="type-1"  value="男"/>
					<label for="type-1">男</label>
				</div>
				<div class="radio-box" id="vt2">
					<input name="user.guSex" type="radio" id="type-2" checked value="女"/>
					<label for="type-2">女</label>
				</div>	
			
			</c:if>
</div>
			</div>

	 
		
		<div class="row cl">
			<label class="form-label col-xs-3 col-sm-3">年龄：</label>
				
				<div class="formControls col-xs-7 col-sm-7 skin-minimal"> 
				<input class="input-text" placeholder="请填写年龄(1~150)" name="user.guAge" value="${user.guAge}" type="text" maxlength="3" pattern="([1-9])|([1-9][0-9])|(1[01234][0-9])$" />
		        </div>
	 </div>
	 <div class="row cl">
			<label class="form-label col-xs-3 col-sm-3">电话：</label>
				
				<div class="formControls col-xs-7 col-sm-7 skin-minimal"> 
				<input  class="input-text"    name="user.guPhone" value="${user.guPhone}"  placeholder="请填写电话号码" type="text" 
				pattern="^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))[0-9]{8}|$" maxlength="11"  /> 
		        </div>
	    </div>
	    <div class="row cl">
			<label class="form-label col-xs-3 col-sm-3">邮箱：</label>
				
				<div class="formControls col-xs-7 col-sm-7 skin-minimal"> 
				<input class="input-text" name="user.guEmail" value="${user.guEmail}"  placeholder="请填写邮箱  " 
				maxlength="20" 
				pattern="^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}|$"
				type="text" />
				
		        </div>
	    </div>
	    	<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">用户地址：</label>
			<input value="${city[0]}" type="hidden" id="ct1"/>
			<input value="${city[1]}" type="hidden" id="ct2"/>
			<input value="${city[2]}" type="hidden" id="ct3"/> 
			<div id="province" class="formControls col-xs-8 col-sm-9 skin-minimal" >
			</div> 
			
			<label class="form-label col-xs-4 col-sm-3"></label>
			<div id="province" class="formControls col-xs-8 col-sm-7 skin-minimal" >
			<textarea  name="userAdress" rows="5" class="input-text"  placeholder="详细地址">${city[3]}</textarea> 
			</div> 
			
		</div>
		<%-- <div class="row cl">
			<label class="form-label col-xs-5 col-sm-5" >收货地址：（该信息不能修改）</label>
				<table	style="width:80%;margin-left:10%"class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">
						
						<th width="30">序号</th>
						<th width="40">收件人</th>
						<th width="40">电话号码</th>
						<th width="140">收货地址</th>
								</tr>
				</thead>
				<tbody>

					<c:forEach var="sd" items="${shopAddress}" varStatus="i" step="1">
						<tr class="text-c">
							
							<td>${i.count}</td>
							<td>${sd[2]}</td>
							<td>${sd[3]}</td>
							<td>${sd[0]}_${sd[1]}</td>										
						</tr>
					</c:forEach>

				</tbody>
			</table>
			
			
			</div> --%>
		
	
		<div class="row cl" style="padding-left:45%">
				<input id="submit"  class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;修改&nbsp;&nbsp;"> 
				
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
<script type="text/javascript" src="hdq/city/jquery.provincesCity.js"></script>  
<script type="text/javascript" src="hdq/city/provincesData.js"></script> 
<script type="text/javascript">
$(function(){
	  $("#province").ProvinceCity(); 
	  });
    
$('#form-user-updata').submit(function(){
	 
	
 	var data =$('#form-user-updata').serialize(); 
	$(this).ajaxSubmit({
		type : 'POST',
		url : 'updataAUser.action', 
		dataType : 'json',
		data : data,
		success : function(data) {
			
			var index = parent.layer.getFrameIndex(window.name);
			parent.location.reload();
			parent.layer.close(index);
			layer.msg('更新成功!', { 
				icon : 1,
				time : 2000
			});
			
		},
		error : function(data) {
			var index = parent.layer.getFrameIndex(window.name);
			parent.location.reload();
			parent.layer.close(index);
			console.log(data.msg);
		},
	});
	alert("更新成功");    
	return true; 
});   
    
</script>





</body>
</html>