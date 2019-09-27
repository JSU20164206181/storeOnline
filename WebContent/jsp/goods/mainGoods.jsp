<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/8/8
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<base href="<%=basePath%>">
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- Fonts START -->
    <!-- Fonts END -->

    <!-- Global styles START -->
    <link href="assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Global styles END -->

    <!-- Page level plugin styles START -->
    <link href="assets/pages/css/animate.css" rel="stylesheet">
    <link href="assets/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
    <link href="assets/plugins/owl.carousel/assets/owl.carousel.css" rel="stylesheet">
    <!-- Page level plugin styles END -->

    <!-- Theme styles START -->
    <link href="assets/pages/css/components.css" rel="stylesheet">
    <link href="assets/pages/css/slider.css" rel="stylesheet">
    <link href="assets/pages/css/style-shop.css" rel="stylesheet" type="text/css">
    <link href="assets/corporate/css/style.css" rel="stylesheet">
    <link href="assets/corporate/css/style-responsive.css" rel="stylesheet">
    <link href="assets/corporate/css/themes/red.css" rel="stylesheet" id="style-color">
    <link href="assets/corporate/css/custom.css" rel="stylesheet">
    <!-- Theme styles END -->

    <link href="css/shop.css" rel="stylesheet" type="text/css">

    <style>
        .carousel-inner{
            height: 580px;
        }
    </style>
</head>
<body class="ecommerce">

<jsp:include page="goods_head.jsp"/>
<!-- BEGIN SLIDER -->
<div class="page-slider margin-bottom-35">
    <div id="carousel-example-generic" class="carousel slide carousel-slider">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            <li data-target="#carousel-example-generic" data-slide-to="3"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <!-- First slide -->
            <div class="item carousel-item-four active">
                <div class="container">
                    <div class="carousel-position-four text-center">
                        <h2 class="margin-bottom-20 animate-delay carousel-title-v3 border-bottom-title text-uppercase" data-animation="animated fadeInDown">
                            Tones of <br/><span class="color-red-v2">Shop UI Features</span><br/> designed
                        </h2>
                        <p class="carousel-subtitle-v2" data-animation="animated fadeInUp">Lorem ipsum dolor sit amet constectetuer diam <br/>
                            adipiscing elit euismod ut laoreet dolore.</p>
                    </div>
                </div>
            </div>

            <!-- Second slide -->
            <div class="item carousel-item-five">
                <div class="container">
                    <div class="carousel-position-four text-center">
                        <h2 class="animate-delay carousel-title-v4" data-animation="animated fadeInDown">
                            Unlimted
                        </h2>
                        <p class="carousel-subtitle-v2" data-animation="animated fadeInDown">
                            Layout Options
                        </p>
                        <p class="carousel-subtitle-v3 margin-bottom-30" data-animation="animated fadeInUp">
                            Fully Responsive
                        </p>
                        <a class="carousel-btn" href="#" data-animation="animated fadeInUp">See More Details</a>
                    </div>
                    <img class="carousel-position-five animate-delay hidden-sm hidden-xs" src="assets/pages/img/shop-slider/slide2/price.png" alt="Price" data-animation="animated zoomIn">
                </div>
            </div>

            <!-- Third slide -->
            <div class="item carousel-item-six">
                <div class="container">
                    <div class="carousel-position-four text-center">
							<span class="carousel-subtitle-v3 margin-bottom-15" data-animation="animated fadeInDown">
								Full Admin &amp; Frontend
							</span>
                        <p class="carousel-subtitle-v4" data-animation="animated fadeInDown">
                            eCommerce UI
                        </p>
                        <p class="carousel-subtitle-v3" data-animation="animated fadeInDown">
                            Is Ready For Your Project
                        </p>
                    </div>
                </div>
            </div>

            <!-- Fourth slide -->
            <div class="item carousel-item-seven">
                <div class="center-block">
                    <div class="center-block-wrap">
                        <div class="center-block-body">
                            <h2 class="carousel-title-v1 margin-bottom-20" data-animation="animated fadeInDown">
                                The most <br/>
                                wanted bijouterie
                            </h2>
                            <a class="carousel-btn" href="#" data-animation="animated fadeInUp">But It Now!</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control carousel-control-shop" href="#carousel-example-generic" role="button" data-slide="prev">
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </a>
        <a class="right carousel-control carousel-control-shop" href="#carousel-example-generic" role="button" data-slide="next">
            <i class="fa fa-angle-right" aria-hidden="true"></i>
        </a>
    </div>
</div>
<!-- END SLIDER -->
<div class="main">
    <div class="container">
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <!-- BEGIN CONTENT -->
            <div class="col-md-12 col-sm-7">
                <!-- BEGIN PRODUCT LIST -->
                <div class="row product-list">
                    <!-- PRODUCT ITEM START -->
                    <c:if test="${empty goodsList}">
                       <script>
                           window.location="allGoods.action";
                       </script>
                    </c:if>

                    <c:forEach items="${goodsList}" begin="0" end="3" var="goods">
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <input name="goodsProductId" value="${goods.gpId}" hidden>
                                    <img src="${goods.titleImg}" class="img-responsive" alt="Berry Lace Dress">
                                    <div>
                                        <a href="${goods.titleImg}" class="btn btn-default fancybox-button">预览</a>
                                        <a href="#product-pop-up" class="btn btn-default fancybox-fast-view">查看</a>
                                    </div>
                                </div>
                                <h2><a href="shop-item.html" style="color:#403b3c">${goods.gpName}</a></h2>
                                <div class="pi-price">￥${goods.gpPromotePrice} &nbsp;<s>￥${goods.gpOriginalPrice}</s>
                                </div>

                                <a href="javascript:;" onclick="addShopCar(${goods.gpId},${cookie.userId.value})" class="btn btn-default add2cart">添加购物车</a>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- PRODUCT ITEM END -->
                </div>
                <!-- END PRODUCT LIST -->
                <!-- BEGIN PRODUCT LIST -->
                <div class="row product-list">
                    <!-- PRODUCT ITEM START -->
                    <c:forEach items="${goodsList}" begin="4" end="7" var="goods">
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <input name="goodsProductId" value="${goods.gpId}" hidden>
                                    <img src="${goods.titleImg}" class="img-responsive" alt="Berry Lace Dress">
                                    <div>
                                        <a href="${goods.titleImg}" class="btn btn-default fancybox-button">预览</a>
                                        <a href="#product-pop-up" class="btn btn-default fancybox-fast-view">查看</a>
                                    </div>
                                </div>
                                <h2><a href="shop-item.html" style="color:#403b3c">${goods.gpName}</a></h2>
                                <div class="pi-price">￥${goods.gpPromotePrice} &nbsp;<s>￥${goods.gpOriginalPrice}</s>
                                </div>

                                <a href="javascript:;"  onclick="addShopCar(${goods.gpId},${cookie.userId.value})" class="btn btn-default add2cart">添加到购物车</a>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- PRODUCT ITEM END -->

                </div>
                <!-- END PRODUCT LIST -->
                <!-- BEGIN PRODUCT LIST -->
                <div class="row product-list">
                    <!-- PRODUCT ITEM START -->
                    <c:forEach items="${goodsList}" begin="8" end="11" var="goods">
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="product-item">
                                <div class="pi-img-wrapper">
                                    <input name="goodsProductId" value="${goods.gpId}" hidden>
                                    <img src="${goods.titleImg}" class="img-responsive" alt="Berry Lace Dress">
                                    <div>
                                        <a href="${goods.titleImg}" class="btn btn-default fancybox-button">预览</a>
                                        <a href="#product-pop-up" class="btn btn-default fancybox-fast-view">查看</a>
                                    </div>
                                </div>
                                <h2><a href="shop-item.html" style="color:#403b3c">${goods.gpName}</a></h2>
                                <div class="pi-price">￥${goods.gpPromotePrice} &nbsp;<s>￥${goods.gpOriginalPrice}</s>
                                </div>

                                <a href="javascript:;"  onclick="addShopCar(${goods.gpId},${cookie.userId.value})" class="btn btn-default add2cart">添加到购物车</a>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- PRODUCT ITEM END -->
                </div>
                <!-- BEGIN PAGINATOR -->
              <%--  <div class="row">
                    <div class="col-md-4 col-sm-4 items-info">总100页</div>
                    <div class="col-md-8 col-sm-8">
                        <ul class="pagination pull-right">
                            <li><a href="javascript:;">&laquo;</a></li>
                            <li><a href="javascript:;">1</a></li>
                            <li><span>2</span></li>
                            <li><a href="javascript:;">3</a></li>
                            <li><a href="javascript:;">4</a></li>
                            <li><a href="javascript:;">5</a></li>
                            <li><a href="javascript:;">&raquo;</a></li>
                        </ul>
                    </div>
                </div>--%>
                <!-- END PAGINATOR -->
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </div>
</div>

<jsp:include page="goods_footer.jsp"/>

<!-- BEGIN fast view of a product -->
<%--<div id="product-pop-up" style="display: none; width: 700px;">
    <div class="product-page product-pop-up">
        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-3">
                <div class="product-main-image">
                    <img src="assets/pages/img/products/model7.jpg" alt="商品名称" class="img-responsive">
                </div>
                <div class="product-other-images">
                    <a href="javascript:;" class="active"><img alt="Berry Lace Dress" src="assets/pages/img/products/model3.jpg"></a>
                    <a href="javascript:;"><img alt="Berry Lace Dress" src="assets/pages/img/products/model4.jpg"></a>
                    <a href="javascript:;"><img alt="Berry Lace Dress" src="assets/pages/img/products/model5.jpg"></a>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-9">
                <h2>商品名称</h2>
                <div class="price-availability-block clearfix">
                    <div class="price">
                        <strong><span>$</span>47.00</strong>
                        <em>$<span>62.00</span></em>
                    </div>
                    <div class="availability">
                        商品状态: <strong>在售</strong>
                    </div>
                </div>
                <div class="description">
                    <p>商品描述</p>
                </div>
                <div class="product-page-cart">
                    <div class="product-quantity">
                        <input id="product-quantity" type="text" value="1" readonly name="product-quantity" class="form-control input-sm">
                    </div>
                    <button class="btn btn-primary" type="submit">添加到购物车</button>
                    <a href="shop-item.html" class="btn btn-default">查看详情</a>
                </div>
            </div>
            <div class="sticker sticker-sale"></div>
        </div>
    </div>
</div>--%>
<!-- END fast view of a product -->


<script src="lib/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script src="assets/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="assets/corporate/scripts/back-to-top.js" type="text/javascript"></script>
<script src="assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL JAVASCRIPTS (REQUIRED ONLY FOR CURRENT PAGE) -->
<script src="assets/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script><!-- pop up -->
<script src="assets/plugins/owl.carousel/owl.carousel.min.js" type="text/javascript"></script><!-- slider for products -->
<script src="assets/plugins/zoom/jquery.zoom.min.js" type="text/javascript"></script><!-- product zoom -->
<script src="assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script><!-- Quantity -->

<script src="assets/corporate/scripts/layout.js" type="text/javascript"></script>
<script src="assets/pages/scripts/bs-carousel.js" type="text/javascript"></script>
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
                        icon: 1,
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
