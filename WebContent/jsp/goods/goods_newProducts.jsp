<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>最新发布</title>
<style type="text/css">
.del {
	font-size: 15px;
	color: #999;
}
</style>
</head>
<body>
	<!-- BEGIN SIMILAR PRODUCTS -->
	<div class="row margin-bottom-40">
		<div class="col-md-12 col-sm-12">
			<h2>最新发布</h2>
			<div class="owl-carousel owl-carousel4">
				<c:forEach items="${GoodsProductList }" var="products" varStatus="i"
					step="1" begin="0">
					<div class="product-item">
						<div class="pi-img-wrapper">
							<img src="${products.titleImg }" class="img-responsive"
								alt="Berry Lace Dress">
							<div>
								<a href="${products.titleImg }"
									class="btn btn-default fancybox-button">预览</a> <a
									href="goodsDetail.action?goodsId=${products.gpId }"
									class="btn btn-default fancybox-fast-view">查看</a>
							</div>
						</div>
						<h3>
							<a href="shop-item.html">${products.gpName }</a>
						</h3>
						<div class="pi-price">
							￥${products.gpPromotePrice }&nbsp;
							<del class="del">￥${products.gpOriginalPrice }</del>
						</div>
						<a href="javascript:;" class="btn btn-default add2cart"
							onclick="addShopCar(${products.gpId},${cookie.userId.value})">加入购物车</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- END SIMILAR PRODUCTS -->
</body>
</html>