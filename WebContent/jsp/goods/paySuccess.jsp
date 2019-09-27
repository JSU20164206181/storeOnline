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
	<title>付款成功</title>

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
    <link rel="stylesheet"  type="text/css" href="css/orderMessage.css">
</head>
<body class="ecommerce">

<jsp:include page="goods_head.jsp" />

<!-- 模态框（Modal） -->

<div class="main">
	<div class="container">
		<!-- BEGIN SIDEBAR & CONTENT -->
		<div class="row margin-bottom-40">
			<!-- BEGIN CONTENT -->
			<div class="col-md-12 col-sm-12">
				<h1>交易成功</h1>
				<table width="100%" class="orderMessage">
				<tr>
				<div class="date-reactid">
                    <div class="orderDate">
						<td width="23%">
							<div class="leftTitle">
								<h8>订单信息</h8>
							</div>
						<ul class="orderInTro">
							<li><div class="title"><span>收货地址：</span></div>
								<div class="message"><span>${order.goReceiver},${order.goPhone},${order.goAddress}</span></div>
							</li>
							<li><div class="title"><span>买家留言：</span></div>
								<div class="message"><span>heheda</span></div>
							</li>
							<li><div class="title"><span>订单编号：</span></div>
								<div class="message"><span>${order.goOrderCode}</span></div>
							</li>
							<li><div class="title"><span>商家：</span></div>
								<div class="message"><a href="showUserGoods.action?userId=${order.goSid}"><span style="color: red">${order.goSname}</span></a></div>
							</li>
						</ul>
						</td>
					</div>

					<td>
					<div class="sUserDate">
						<div>
							<c:if test="${order.goStatus>1}">
							<strong><img src="https://img.alicdn.com/tps/i1/T1e.aoXuXdXXa94Hfd-32-32.png" style="margin-left: 20px"><span>交易成功</span></strong>
							</c:if>

							<span>订单状态：</span>
							<span>
							<c:choose>
								<c:when test="${order.goStatus==1}">
									待付款
								</c:when>
								<c:when test="${order.goStatus==2}">
									待发货
								</c:when>
								<c:when test="${order.goStatus==3}">
									待收货
								</c:when>
								<c:when test="${order.goStatus==4}">
									待确认收货
								</c:when>
								<c:when test="${order.goStatus==5}">
									待评价
								</c:when>
								<c:when test="${order.goStatus==6}">
									已完成
								</c:when>
							</c:choose>
						</span>
						</div>
					</div>
					</td>

				</div>
				</tr>
				</table>
				<h1 style="clear: both;">商品信息</h1>
				<div id="shoppingCartNull">
					<div id="shoppingCart" class="goods-page">
						<div class="goods-data clearfix">
							<div class="table-wrapper-responsive">
								<table summary="Shopping cart">
									<tr>
										<th class="goods-page-image">图片</th>
										<th class="goods-page-description">描述</th>
										<th>留言</th>
										<th class="goods-page-price">单价</th>
										<th class="goods-page-quantity">数量</th>
										<th class="goods-page-total" colspan="2">总价</th>
									</tr>
									<c:forEach items="${order.goodsOrderitemSet}" var="orderGoods">
									<tr id="goodsUserId" name="goodsUserId">

										<td class="goods-page-image"><a href="javascript:;"><img
												src="${orderGoods.goodsProduct.titleImg }"
												alt="Berry Lace Dress"></a></td>
										<td class="goods-page-description">
											<h2>
												<a id="goodsName" href="javascript:;">${orderGoods.goodsProduct.gpName }</a>
											</h2> <strong>${orderGoods.goodsProduct.gpIntroduce }</strong>
										</td>
											<td><textarea id="note" name="note"
														  placeholder="您没有填写留言" rows="3"  readonly="readonly">${orderGoods.goiNote}</textarea></td>
											<td class="goods-page-price"><strong name="price"
																				 value="${orderGoods.goiPrice }"><span>￥${orderGoods.goiPrice}</span></strong>
											</td>
											<td class="goods-page-price">
												<div class="product-quantity">
													<strong>${orderGoods.goiNumber}</strong>
												</div>
											</td>
											<td class="goods-page-total"><strong
													id="total-price" name="total-price"><span>￥${orderGoods.goiNumber*orderGoods.goiPrice }</span></strong>
											</td>
									</tr>
									</c:forEach>

								</table>
							</div>

							<div class="shopping-total">
								<ul>
									<li><em>小计</em> <strong id="subtotal" class="price"
															value="${subtotal }"><span>￥</span>${order.goTotalPrice }</strong></li>
									<li><em>运费</em> <strong id="freight" class="price"
															value="${freight }"><span>￥</span>${freight }</strong></li>
									<li class="shopping-total-price"><em>实付</em> <strong
											id="aggregate" class="price" value="${order.goTotalPrice }"><span>￥</span>${order.goTotalPrice }</strong>
									</li>
								</ul>
							</div>
						</div>
						<a href="searchShopCar.action?userId=${cookie.userId.value }" class="btn btn-default"
								>返回购物车</a>

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

	$('.product-item').click(function (e) {

		if(e.target.className=="product-item"||e.target.className==""){
			var id = $(e.target).parent().parent().find('input[name=goodsProductId]').val();
			window.open("goodsDetail.action?goodsId="+id);
		}
		else
			return;
	})

	function addShopCar(goodsId,userId){
		$.ajax({
			url:"${pageContext.request.contextPath}/addShopCar.action",
			type:"post",
			data:{
				'goodsId':goodsId,
				'userId':userId
			},
			success:function (data) {
				if (data == "ok"){
					layer.msg("已成功添加到购物车",{
						icon: 1,offset:'40%',
						time: 1000
					});
				}else {
					layer.msg("添加失败",{
						icon: 2,
						time: 1000
					});
				}
			}
		})
	}



</script>
<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
</html>
