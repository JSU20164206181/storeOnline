<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<html>
<head>
	<meta charset="utf-8">
	<title>确认订单</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

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
	<link href="assets/corporate/css/style.css" rel="stylesheet">
	<link href="assets/corporate/css/style-responsive.css" rel="stylesheet">
	<link href="assets/corporate/css/themes/red.css" rel="stylesheet"
		  id="style-color">
	<link href="assets/corporate/css/custom.css" rel="stylesheet">
	<!-- Theme styles END -->

	<link href="css/shop.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="plugins/eleme-ui/index.css" />

	<style type="text/css">
		.carousel-inner {
			height: 580px;
		}

		.el-cascader {
			width: 100%;
		}
	</style>
</head>
<body class="ecommerce">

<jsp:include page="goods_head.jsp" />

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	 aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">修改收货地址</h4>
			</div>
			<div class="modal-body">
				<div class="content-form-page">
					<form id="receive-address" role="form"
						  class="form-horizontal form-without-legend">
						<div class="form-group">
							<label class="col-lg-2 control-label" for="Area - City">所在地区<span
									class="require">*</span></label>
							<div class="col-lg-8">
								<div id="myVue">
									<el-form ref="form" :model="form" label-width="100px">
										<el-cascader :options="CityInfo"
													 v-model="form.selectedOptions" :change-on-select="true"
													 :clearable="true" :filterable="true" @change="handleChange">
										</el-cascader></el-form>
									<div hidden="hidden">
										<span id="province_">{{form.city | myAddressCity}}</span> <span
											id="city_">{{form.erae | myAddressErae}}</span> <span
											id="district_">{{form.minerae | myAddressMinerae}}</span> <input
											id="province" name="ra.graProvince"> <input
											id="city" name="ra.graCity"> <input id="district"
																				name="ra.graDistrict"> <input id="graId"
																											  name="ra.graId"> <input id="graUid" name="ra.graUid"
																																	  value="1">
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label" for="street">详细地址<span
									class="require">*</span></label>
							<div class="col-lg-8">
									<textarea id="street" name="ra.graStreet" class="form-control"
											  placeholder="请填写详细地址，长度不超过30个字符" rows="2"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label" for="name">收货人姓名<span
									class="require">*</span></label>
							<div class="col-lg-8">
								<input type="text" id="name" name="ra.graName"
									   class="form-control" placeholder="请填写收货人姓名，长度不超过5个字符">
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label" for="phone">电话<span
									class="require">*</span>
							</label>
							<div class="col-lg-8">
								<input type="text" id="phone" name="ra.graPhone"
									   class="form-control" required="required"
									   placeholder="请填写电话号码，长度不超过11个字符" type="text"
									   pattern="^0?(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}|$"
									   maxlength="11">
							</div>
						</div>
						<div class="modal-footer">
							<input id="close" type="button" class="btn btn-default"
								   value="关闭" data-dismiss="modal"> <input type="button"
																		   class="btn btn-primary" value="保存" data-dismiss="modal"
																		   onclick="save()">
						</div>
					</form>
				</div>
			</div>

		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<div class="main">
	<div class="container">
		<!-- BEGIN SIDEBAR & CONTENT -->
		<div class="row margin-bottom-40">
			<!-- BEGIN CONTENT -->
			<div class="col-md-12 col-sm-12">
				<h1>确认订单信息</h1>
				<div id="shoppingCartNull">
					<div id="shoppingCart" class="goods-page">
						<div class="goods-data clearfix">
							<div class="table-wrapper-responsive">
								<table>
									<tr>
										<th><strong style="color: #e6400c">选择收货地址</strong></th>
										<th></th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
									<c:forEach items="${receiveAddressList }" var="ra"
											   varStatus="i" step="1" begin="0">
										<tr id="receice-address${i.index }">
											<td><input type="radio" name="address"
													   checked="checked" value="${ra.graId }"></td>
											<td style="width: 250px;"><strong
													id="province${i.index }" value="${ra.graProvince }">${ra.graProvince }</strong>-<strong
													id="city${i.index }" value="${ra.graCity }">${ra.graCity }</strong>-<strong
													id="district${i.index }" value="${ra.graDistrict }">${ra.graDistrict }</strong><strong
													id="street${i.index }" value="${ra.graStreet }">${ra.graStreet }</strong></td>
											<td><strong id="name${i.index }" value="${ra.graName }">${ra.graName }</strong></td>
											<td style="width: 50px;"><strong id="phone${i.index }"
																			 value="${ra.graPhone }">${ra.graPhone }</strong></td>
											<td><button class="btn btn-primary" data-toggle="modal"
														data-target="#myModal"
														onclick="updateRa(${ra.graId },${i.index },0)">修改</button>
												<button class="btn btn-primary"
														onclick="deleteRa(${ra.graId },this)">删除</button></td>
										</tr>
									</c:forEach>
									<tr id="raList">
										<td class="goods-page-image"><button
												class="btn btn-primary" data-toggle="modal"
												data-target="#myModal" onclick="addRa(1)">使用新地址</button></td>
										<td></td>
										<td></td>
										<td></td>
										
									</tr>
								</table>
							</div>
							<div class="table-wrapper-responsive">
								<table summary="Shopping cart">
									<tr>
										<th class="goods-page-image">图片</th>
										<th class="goods-page-description">描述</th>
										<th>备注</th>
										<th class="goods-page-price">单价</th>
										<th class="goods-page-quantity">数量</th>
										<th class="goods-page-total" colspan="2">总价</th>
									</tr>
									<tr id="goodsUserId" name="goodsUserId"
										value="${orderGoods.gpUid }">
										<td class="goods-page-image"><a href="javascript:;"><img
												src="${orderGoods.titleImg }"
												alt="Berry Lace Dress"></a></td>
										<td class="goods-page-description">
											<h2>
												<a id="goodsName" href="javascript:;">${orderGoods.gpName }</a>
											</h2> <strong>${orderGoods.gpIntroduce }</strong>
										</td>
										 <form id="goodsForm" method="post" action="buyGoods.action">
											 <input name="userId" value="${cookie.userId.value}" hidden>
											 <input name="goodsId" value="${orderGoods.gpId}" hidden>
											 <input name="addressId" id="addressId" hidden>
											 <input name="goodsUid" value="${orderGoods.gpUid}" hidden>
											<td><textarea id="note" name="note"
														  placeholder="选填,请先和卖家协商一致" rows="3"></textarea></td>
											<td class="goods-page-price"><strong name="price"
																				 value="${orderGoods.gpPromotePrice }"><span>￥${orderGoods.gpPromotePrice}</span></strong>
											</td>
											<td class="goods-page-price">
												<div class="product-quantity">
													<input name="goodsNum" value="${goodsNum}" hidden/>
													<strong>${goodsNum}</strong>
												</div>
											</td>
											 <input name="totalPrice" value="${aggregate }" hidden/>
											<td class="goods-page-total"><strong
													id="total-price" name="total-price"><span>￥${aggregate }</span></strong>
											</td>
										 </form>
									</tr>

								</table>
							</div>

							<div class="shopping-total">
								<ul>
									<li><em>小计</em> <strong id="subtotal" class="price"
															value="${subtotal }"><span>￥</span>${aggregate }</strong></li>
									<li><em>运费</em> <strong id="freight" class="price"
															value="${freight }"><span>￥</span>${freight }</strong></li>
									<li class="shopping-total-price"><em>总计</em> <strong
											id="aggregate" class="price" value="${aggregate }"><span>￥</span>${aggregate }</strong>
									</li>
								</ul>
							</div>
						</div>
						<button class="btn btn-default"
								onclick="searchShopCar.action?userId=${cookie.userId.value }">返回购物车</button>
						<button class="btn btn-primary" onclick="submitOrder()">
							提交订单<i class="fa fa-check"></i>
						</button>
					</div>
				</div>
			</div>
			<!-- END CONTENT -->
		</div>
		<!-- END SIDEBAR & CONTENT -->

		<!-- BEGIN SIMILAR PRODUCTS -->
		<div class="row margin-bottom-40">
			<div class="col-md-12 col-sm-12">
				<h2>最新发布</h2>
				<div class="owl-carousel owl-carousel4">
					<c:forEach items="${requestScope.newGoodsList }" var="products"
							   varStatus="i" step="1" begin="0">
						<div class="product-item">
							<div class="pi-img-wrapper">
								<input name="goodsProductId" value="${products.gpId}" hidden>
								<img src="${products.titleImg }" class="img-responsive"
									 alt="Berry Lace Dress">
								<div>
									<a href="${products.titleImg }"
									   class="btn btn-default fancybox-button">预览</a> <a
										href="#product-pop-up"
										class="btn btn-default fancybox-fast-view">查看</a>
								</div>
							</div>
							<h3>
								<a href="shop-item.html">${products.gpName }</a>
							</h3>
							<div class="pi-price">￥${products.gpPromotePrice} &nbsp;<s>￥${products.gpOriginalPrice}</s></div>
							<a href="javascript:;" class="btn btn-default add2cart"
							   onclick="addShopCar(${products.gpId},${cookie.userId.value})">加入购物车</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- END SIMILAR PRODUCTS -->
	</div>
</div>

<jsp:include page="goods_footer.jsp" />

<!-- Load javascripts at bottom, this will reduce page load time -->
<script src="assets/plugins/jquery.min.js" type="text/javascript"></script>
<script src="assets/plugins/jquery-migrate.min.js"
		type="text/javascript"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
<script src="assets/corporate/scripts/back-to-top.js"
		type="text/javascript"></script>
<script src="assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
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
<script src="assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js"
		type="text/javascript"></script>
<!-- Quantity -->

<script src="assets/corporate/scripts/layout.js" type="text/javascript"></script>
<script src="assets/pages/scripts/bs-carousel.js"
		type="text/javascript"></script>

<script type="text/javascript" src="plugins/vue/vue.min.js"></script>
<script type="text/javascript" src="plugins/eleme-ui/index.js"></script>
<script type="text/javascript" src="plugins/city-picker/city-data.js"></script>
<script type="text/javascript"
		src="js/CivilMilitaryIntegration/ShoppingCart.js"></script>
<script type="text/javascript" src="js/addToShopCar.js"></script>

<script type="text/javascript">
	jQuery(document).ready(function() {
		Layout.init();
		Layout.initOWL();
		Layout.initImageZoom();
		Layout.initTouchspin();

		Layout.initFixHeaderWithPreHeader();
		Layout.initNavScrolling();
	});

	var userId=${cookie.userId.value};//登录用户id
	var graId=null;//收货地址ID
	var row=null;//要修改的行
	var choice=null;//要进行的操作（0：修改，1：新增）
	var province=null;//省
	var city=null;//市
	var district=null;//区（县）
	var street=null;//街道（详细地址）
	var name=null;//收货人姓名
	var phone=null;//收货人电话
	var clear=0;

	$('.product-item').click(function (e) {

		if(e.target.className=="product-item"||e.target.className==""){
			var id = $(e.target).parent().parent().find('input[name=goodsProductId]').val();
			window.open("goodsDetail.action?goodsId="+id);
		}
		else
			return;
	});

	/* 提交订单 */
	function submitOrder() {
		graId = $('input[type=radio]:checked').val();
		var totalPrice=${request.aggregate };
		$('#addressId').val(graId);
		if(graId==null){
			alert("请选择收货地址");
			return false;
		}
		//alert(graId+" "+totalPrice);
		$("#goodsForm").submit();
	}

	/* 修改收货地址 */
	function updateRa(id,i,ch) {
		choice=ch;
		graId=id;
		row=i;
		province=$("#province"+i).attr("value");
		city=$("#city"+i).attr("value");
		district=$("#district"+i).attr("value");
		street=$("#street"+i).attr("value");
		name=$("#name"+i).attr("value");
		phone=$("#phone"+i).attr("value");

		$("#graId").val(graId);
		$("#province").val(province);
		$("#city").val(city);
		$("#district").val(district);
		$("#street").val(street);
		$("#name").val(name);
		$("#phone").val(phone);

		$(".el-cascader__label").html("");
		$(".el-cascader__label").append("<span class='el-cascader__label'>"+province+"<span> / </span>"+city+"<span> / </span>"+district+"</span>");
	}

	$(".el-cascader__label").click(function(){
		if(clear==0){
			$(".el-cascader__label").html("");
			clear=1;
		}
		$.ajax({
			type:'post',
			url:'deleteRaById.action',
			dataType:'json',
			data:{
				graId:graId
			},
			success:function(data){
				$(obj).parents("tr").remove();
				window.location.reload();
			},
			error:function(data){
				console.log("数据删除失败");
				console.log(data.msg);
			},
		})
	})

	/* 新增收货地址 */
	function addRa(ch){
		choice=ch;
	}

	/* 删除收货地址 */
	function deleteRa(id,obj) {
		graId=id;
		var del=confirm("确认删除吗？");
		if(del==true){
			$.ajax({
				type:'post',
				url:'deleteRaById.action',
				dataType:'json',
				data:{
					graId:graId
				},
				success:function(data){
					$(obj).parents("tr").remove();
					window.location.reload();
				},
				error:function(data){
					console.log("数据删除失败");
					console.log(data.msg);
				},
			})
		}
	}

	/* 保存收货地址 */
	function save(){
		if($("#province_").text()!=null||$("#province_").text()!=""){
			$("#province").val($("#province_").text());
		}

		if($("#city_").text()!=null||$("#city_").text()!=""){
			$("#city").val($("#city_").text());
		}

		if($("#district_").text()!=null||$("#district_").text()!=""){
			$("#district").val($("#district_").text());
		}

		if(choice==0){//修改收货地址
			$.ajax({
				type:'post',
				url:'updateRaById.action',
				dataType:'json',
				data:$('#receive-address').serialize(),
				success:function(data){
					window.location.reload();
				},
				error:function(data){
					console.log("数据修改失败");
					console.log(data.msg);
				},
			})
		}else if(choice==1){//新增收货地址
			$.ajax({
				type:'post',
				url:'addRa.action',
				dataType:'json',
				data:$('#receive-address').serialize(),
				success:function(data){
					window.location.reload();
				},
				error:function(data){
					console.log("数据新增失败");
					console.log(data.msg);
				},
			})
		}
	}

	$(".close").click(function () {
		window.location.reload();
	})

	$("#close").click(function () {
		window.location.reload();
	})

</script>
<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
</html>
