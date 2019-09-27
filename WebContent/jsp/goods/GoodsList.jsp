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
    <title>商品列表</title>

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

    </style>
</head>
<body class="ecommerce">

<jsp:include page="goods_head.jsp"/>
<!-- BEGIN SLIDER -->
<div class="page-slider margin-bottom-35">
    <div id="carousel-example-generic" class="carousel slide carousel-slider">

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

                <c:if test="${empty goodsList}">
                    <img src="img/null.png"/>
                    <p>没有找到你要找的商品：</p>
                    <p>你可以：</p>
                    <p> <a href="javascript:history.back();">返回</a></p>
                    <p> <a href="allGoods.action">返回主界面</a></p>

                </c:if>
                <!-- BEGIN PRODUCT LIST -->
                <div class="row product-list">
                    <!-- PRODUCT ITEM START -->
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

                                <a href="javascript:;" onclick="addShopCar(${goods.gpId},${cookie.userId.value})" class="btn btn-default add2cart">添加到购物车</a>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- PRODUCT ITEM END -->

                </div>
                <!-- END PRODUCT LIST -->
                <!-- BEGIN PAGINATOR -->
                <div class="row" id="page">
                    <div class="col-md-4 col-sm-4 items-info">总${totalPage}页</div>
                    <div class="col-md-8 col-sm-8">
                        <ul class="pagination pull-right">
                            <li>
                                <c:choose>
                                    <c:when test="${currentPage>1}">
                                        <a href="showTypeGoods.action?type=${type}&page=${currentPage-1}">&laquo;</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:;">&laquo;</a>
                                    </c:otherwise>
                                </c:choose>

                            </li>
                                <c:choose>
                                    <c:when test="${totalPage <=6}">
                                        <c:set var="begin" value="1"/>
                                        <c:set var="end" value="${totalPage}"/>
                                    </c:when>
                                    <%--页数超过6页--%>
                                    <c:otherwise>
                                        <c:set var="begin" value="${currentPage-1}"/>
                                        <c:set var="end" value="${currentPage+3}"/>

                                        <%--begin减一后为0，设置起始页为1，最大页为6--%>
                                        <c:if test="${begin-1 <= 0}">
                                                <c:set var="begin" value="1"/>
                                        <c:set var="end" value="totalPage"/>
                                        </c:if>

                                        <%--end超过最大页数--%>
                                        <c:if test="${end > totalPage}">
                                            <c:set var="begin" value="${totalPage-5}"/>
                                            <c:set var="end" value="${totalPage}"/>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>

                            <c:forEach var="i" begin="${begin}" end="${end}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <li><span>${i}</span></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="showTypeGoods.action?type=${type}&page=${i}">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                            <li>
                            <c:choose>
                                <c:when test="${currentPage<totalPage}">
                                    <a href="showTypeGoods.action?type=${type}&page=${currentPage+1}">&raquo;</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:;">&raquo;</a>
                                </c:otherwise>
                            </c:choose>
                            </li>
                        </ul>
                    </div>
                </div>
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

<!--[endif]-->
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
<c:if test="${not empty type }">
    <script>
        var i = ${type};
        $("#mainMenu li").eq((i-1)).children().css("color","#ff5000");
    </script>
</c:if>
</html>
