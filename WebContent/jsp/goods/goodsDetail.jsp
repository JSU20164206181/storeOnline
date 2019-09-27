<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/8/8
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<base href="<%=basePath%>">
<html>
<head>
    <meta charset="utf-8">
    <title>商品详情</title>

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
    <link href="assets/plugins/owl.carousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="assets/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
    <link href="assets/plugins/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <!-- Page level plugin styles END -->

    <!-- Theme styles START -->
    <link href="assets/pages/css/components.css" rel="stylesheet">
    <link href="assets/pages/css/slider.css" rel="stylesheet">
    <link href="assets/pages/css/style-shop.css" rel="stylesheet" type="text/css">
    <link href="assets/corporate/css/style.css" rel="stylesheet">
    <link href="assets/corporate/css/style-responsive.css" rel="stylesheet">
    <link href="assets/corporate/css/themes/red.css" rel="stylesheet" id="style-color">
    <!-- Theme styles END -->

    <link href="css/shop.css" rel="stylesheet" type="text/css">

    <style>
        .carousel-inner{
            height: 580px;
        }

        .review{
            font-size: 16px;
            font-weight: 500;
        }

        .inputNum{
            font: 300 23px 'Open Sans', sans-serif;
            border: none;
            color: #647484;
            height: 38px;
            width: 70px;
            text-align: center;
            background: #EDEFF1;
            padding: 5px;
        }

        .photos-thumb{
            padding: 0px;
            margin: 10px 0;
            list-style-type: none;
            height: 40px;
        }

        .photos-thumb li{
            float: left;
            border: 2px solid #f2f2f2;
            padding: 2px;
            margin-right: 8px;
            position: relative;
            transition: border-color .2s ease-out;
        }

        .photos-thumb img{
            display: block;
            width: 40px;
            height: 40px;
        }

    </style>
</head>
<body class="ecommerce">

<jsp:include page="goods_head.jsp"/>
<div class="main">
    <div class="container">
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">


            <!-- BEGIN CONTENT -->
            <div class="col-md-9 col-sm-7">
                <div class="product-page">
                    <div class="row">
                        <div class="col-md-6 col-sm-6">
                            <div class="product-main-image">
                                <img src="${goods.titleImg}" id="titleImg" alt="Cool green dress with red bell" style="width: 500px;
    height: 510px;" class="img-responsive" data-BigImgsrc="${goods.titleImg}">
                            </div>
                            <div class="product-other-images">
                                <c:forEach items="${goods.goodsProductimages}" var="Img">
                                <a href="javascript:;" class="fancybox-button" rel="photos-lib"><img alt="Berry Lace Dress" class="goodsImg" src="${Img.gpiUrl}"></a>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6"  >
                            <h1>${goods.gpName}</h1>
                            <div class="price-availability-block clearfix">
                                <div class="price">
                                    <strong><span>$</span>${goods.gpPromotePrice}</strong>
                                    <em>$<span>${goods.gpOriginalPrice}</span></em>
                                </div>
                                <div class="availability">
                                    商品状态: <strong>在售</strong>
                                </div><br>


                            </div>
                            <div class="description" style="margin-top: 10px;">
                                商品库存：<strong>${goods.gpStock}</strong>
                            </div>
                            <div class="description" style="margin-top: 10px;">
                                商品描述：<p>${goods.gpIntroduce}.</p>
                            </div>

                            <form action="pucharseGoods.action" method="post">
                            <div class="product-page-cart" style="margin-top: 150px;">
                                <div class="product-quantity">
                                    <input name="goodsId" value="${goods.gpId}" hidden>
                                    <input name="userId" value="${cookie.userId.value}" hidden>
                                    <input id="product-quantity" type="number" name="goodsNumber" value="1" step="1" min="1" max="${goods.gpStock}" class="inputNum">
                                </div>
                                <button class="btn btn-primary" type="button" onclick="addShopCar(${goods.gpId},${cookie.userId.value})">添加到购物车</button>
                                <button class="btn btn-primary" type="submit">立即购买</button>
                            </div>
                            </form>
                            <div class="review">
                                <div class="rateit" data-rateit-value="${goods.gpStar}" data-rateit-ispreset="true" data-rateit-readonly="true"></div>
                                <a href="javascript:;">${commandNum} 条评论</a>&nbsp;&nbsp;|&nbsp;&nbsp;<span style="color: #e6400c;">${goods.gpStar}分</span>
                            </div>

                        </div>

                        <div class="product-page-content">
                            <ul id="myTab" class="nav nav-tabs">
                                <li><a href="#Description" data-toggle="tab">描述</a></li>
                                <li><a href="#Information" data-toggle="tab">商品参数</a></li>
                                <li class="active"><a href="#Reviews" data-toggle="tab">评论(${commandNum})</a></li>
                            </ul>
                            <div id="myTabContent" class="tab-content">
                                <div class="tab-pane fade" id="Description">
                                    <p>商品描述：${goods.gpIntroduce}</p>
                                </div>
                                <div class="tab-pane fade" id="Information">
                                    <table class="datasheet">
                                        <tr>
                                            <th colspan="2">商品参数</th>
                                        </tr>
                                        <tr>
                                            <td class="datasheet-features-type">长度</td>
                                            <td>21 cm</td>
                                        </tr>
                                        <tr>
                                            <td class="datasheet-features-type">重量</td>
                                            <td>700 gr.</td>
                                        </tr>
                                        <tr>
                                            <td class="datasheet-features-type">Value 3</td>
                                            <td>10 person</td>
                                        </tr>
                                        <tr>
                                            <td class="datasheet-features-type">Value 4</td>
                                            <td>14 cm</td>
                                        </tr>
                                        <tr>
                                            <td class="datasheet-features-type">Value 5</td>
                                            <td>plastic</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="tab-pane fade in active" id="Reviews">
                                    <c:if test="${empty commandList}">
                                        还没有用户填写评论哦
                                    </c:if>
                                    <!--<p>There are no reviews for this product.</p>-->
                                    <c:forEach items="${commandList}" var="command">
                                    <div class="review-item clearfix">
                                        <div class="review-item-submitted">
                                            <strong>${command.goodsUser.guName}</strong>
                                            <em><fmt:formatDate value="${command.grCreatTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></em>
                                            <div class="rateit" data-rateit-value="${command.grStar}" data-rateit-ispreset="true" data-rateit-readonly="true"><span>${command.grStar}分</span></div>
                                        </div>
                                        <div class="cm-photos">
                                            <ul class="photos-thumb">
                                                <div class="review-item-content">
                                                    <p>${command.grContent}</p>
                                                </div>
                                                <c:forEach items="${command.goodsCommandImgSet}" var="commandImg">
                                                    <li>
                                                        <a href="${commandImg.url }"
                                                           class="btn btn-default fancybox-button" style="padding: 0px;">
                                                            <img src="${commandImg.url}"></a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>

                                    </div>
                                    </c:forEach>

                                    <!-- BEGIN FORM-->
                                <%--    <form action="#" class="reviews-form" role="form">
                                        <h2>写评论</h2>
                                        <div class="form-group">
                                            <label for="name">名字<span class="require">*</span></label>
                                            <input type="text" class="form-control" id="name">
                                        </div>
                                        <div class="form-group">
                                            <label for="email">邮箱</label>
                                            <input type="text" class="form-control" id="email">
                                        </div>
                                        <div class="form-group">
                                            <label for="review">评论<span class="require">*</span></label>
                                            <textarea class="form-control" rows="8" id="review"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="email">评分</label>
                                            <input type="range" value="4" step="0.25" id="backing5">
                                            <div class="rateit" data-rateit-backingfld="#backing5" data-rateit-resetable="false"  data-rateit-ispreset="true" data-rateit-min="0" data-rateit-max="5">
                                            </div>
                                        </div>
                                        <div class="padding-top-20">
                                            <button type="submit" class="btn btn-primary">发布</button>
                                        </div>
                                    </form>--%>
                                    <!-- END FORM-->
                                </div>
                            </div>
                        </div>

                        <div class="sticker sticker-sale"></div>
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
<script src="assets/plugins/rateit/src/jquery.rateit.js" type="text/javascript"></script>

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

    $('.tableButton').live('mouseover',function() {
        $(this).next().show(100);
    }).live('mouseout',function() {
        $(this).next().hide(100);
    });
    $('.goodsImg').live('click',function() {
        console.log($(this).attr("src"));
        $('#titleImg').attr('src',$(this).attr("src"));
        $('#titleImg').next().attr('src',$(this).attr("src"));
        $('#titleImg').next().attr({height:"300px",width:"550px"});
    });/*.live('mouseout',function() {
        $('#titleImg').attr('src','${goods.titleImg}');
    })*/
</script>
<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
</html>
