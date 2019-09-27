<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<style type="text/css">
.removeNote {
	display:inline-block;
	color: rgba(255, 0, 0, 0.4);
	font-weight: bold;
	margin-left: 20px;
}

</style>
<title>修改商品</title>
<meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<%
String id=request.getParameter("id");

%>
<body>
<article class="page-container">
	<form action="updateProduct.action" method="post" class="form form-horizontal" id="form-product-update" enctype="multipart/form-data">  
		<input type="text" class="input-text" value="${product.gpId }" id="gpId" hidden name="gpId"/>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${product.gpName }" placeholder="请填写商品名称(1-20字)" id="gpName" name="gpName"/>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品介绍：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<textarea name="gpIntroduce" cols="" rows="" class="textarea valid" placeholder="商品介绍...最少输入10个字符" >${product.gpIntroduce }</textarea>
				
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>封面图片：</label>
			
			<div class="formControls col-xs-8 col-sm-9">
				<!-- <a href="javascript:;" onclick="picture_edit('图库编辑','picture-show.html','10001')"></a> -->
				<a href="javascript:;" onClick="picture_edit('图库编辑','showProductimageUpdate.action?gpId=${product.gpId }')" >
					<img id="showImg" class="picture-thumb" src="${product.titleImg }" width="210">
				</a>
				<span class="btn-upload form-group">
					<input class="input-text upload-url" value="${product.titleImg }" type="text" name="imgPath" id="uploadImg" readonly="" nullmsg="请添加图片！" style="width:200px" />
					<a href="javascript:void();" class="btn btn-primary radius upload-btn"><i class="Hui-iconfont"></i> 上传图片</a>
					<input id="filePath" type="file" multiple="" name="titleImg"  accept="image/*" class="input-file" onchange="upload()"/>
				</span>
					<p>（点击图片查看图库）</p>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品原价（元）：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${product.gpOriginalPrice }" placeholder="请填写商品原价" id="title" name="gpOriginalPrice"/>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品促销价（元）：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${product.gpPromotePrice }" placeholder="请填写商品促销价" id="title" name="gpPromotePrice"/>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品库存：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${product.gpStock }" placeholder="请填写商品库存" id="title" name="gpStock"/>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品类型：</label>
			<div class="formControls col-xs-8 col-sm-9"> 
				<span class="select-box">
					<select class="select" size="1" name="gpCid" id="category">
						<c:forEach var="category" items="${categoryList}" varStatus="i" step="1">
							<c:if test="${category.gcId==product.gpCid }">
								<option value="${category.gcId}" selected>${category.gcName}</option>
							</c:if>
							<c:if test="${category.gcId!=product.gpCid }">
								<option value="${category.gcId}">${category.gcName}</option>
							</c:if>
						</c:forEach>
					</select>
				</span> 
			</div>
		</div>
		
		
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"></label>
			<div class="formControls col-xs-8 col-sm-9">
				
				<input id="submit" class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;确认修改&nbsp;&nbsp;">
				<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
			
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
> 
<script type="text/javascript" src="lib/datatables/1.10.15/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
$(function(){
	
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form-product-update").validate({
		onfocusout: function(element){
			$(element).valid(); 
		}, 
	
		rules:{
			gpName:{
				required:true,
				minlength:1,
				maxlength:20
			},
			gpIntroduce:{
				required:true,
				minlength:10,
				maxlength:100
			},
			gpOriginalPrice:{
				required:true,
				number:true,
				minlength:1,
				maxlength:11
			},
			gpPromotePrice:{
				required:true,
				number:true,
				minlength:1,
				maxlength:11,
				
			},
			gpStock:{
				required:true,
			 	digits:true,
				minlength:1,
				maxlength:11,
				
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		
		
	});
	
	
	
});
</script> 

<script type="text/javascript">
/*图片-编辑*/
function picture_edit(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
	//限制只能上传图片
	function upload() {
	    var _name, _fileName, personsFile;
	    personsFile = document.getElementById("filePath");
	    _name = personsFile.value;
	    _fileName = _name.substring(_name.lastIndexOf(".") + 1).toLowerCase();
	    console.log(_name)
	    if (_fileName !== "png" && _fileName !== "jpg") {
	        alert("上传图片格式不正确，请重新上传");
	    } else {
	        document.getElementById("showImg").src = window.URL.createObjectURL(personsFile.files[0]);
	    }
	}
	
	
	

	/*
	$('#form-vote-update').submit(function(){
		
		
		var data = $('#form-vote-update').serialize();
		$(this).ajaxSubmit({
			type : 'POST',
			url : 'updateVote.action',  
			dataType : 'json',
			data : data,

			success : function(data) {
				var index = parent.layer.getFrameIndex(window.name);
				parent.location.reload();
				parent.layer.close(index);
				
			},
			error : function(data) {
				var index = parent.layer.getFrameIndex(window.name);
				parent.location.reload();
				parent.layer.close(index);
				console.log(data.msg);
			},
		});
		alert("修改成功。"); 
		return true;
	});
	*/
	
</script>

<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>