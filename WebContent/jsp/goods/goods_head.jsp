<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/8/8
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="utf-8">
</head>
<style>
.active1 {
	color: #ff5000;
}

#page {
	margin-bottom: 70px;
}
</style>
<body>

<!-- BEGIN TOP BAR -->
<div class="pre-header">
    <div class="container">
        <div class="row">
            <!-- BEGIN TOP BAR LEFT PART -->
            <div class="col-md-6 col-sm-6 additional-shop-info">
                <ul class="list-unstyled list-inline">
                    <li><i class="fa fa-phone"></i><span>服务热线：1234567890</span></li>
                </ul>
            </div>
            <!-- END TOP BAR LEFT PART -->
            <!-- BEGIN TOP BAR MENU -->
            <div class="col-md-6 col-sm-6 additional-nav">
                <ul class="list-unstyled list-inline pull-right"> 
                
                <c:if test="${sessionScope.userName!=null}">
                    <li><a>尊敬的${sessionScope.userName},您好</a></li>
                    <li><a href=showUser.action>个人中心</a></li>
                    <li><a href=logout.action>退出登录</a></li>
                </c:if>
                <c:if test="${sessionScope.userName==null}">
                   <li><a href=jsp/goods/login.jsp>您还没有登录,请登录</a></li>
                   <li><a href=jsp/goods/register.jsp>还未注册?</a></li>
                </c:if>
                
                   
                </ul>
            </div>
            <!-- END TOP BAR MENU -->
        </div>
    </div>
</div>
<!-- END TOP BAR -->



	<!-- BEGIN HEADER -->
	<div class="header">
		<a class="site-logo" href="allGoods.action"><img
			src="assets/corporate/img/logos/logo-shop-red.png" alt=""></a>
		<div class="container">
			<!-- BEGIN CART -->
			<div class="top-cart-block">
				<div class="top-cart-info">
					<strong><a href="searchShopCar.action?userId=${cookie.userId.value }">购物车</a></strong>
				</div>
				<a href="searchShopCar.action?userId=${cookie.userId.value }"><i
					class="fa fa-shopping-cart"></i></a>
			</div>
			<!--END CART -->

			<!-- BEGIN NAVIGATION -->
			<div class="header-navigation">
				<ul id="mainMenu" class="navigation-bar">
					<li><a href="showTypeGoods.action?type=1">小电器</a></li>
					<li><a href="showTypeGoods.action?type=2">小书桌</a></li>
					<li><a href="showTypeGoods.action?type=3">实用小工具</a></li>
					<li><a href="showTypeGoods.action?type=4">书籍</a></li>
					<li><a href="showTypeGoods.action?type=5">服装</a></li>
					<li><a href="showTypeGoods.action?type=6">复习资料/笔记</a></li>
					<li><a href="showTypeGoods.action?type=7">洗漱品</a></li>
					<li><a href="showTypeGoods.action?type=8">其他</a></li>
					<!-- BEGIN TOP SEARCH -->
					<li class="menu-search"><span class="sep"></span> <i
						class="fa fa-search search-btn"></i>
						<div class="search-box">
							<form action="fuzzySearch.action" method="post">
								<div class="input-group">
									<input type="text" name="key" placeholder="输入关键词查找"
										class="form-control"> <span class="input-group-btn">
										<button class="btn btn-primary" type="submit">查找</button>
									</span>
								</div>
							</form>
						</div></li>
					<!-- END TOP SEARCH -->
				</ul>
			</div>
			<!-- END NAVIGATION -->
		</div>
	</div>
	<!-- Header END -->

</body>
</html>
