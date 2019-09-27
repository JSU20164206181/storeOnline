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
<title>购物车</title>

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

<style>
.carousel-inner {
	height: 580px;
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
					<h1>购物车</h1>
					<div id="shoppingCartNull">
						<div id="shoppingCart" class="goods-page">
							<div class="goods-data clearfix">
								<div class="table-wrapper-responsive">
									<table summary="Shopping cart">
										<tr>
											<th><input type="checkbox" id="checkAll" name="checkAll"
												class="checkAll" value="">&nbsp;全选</th>
											<th class="goods-page-image">图片</th>
											<th class="goods-page-description">描述</th>
											<th class="goods-page-price">单价</th>
											<th class="goods-page-quantity">数量</th>
											<th class="goods-page-total" colspan="2">总价</th>

										</tr>
										<c:forEach items="${shopCarList }" var="goods" varStatus="i"
											step="1" begin="0">
											<tr>
												<td><input type="checkbox" id="check${i.index}"
													name="check" class="check" value="${goods.id }"
													onclick="check(${i.index},this)"></td>
												<td class="goods-page-image"><a
													href="goodsDetail.action?goodsId=${goods.goodsProduct.gpId }"><img
														src="${goods.goodsProduct.titleImg }"
														alt="Berry Lace Dress"></a></td>
												<td class="goods-page-description">
													<h2>
														<a id="goodsName"
															href="goodsDetail.action?goodsId=${goods.goodsProduct.gpId }">${goods.goodsProduct.gpName }</a>
													</h2> <strong>${goods.goodsProduct.gpIntroduce }</strong>
												</td>
												<td class="goods-page-price"><strong name="price"
													value="${goods.goodsProduct.gpPromotePrice }"><span>￥</span>${goods.goodsProduct.gpPromotePrice }</strong>
												</td>
												<td class="goods-page-quantity">
													<div class="product-quantity">
														<input class="product-quantity" name="product-quantity"
															type="number" min="1" max="100"
															value="${goods.goodsNum }"
															onclick="changeQuantity(${i.index},${goods.id },this)"
															onkeyup="inputQuantity(${i.index},${goods.id },this)">
													</div>
												</td>
												<td class="goods-page-total"><strong
													id="total-price${i.index}" name="total-price" value=""><span>￥</span></strong>
												</td>
												<td class="del-goods-col"><a class="del-goods"
													onclick="del(${i.index},${goods.id },this)">&nbsp;</a></td>
											</tr>
										</c:forEach>
										<tr>
											<td><input type="checkbox" id="checkAll" name="checkAll"
												class="checkAll" value="">&nbsp;全选</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</table>
								</div>

								<div class="shopping-total">
									<ul>
										<li><em>小计</em> <strong id="subtotal" class="price"
											value=""><span>￥</span></strong></li>
										<li><em>运费</em> <strong id="freight" class="price"
											value="0"><span>￥</span>0</strong></li>
										<li class="shopping-total-price"><em>总计</em> <strong
											id="aggregate" class="price" value=""><span>￥</span></strong>
										</li>
									</ul>
								</div>
							</div>
							<button class="btn btn-default" onclick="delMultiple()">删除</button>
							<button class="btn btn-primary" onclick="createOrder()">
								结算<i class="fa fa-check"></i>
							</button>
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
	<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>

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
	var price=[];//单价
	var productQuantity=[];//数量
	var totalPrice=[];//总价
	var subtotal=0;//小计
	var freight=0;//运费
	var aggregate=0;//总计
	var totalNum=0;//总数
	var checkNum=0;//已选择的数量
	var checkGoodsId=[];//已选择的商品
    
    $(function(){
    	$.ajax({
    		type:'post',
    		url:'searchShopCar.action',
    		dataType:'json',
    		data:{
    			userId:userId
    		},
    		success:function(data){
    			
    		},
    		error:function(data){
    			console.log(data.msg);
    		},
    	});
    });
	
	/* 进入页面时计算总价 */
	$(function (){
		$("strong[name='price']").each(function(i,obj){
			price.push($(obj).attr("value"));
		});
		totalNum=price.length;
		$("input[name='product-quantity']").each(function(i,obj){
			productQuantity.push(obj.value);
		});
		for(i=0;i<price.length;i++){
			totalPrice[i]=parseFloat((price[i] * productQuantity[i]).toFixed(2));
		}
		$("strong[name='total-price']").each(function(i,obj){
			$(obj).html("<strong name='total-price' value='totalPrice[i]'><span>￥</span>"+totalPrice[i]+"</strong>");
		});
		$("#subtotal").html("<strong id='subtotal' class='price' value='subtotal'><span>￥</span>"+subtotal+"</strong>");
		$("#aggregate").html("<strong id='aggregate' class='price' value='aggregate'><span>￥</span>"+aggregate+"</strong>");
		if($("#goodsName").val()==null){
			$(shoppingCart).remove();
			$("#shoppingCartNull").prepend("<p class='shopping-cart-nullhint'>购物车是空的</p>");
		}
	});
	
	/* 结算（生成订单） */
	function createOrder() {
		if(checkNum!=0){
			window.location.href="createOrder.action?idList="+checkGoodsId+"&subtotal="+subtotal+"&freight="+freight+"&aggregate="+aggregate+"&userId="+userId;
		}else{
			alert("请选择商品");
		}
	}
	
	/* 选择时计算总计 */
	function checked(){
		subtotal=parseFloat(subtotal.toFixed(2));
		freight=parseFloat($("#freight").attr("value"));
		aggregate=subtotal + freight;
		$("#subtotal").html("<strong id='subtotal' class='price' value='subtotal'><span>￥</span>"+subtotal+"</strong>");
		$("#aggregate").html("<strong id='aggregate' class='price' value='aggregate'><span>￥</span>"+aggregate+"</strong>");
	}
	
	/* 点击按键改变数量时计算总价和总计 */
	function changeQuantity(i,id,obj) {
		productQuantity[i]=$(obj).val();
		var goodsNum=productQuantity[i];
		totalPrice[i]=price[i] * productQuantity[i];
		totalPrice[i]=parseFloat(totalPrice[i].toFixed(2));
		$("#total-price"+i).html("<strong name='total-price' value='totalPrice[i]'><span>￥</span>"+totalPrice[i]+"</strong>");
		subtotal=0;
		for(i=0;i<price.length;i++){
			if($("#check"+i).prop("checked")==true){
				subtotal+=parseFloat(totalPrice[i]);
			}
		}
		checked();
		
		updateShopCar(id,goodsNum);
	}
	
	/* 手动输入数量时计算总价和总计 */
	function inputQuantity(i,id,obj){
		productQuantity[i]=$(obj).val();
		if(productQuantity[i]>100){
			productQuantity[i]=100;
			$(obj).val("100");
		}
		if(productQuantity[i]<=0){
			productQuantity[i]=1;
			$(obj).val("1");
		}
		var goodsNum=productQuantity[i];
		totalPrice[i]=price[i] * productQuantity[i];
		totalPrice[i]=parseFloat(totalPrice[i].toFixed(2));
		$("#total-price"+i).html("<strong name='total-price' value='totalPrice[i]'><span>￥</span>"+totalPrice[i]+"</strong>");
		subtotal=0;
		for(i=0;i<price.length;i++){
			if($("#check"+i).prop("checked")==true){
				subtotal+=parseFloat(totalPrice[i]);
			}
		}
		checked();
		
		updateShopCar(id,goodsNum);
	}
	
	/* 点击删除按钮时计算总计 */
	function del(i,id,obj) {
		totalNum-=1;
		if($("#check"+i).prop("checked")==true){
			subtotal=subtotal-totalPrice[i];
			totalPrice[i]=0;
			checkNum-=1;
			if(checkNum==totalNum){
				$("#checkAll").prop("checked",true);
			}
		}else{
			totalPrice[i]=0;
			if(checkNum==totalNum){
				$("#checkAll").prop("checked",true);
			}
		}
		checked();
		$(obj).parents("tr").remove();
		if($("#goodsName").val()==null){
			$(shoppingCart).remove();
			$("#shoppingCartNull").prepend("<p class='shopping-cart-nullhint'>购物车是空的</p>");
		}

		deleteShopCar(id);
		
		console.log(checkNum);
		console.log(totalNum);
	}
	
	/* 删除多个 */
	function delMultiple(){
		for(i=0;i<totalPrice.length;i++){
			if($("#check"+i).prop("checked")==true){
				totalPrice[i]=0;
				checkNum-=1;
				totalNum-=1;
				$("#check"+i).parents("tr").remove();
			}
			subtotal=0;
			checked();
			if($("#goodsName").val()==null){
				$(shoppingCart).remove();
				$("#shoppingCartNull").prepend("<p class='shopping-cart-nullhint'>购物车是空的</p>");
			}
		}
		
		for(var j=0;j<checkGoods.length;j++){
			id=checkGoods[j];
			deleteShopCar(id);
		}
		
		console.log(checkNum);
		console.log(totalNum);
	}
	
	/* 全选/全不选 */
	$(".checkAll").click(function() {
		if($(this).prop("checked")==true){
			$(".check").prop("checked",true);
			$(".checkAll").prop("checked",true);
			checkNum=totalNum;
			subtotal=0;
			for(i=0;i<totalPrice.length;i++){
				subtotal+=parseFloat(totalPrice[i]);
				checked();
				checkGoodsId.push($("#check"+i).val());
			}
		}else{
			$(".check").prop("checked",false);
			$(".checkAll").prop("checked",false);
			checkNum=0;
			subtotal=0;
			checked();
			checkGoodsId=[];
		}
		
		console.log(checkNum);
		console.log(totalNum);
		console.log(checkGoodsId);
	})
	
	/* 逐个选择 */
	function check(i,obj) {
		if($(obj).prop("checked")==true){
			checkNum+=1;
			subtotal+=parseFloat(totalPrice[i]);
			checked();
			checkGoodsId.push($(obj).val());
		}else{
			checkNum-=1;
			subtotal-=parseFloat(totalPrice[i]);
			checked();
			delArrElementByValue(checkGoodsId,$(obj).val());
		}
		if(checkNum==totalNum){
			$(".checkAll").prop("checked",true);
		}else{
			$(".checkAll").prop("checked",false)
		}
		
		console.log(checkNum);
		console.log(totalNum);
		console.log(checkGoodsId);
	}
	
	/* 修改购物车里商品的数量 */
	function updateShopCar(id,goodsNum){
		$.ajax({
			type:'post',
			url:'updateShopCar.action',
			data:{
				id:id,
				goodsNum:goodsNum,
			},
			success:function(data){
				
			},
			error:function(data){
				console.log("数据修改失败");
				console.log(data.msg);
			},
		})
	}
	
	/* 删除购物车里的商品 */
	function deleteShopCar(id){
		$.ajax({
			type:'post',
			url:'deleteShopCar.action',
			data:{
				id:id,
			},
			success:function(data){
				
			},
			error:function(data){
				console.log("数据删除失败");
				console.log(data.msg);
			},
		})
	}
	
	/* 根据值删除数组中的指定元素 */
	function delArrElementByValue(arr, val) {
		for(var i=0;i<arr.length;i++){
			if(arr[i]==val){
				arr.splice(i,1);
				break;
			}
		}
	}
	
	/* 加入购物车 */
	function addShopCar(goodsId, userId) {
		$.ajax({
			url : "${pageContext.request.contextPath}/addShopCar.action",
			type : "post",
			data : {
				'goodsId' : goodsId,
				'userId' : userId
			},
			success : function(data) {
				alert(data);
				window.location.reload();
				if (data == "ok") {
					layer.msg("已成功添加到购物车", {
						icon : 1,
						time : 1000
					});
				} else {
					layer.msg("添加失败", {
						icon : 2,
						time : 1000
					});
				}
			}
		})
	}
</script>
	<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
</html>
