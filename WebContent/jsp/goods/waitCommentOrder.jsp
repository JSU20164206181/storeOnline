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
<title>待收货订单</title>

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

.orderMessage {
	margin-bottom: 20px;
}

.orderMessage td {
	border: 1px solid #ececec;
}

.orderMessage span {
	color: #666;
}

.title {
	min-width: 62px;
	display: inline-block;
	zoom: 1;
	vertical-align: top;
}

.orderInTro {
	padding: 0;
	background-color: #fbfbfb;
	text-decoration: none;
	font: 12px/1.5 Tahoma, Helvetica, Arial, sans-serif;
	font-style: normal;
	font-variant-ligatures: normal;
	font-variant-caps: normal;
	font-variant-numeric: normal;
	font-variant-east-asian: normal;
	font-weight: normal;
	font-stretch: normal;
	font-size: 12px;
	line-height: 1.5;
	font-family: Tahoma, Helvetica, Arial, sans-serif;
}

.leftTitle {
	background-color: #f3f3f3;
}

.leftTitle h3 {
	margin-left: 20px;
	font-size: 12px;
	color: #333333;
}

.orderInTro li {
	padding: 5px 0px 5px 10px;
	list-style-type: none;
}

.message {
	width: 162px;
	display: inline-block;
	zoom: 1;
	color: #666;
}

.orderInfo {
	font-size: 15px;
}

.chooseOrder ul {
	width: 100%;
	height: 30px;
	padding: 0px;
}

.chooseOrder ul li {
	float: left;
	margin-right: 20px;
	font-size: 20px;
	font-weight: bold;
	list-style: none;
}

.chooseOrder ul li a {
	text-decoration: none;
	color: black;
}

.choose a {
	color: black;
}

.table-wrapper-responsive a {
	text-decoration: none;
}

a:hover {
	color: #e84d1c;
}

.chooseOrder ul li :hover {
	color: #e84d1c;
}
</style>
</head>
<body class="ecommerce">

	<jsp:include page="goods_head.jsp" />


	<div class="main">
		<div class="container">
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<!-- BEGIN CONTENT -->
				<div class="col-md-12 col-sm-12">
					<div class="chooseOrder">
						<ul>
							<li id="all"><a
								href="searchAllOrder.action?userId=${cookie.userId.value }">所有订单</a></li>
							<li id="waitPay"><a
								href="searchOrderByStatus.action?userId=${cookie.userId.value }&status=1">待付款</a></li>
							<li id="waitSend"><a
								href="searchOrderByStatus.action?userId=${cookie.userId.value }&status=2">待发货</a></li>
							<li id="waitReceive"><a
								href="searchOrderByStatus.action?userId=${cookie.userId.value }&status=3">待收货</a></li>
							<li id="waitComment"><a
								href="searchOrderByStatus.action?userId=${cookie.userId.value }&status=4"
								style="color: #e84d1c">待评论</a></li>
						</ul>
					</div>
					<div id="shoppingCartNull">
						<div id="shoppingCart" class="goods-page">
							<div class="goods-data clearfix">
								<div class="table-wrapper-responsive">
									<table summary="Shopping cart">
										<tr>
											<th class="goods-page-image">图片</th>
											<th class="goods-page-description">描述</th>
											<th class="goods-page-price">留言</th>
											<th class="goods-page-price">单价</th>
											<th class="goods-page-quantity">数量</th>
											<th class="goods-page-total">总价</th>
											<th class="goods-page-price">状态</th>
											<th>操作</th>
										</tr>
										<c:forEach items="${goList}" var="go">
											<tr class="orderInfo">
												<td class="date"><strong>${go.goCreateDate }</strong></td>
												<td><a style="color: black;" href="">订单号：${go.goOrderCode }</a></td>
												<td><a style="color: black;" href="showUserGoods.action?userId=${go.goSid }">商家：${go.goSname }</a></td>
												<td></td>
												<td></td>
												<td><strong>${go.goTotalPrice }</strong></td>
												<td><c:if test="${go.goStatus == 0}">
														<strong>交易关闭</strong>
													</c:if> <c:if test="${go.goStatus == 1}">
														<strong>待付款</strong>
													</c:if> <c:if test="${go.goStatus == 2}">
														<strong>已支付</strong>
													</c:if> <c:if test="${go.goStatus == 3}">
														<strong>交易成功</strong>
													</c:if></td>
												<td class="choose" style="position: absolute;right: 20px;"><c:if test="${go.goStatus == 1}">
														<strong><a href="payInfo.action?orderId=${go.goId}">立即付款</a></strong>
													</c:if> <c:if test="${go.goStatus == 2}">
														<strong><a href="">订单详情</a></strong>
													</c:if> <c:if test="${go.goStatus == 3}">
														<strong><a href="">订单详情</a></strong>
													</c:if> <br> <strong><a href="deleteOrder.action?goid=${go.goId}&status=4">删除订单</a></strong></td>
											</tr>
											<c:forEach items="${goiList}" var="goi">
												<c:if test="${go.goOrderCode==goi.goiOrderCode }">
													<tr id="goodsUserId" name="goodsUserId">
														<td class="goods-page-image"><a href="javascript:;"><img
																src="${goi.goodsProduct.titleImg }"
																alt="Berry Lace Dress"></a></td>
														<td class="goods-page-description">
															<h2>
																<a id="goodsName" href="javascript:;">${goi.goiPname }</a>
															</h2> <strong>${goi.goiPname }</strong>
														</td>
														<td><strong id="note" name="note" class="note">${goi.goiNote }</strong></td>
														<td class="goods-page-price"><strong name="price"
															value="${goi.goiPrice }"><span>￥${goi.goiPrice}</span></strong>
														</td>
														<td class="goods-page-price">
															<div class="product-quantity">
																<strong>${goi.goiNumber}</strong>
															</div>
														</td>
														<td class="goods-page-total"><strong id="total-price"
															name="total-price"><span>￥${goi.goiNumber * goi.goiPrice }</span></strong>
														</td>
														<td><c:if test="${goi.goiStatus == 2}">
																<strong>待发货</strong>
															</c:if> <c:if test="${goi.goiStatus == 3}">
																<strong>已发货</strong>
															</c:if> <c:if test="${goi.goiStatus == 4}">
																<strong>待评论</strong>
															</c:if> <c:if test="${goi.goiStatus == 5}">
																<strong>已评论</strong>
															</c:if></td>
														<td class="choose"><c:if test="${goi.goiStatus == 4}">
																<strong><a href="">评论</a></strong>
															</c:if></td>
													</tr>
												</c:if>
											</c:forEach>
										</c:forEach>
									</table>
								</div>
							</div>
							<a class="btn btn-default" type="button"
								href="searchShopCar.action?userId=${cookie.userId.value }">返回购物车</a>
							<a class="btn btn-primary" id="previousPage"
								href="searchOrderByStatus.action?userId=${cookie.userId.value }&status=4&page=${page+1 }">下一页</a>
							<span class="btn btn-primary">${page } / ${totalPage } </span> <a
								class="btn btn-primary" id="nextPage"
								href="searchOrderByStatus.action?userId=${cookie.userId.value }&status=4&page=${page-1 }">上一页</a>
						</div>
					</div>
				</div>
				<!-- END CONTENT -->
			</div>
			<!-- END SIDEBAR & CONTENT -->

			<jsp:include page="goods_newProducts.jsp" />

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

		$('.product-item').click(
				function(e) {
					if (e.target.className == "product-item"
							|| e.target.className == "") {
						var id = $(e.target).parent().parent().find(
								'input[name=goodsProductId]').val();
						window.open("goodsDetail.action?goodsId=" + id);
					} else
						return;
				});

		//隐藏多余字符  
		$(".date").each(function() {
			var len = $(this).text().length; //当前HTML对象text的长度
			if (len > 10) {
				var str = "";
				str = $(this).text().substring(0, 10); //使用字符串截取，获取前10个字符，多余的字符使用“......”代替
				$(this).html('<strong>' + str + '</strong>');//将替换的值赋值给当前对象
			}
		});
	</script>
	<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
</html>
