<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"; 
%> 
<base href="<%=basePath%>">
<aside class="Hui-aside">
	<div class="menu_dropdown bk_2">
		<dl id="menu-article">
			<dt><i class="Hui-iconfont">&#xe616;</i> 商品管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="javascript:void(0)" data-title="审核商品" href="findAuditProductList.action">审核商品</a></li>
					<li><a data-href="javascript:void(0)" data-title="商品列表" href="findProductList.action">商品列表</a></li>
					
					
			</ul>
		</dd>
	</dl>
		<dl id="menu-picture">
			<dt><i class="Hui-iconfont">&#xe613;</i> 图片管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="javascript:void(0)" data-title="图片管理" href="findProductimageList.action">图片管理</a></li>
			</ul>
		</dd>
	</dl>
		<dl id="menu-product">
			<dt><i class="Hui-iconfont">&#xe620;</i> 产品管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					
					<li><a data-href="javascript:void(0)" data-title="分类管理" href="findCategoryList.action">分类管理</a></li>
					
			</ul>
		</dd>
	</dl>
		<dl id="menu-comments">
			<dt><i class="Hui-iconfont">&#xe622;</i> 评论管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="http://h-ui.duoshuo.com/admin/" data-title="评论列表" href="javascript:;">评论列表</a></li>
					<li><a data-href="feedback-list.jsp" data-title="意见反馈" href="javascript:void(0)">意见反馈</a></li>
			</ul>
		</dd>
	</dl>
		<dl id="menu-member">
			<dt><i class="Hui-iconfont">&#xe60d;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="javascript:;" data-title="用户管理"  href="userList.action?listChose=1">用户管理</a></li>
					<li><a data-href="javascript:;" data-title="男女比例" href="userShowSexCount.action">男女比例</a></li> 
					<li><a data-href="javascript:;" data-title="年龄分布" href="userShowAgeCount.action">年龄分布</a></li>
					<li><a data-href="javascript:;" data-title="用户分布图" href="jsp/admin/Map.jsp">用户分布图</a></li>
									
			</ul>  
		</dd>
	</dl>
	<dl id="menu-admin">
			<dt><i class="Hui-iconfont">&#xe62d;</i> 管理员管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
				    <li><a data-href="javascript:void(0)" data-title="管理员列表" href="adminList.action">管理员管理</a></li>
				    <li><a data-href="javascript:void(0)" href="showAdminInformation.action" data-title="个人信息">个人信息</a></li> 
					<li><a data-href="javascript:void(0)" data-title="修改密码" href="changeAdminPassword.action?adminId=loginAdmin">修改密码</a></li>		
			</ul>
		</dd>
	</dl>
		<dl id="menu-tongji">
			<dt><i class="Hui-iconfont">&#xe61a;</i>订单记录<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					
					<li><a data-href="javascript:;" data-title="订单列表" href="orderListManagement.action?listChose=1">订单列表</a></li>
					
					<li><a data-href="javascript:;" data-title="订单列表" href="allCostCount.action">总体消费记录</a></li>
					<!-- <li><a data-href="typeCount.action" data-title="商品类型" href="javascript:;">商品类型</a></li> -->
					
			
			</ul> 
		</dd>
	</dl>
		<dl id="menu-system">
			<dt><i class="Hui-iconfont">&#xe62e;</i> 系统管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="system-base.jsp" data-title="系统设置" href="javascript:void(0)">系统设置</a></li>
					<li><a data-href="system-category.jsp" data-title="栏目管理" href="javascript:void(0)">栏目管理</a></li>
					<li><a data-href="system-data.jsp" data-title="数据字典" href="javascript:void(0)">数据字典</a></li>
					<li><a data-href="system-shielding.jsp" data-title="屏蔽词" href="javascript:void(0)">屏蔽词</a></li>
					<li><a data-href="system-log.jsp" data-title="系统日志" href="javascript:void(0)">系统日志</a></li>
			</ul>
		</dd>
	</dl>
</div>
</aside>