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


<title>订单详情</title>
</head>
<body>
	<div class="cl pd-20" style="background-color: #5bacb6">
		
		<dl style="margin-left: 80px; color: #fff">
			<dt>
				<span class="f-18">订单号:${order.goOrderCode }</span>       
			</dt>
		</dl>
	</div>
	<article class="page-container">
	<form class="form form-horizontal" id="form-user-updata">    
	  <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">下单Id：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goUid } </div>
		</div> 
	     <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">收货人：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goReceiver } </div>
		</div>
	     <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">收货人地址：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goAddress} </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">收货人电话：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goPhone} </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">订单总价：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goTotalPrice} </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">下单时间：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goCreateDate} </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">付款时间：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order. goPayDate} </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">收货时间：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goDeliveryDate} </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">确认收货时间：</label> 
			<div class="formControls col-xs-8 col-sm-9"> ${order.goConfirmDate} </div>
		</div>
		
	 <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3" >商品信息：</label>
				<table	style="width:80%;margin-left:10%"class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
				<thead>
					<tr class="text-c">						
						<th width="30">序号</th>
						<th width="50">卖家ID</th>						
						<th width="60">商品名字</th>
						<th width="40">单价</th>
						<th width="20">数量</th>
						<th width="20">总价</th>
						<th width="140">备注</th>
						<th width="40">状态</th>
				  </tr>
				</thead>
				<tbody>
					<c:forEach var="orderItem" items="${orderItemList}" varStatus="i" step="1">
						<tr class="text-c">
							
							<td>${i.count}</td>
							<td>${orderItem.goiSid}</td>
							<td>${orderItem.goiPname}</td>
							<td>${orderItem.goiPrice}</td>
							<td>${orderItem.goiNumber}</td>
							<td>${orderItem.goiNumber*orderItem.goiPrice}</td>
							<td>${orderItem.goiNote}</td>
							<td>
							<c:if test="${orderItem.goiStatus==0}">
							 <span class="label label-defaunt radius">交易关闭 </span>     			      	
							</c:if>
							<c:if test="${orderItem.goiStatus==1}">
							 <span class="label label-defaunt radius">待付款</span>     			      	
							</c:if>
							<c:if test="${orderItem.goiStatus==2}">
							 <span class="label label-defaunt radius">已付款</span>     			      	
							</c:if>
							<c:if test="${orderItem.goiStatus==3}">
							 <span class="label label-defaunt radius">待收货</span>     			      	
							</c:if>
							<c:if test="${orderItem.goiStatus==4}">
							 <span class="label label-defaunt radius">待评论</span>     			      	
							</c:if>
							<c:if test="${orderItem.goiStatus==5}">
							  <span class="label label-success radius">已评论</span> 			      	
							</c:if>
							 
							</td>		
						</tr>
					</c:forEach>

				</tbody>
			</table>
			
			
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