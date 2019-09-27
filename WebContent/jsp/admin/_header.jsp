<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"; 
%> 
<style type="text/css">
	.Hui-article-box{
		overflow: auto;
	}
</style>
<base href="<%=basePath%>">
<style type="text/css">
	.Hui-article-box{
		overflow: auto;
	}
</style>
<header class="navbar-wrapper">
	<div class="navbar navbar-fixed-top">
		<div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs" href="/aboutHui.shtml">瓜子后台管理</a> <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="/aboutHui.shtml"></a>
			<span class="logo navbar-slogan f-l mr-10 hidden-xs">v1.0</span>
			<a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
			<nav class="nav navbar-nav">
				<ul class="cl">
					<li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 新增 <i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="javascript:;" onclick="article_add('添加资讯','article-add.jsp')"><i class="Hui-iconfont">&#xe616;</i> 资讯</a></li>
							<li><a href="javascript:;" onclick="picture_add('添加资讯','picture-add.jsp')"><i class="Hui-iconfont">&#xe613;</i> 图片</a></li>
							<li><a href="javascript:;" onclick="product_add('添加资讯','product-add.jsp')"><i class="Hui-iconfont">&#xe620;</i> 产品</a></li>
							<li><a href="javascript:;" onclick="member_add('添加用户','member-add.jsp','','510')"><i class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
					</ul>
				</li>
				<li class="dropDown dropDown_hover">
							<a href="javascript:;" class="dropDown_A">工具 <i class="Hui-iconfont">&#xe6d5;</i></a>
							<ul class="dropDown-menu menu radius box-shadow">
								<li>
									<a href="http://www.h-ui.net/bug.shtml" target="_blank">Bug兼容性汇总</a>
								</li>
								<li>
									<a href="http://www.h-ui.net/websafecolors.shtml" target="_blank">web安全色</a>
								</li>
								<li>
									<a href="http://www.h-ui.net/Hui-3.7-Hui-iconfont.shtml" target="_blank">Hui-iconfont</a>
								</li>
								<li>
									<a href="javascript:;">web工具箱<i class="arrow Hui-iconfont">&#xe6d7;</i></a>
									<ul class="menu">
										<li>
											<a href="http://www.h-ui.net/tools/jsformat.shtml" target="_blank">JS/HTML格式化工具</a>
										</li>
										<li>
											<a href="http://www.h-ui.net/tools/HTMLtoJS.shtml" target="_blank">HTML/JS转换工具</a>
										</li>
										<li>
											<a href="http://www.h-ui.net/tools/cssformat.shtml" target="_blank">CSS代码格式化工具</a>
										</li>
										<li>
											<a href="http://www.h-ui.net/tools/daxiaoxie.shtml" target="_blank">字母大小写转换工具</a>
										</li>
										<li>
											<a href="http://www.h-ui.net/tools/fantizhuanhuan.shtml" target="_blank">繁体字、火星文转换</a>
										</li>
										<li>
											<a href="javascript:;">三级菜单<i class="arrow Hui-iconfont">&#xe6d7;</i></a>
											<ul class="menu">
												<li>
													<a href="javascript:;">四级菜单</a>
												</li>
												<li>
													<a href="javascript:;">四级菜单</a>
												</li>
												<li>
													<a href="javascript:;">四级菜单</a>
												</li>
											</ul>
										</li>
										<li>
											<a href="#">三级导航</a>
										</li>
									</ul>
								</li>
								<li>
									<a href="#">二级导航</a>
								</li>
								<li class="disabled">
									<a href="javascript:;">二级菜单</a>
								</li>
							</ul>
						</li>
			</ul>
		</nav>
		<nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
			<ul class="cl">
				<li>管理员:${sessionScope.adminName } </li>  
				<li class="dropDown dropDown_hover">
					<a  onclick="return false" href="" class="dropDown_A">  <i class="Hui-iconfont">&#xe6d5;</i></a>
					<ul class="dropDown-menu menu radius box-shadow">
					<!-- 	<li><a href="javascript:;" onClick="myselfinfo()">个人信息</a></li> -->
						 <li><a href="adminLogOut.action">切换账户</a></li> 
						<li><a href="adminLogOut.action">退出</a></li>
				</ul>
			</li>				
				<li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
					<ul class="dropDown-menu menu radius box-shadow">
						<li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
						<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
						<li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
						<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
						<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
						<li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
</div>
</header>