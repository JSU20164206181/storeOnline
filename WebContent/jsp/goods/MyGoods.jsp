<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<base href="<%=basePath%>">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<style type="text/css">

.colStyle {
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}

</style>

<title>商品列表列表</title>

</head>
<body>


	<div id="MyGoods" class="page-container">
		<div class="text-c"> 
		  <form action="showUser.action?next=next" method="post">
		    <input type="text" id="fuzzy" name="fuzzySearch" id="" placeholder=" 商品名称" style="width:250px" class="input-text">
		   <s:textfield type="hidden" id="sousuo" value="%{#request.fuzzySearch}"/>
		 
			<button name="" id="" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜商品</button>
		  </form>
			
		</div>
		
		<div class="cl pd-5 bg-1 bk-gray mt-20">
		 <span class="l">
		
		<a class="btn btn-primary radius"  href="addGoods.action">
		<i class="Hui-iconfont">&#xe600;</i>
		 添加商品
		 </a>
		 </span> 
		 <span class="r">
		 
	<!--<a class="btn btn-primary radius" 
		 onclick="product_add('添加产品','product-add.html')" 
		 href="javascript:;"><i class="Hui-iconfont">&#xe600;-->
		 
		 共有<strong><s:property value="totalPage"/></strong> 页 数据</span>
		</div>
		 
		<div  class="mt-20">
			<table  class="table table-border table-bordered table-bg table-hover table-sort">
					<tr class="text-c">
						<th width="40">ID</th>
						<th width="60">封面图</th>
						<th width="60">商品名称</th>
						<th width="60">描述</th>
						<th width="50">商品类型</th>
						<th width="55">原价</th>
						<th width="55">促销价格</th>	
						<th width="50">库存</th>
						<th width="90">商品创建时间</th>
						
						<th width="40">发布状态</th>
						<th width="60">商品评分</th>
						<th width="75">操作</th>
					</tr>
				<tbody  id="test">
				
				    <s:if test="#request.goodList==null">
				      <a href="addGoods.action">你暂时没有销售的商品,请上架商品</a>
				    </s:if>
				    
				 <s:else>
				    <s:iterator var="goods" value="#request.goodList">
				    <tr  class="text-c va-m">
						
						<td><s:property value="#goods.gpId" /></td>
						<!-- 商品封面图的位置 -->
						<td id="productImg"><a  href="javascript:;">
						<s:if test="#goods.titleImg!=null">
						<img width="45" height="45" class="product-thumb" 
						src= "<s:property value="#goods.titleImg"/>" />
						</s:if>
						
						<s:else>
						<img width="45" height="45" class="product-thumb" 
						src="lib/ls/temp/product/Thumb/6204.jpg">
						</s:else>
						
						</a>
						</td>
						
						<td class="text-l" title="<s:property value="#goods.gpName"/>"><s:property value="#goods.gpName"/></td>
						<td class="text-l" title="<s:property value="#goods.gpIntroduce"/>"><s:property value="#goods.gpIntroduce"/></td>
						
						<td title="<s:property value="#goods.gpCid"/>"><s:property value="#goods.gpCid"/></td>
						<td title="<s:property value="#goods.gpOriginalPrice"/>"><span class="price"><s:property value="#goods.gpOriginalPrice"/></span>元</td>
						<td title="<s:property value="#goods.gpPromotePrice"/>"><span class="price"><s:property value="#goods.gpPromotePrice"/></span>元</td>
						
						<td title="<s:property value="#goods.gpStock"/>"><s:property value="#goods.gpStock"/></td>
						<td title="<s:property value="#goods.gpCreateDate"/>"><s:property value="#goods.gpCreateDate"/></td>
						
						<!-- 商品的状态 -->
						<s:if test="#goods.gpStatus==1">
						<td class="td-status"><span class="label label-success radius">上架中</span></td>
						
						</s:if>
						<s:elseif test="#goods.gpStatus==0">
						<td class="td-status"><span class="label label-defaunt radius">已下架</span></td>
						</s:elseif>
						<s:elseif test="#goods.gpStatus==3">
						<td class="td-status"><span class="label label-danger radius">未通过</span></td>
						</s:elseif>
						<s:elseif test="#goods.gpStatus==2">
						<td class="td-status"><span class="label label-defaunt radius">审核中</span></td>
						</s:elseif>
						<td title="<s:property value="#goods.gpStar"/>"><s:property value="#goods.gpStar"/></td>
						
						<td id="operate" class="td-manage">
						<a style="text-decoration:none" onClick="product_stop(this,'10001')" href="javascript:;" title="下架">
						<i class="Hui-iconfont">&#xe6de;</i></a>
						
						
					    
						<a style="text-decoration:none" 
						class="ml-5" onClick="product_del(this,'10001')"
						href="javascript:;" title="删除">
						<i class="Hui-iconfont">&#xe6e2;
						</i></a></td>
						
						<td id="deleteProduct" style="display:none"><s:property value="%{#goods.gpId}"/></td>
						
					</tr>
					</s:iterator>
				 </s:else>
			
				</tbody>
			</table>
			<span>当前是第${page}页</span>
			
		
			<a id="lastPage" style="margin-left:600px;padding-left:50px" onclick="last()" 
			href="${pageContext.request.contextPath}/showUser.action?page=${page-1}&next=next">上一页</a>
			
			<a id="nextPage" onClick="next()" href="${pageContext.request.contextPath}/showUser.action?page=${page+1}&next=next">下一页</a>
			
		</div>
	</div>
	<script>
		
	</script>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="ls/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="ls/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="ls/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="ls/laypage.js"></script>
<script type="text/javascript">


//循环遍历存数据的td 多余的内容省略号显示
var self=$('#test tr td').nextAll();

self.each(function(){
	var x = 0;
	var object = $(this);
    
    var  objString = object.text();
    var objLength = object.text().length; 
      
      if(object.attr("id")!="productImg"){
    	  if(object.attr("id")!="operate"){
    		  if(objLength >=9){
                  objString = object.text(objString.substring(0,5) + "...");       
             }   
    	  }
      }
}); 
 






var fuzzy = $("#sousuo").val();

if(fuzzy!=""){
	$("#lastPage").attr("href","${pageContext.request.contextPath}/showUser.action?page=${page-1}&next=next&fuzzySearch="+fuzzy);
	$("#nextPage").attr("href","${pageContext.request.contextPath}/showUser.action?page=${page+1}&next=next&fuzzySearch="+fuzzy);
}


/*产品-删除*/
function product_del(obj,id){
  var productId = 	$(obj).parents().next("#deleteProduct").text();
	
	layer.confirm('确认要删除吗？',function(index){
		 $.ajax({
			type: "get",
			url: "deleteMyGoods.action?productId="+productId,
			success: function(data){
				alert(data);
				if(data=="删除成功"){
					layer.msg('已删除!',{icon:1,time:1000});
					window.location.reload();
				}	
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		 
	});
}


/*产品-下架*/
function product_stop(obj,id){
	var productId = $(obj).parents().next("#deleteProduct").text();
	
	layer.confirm('确认要下架吗？',function(index){
		 $.ajax({
			type: "get",
			url: "changeStatus.action?productId="+productId,
			success: function(data){
				alert(data);
				if(data=="下架成功"){
					layer.msg('已下架!',{icon:1,time:1000});
					window.location.reload();
				}	
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		 
	});	
}



/*产品-添加*/
function product_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*产品-查看*/
function product_show(title,url,id){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*产品-审核*/
function product_shenhe(obj,id){
	layer.confirm('审核文章？', {
		btn: ['通过','不通过'], 
		shade: false
	},
	function(){
		$(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="product_start(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
		$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
		$(obj).remove();
		layer.msg('已发布', {icon:6,time:1000});
	},
	function(){
		$(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="product_shenqing(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
		$(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">未通过</span>');
		$(obj).remove();
    	layer.msg('未通过', {icon:5,time:1000});
	});	
}

/*产品-发布*/
function product_start(obj,id){
	layer.confirm('确认要发布吗？',function(index){
		$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="product_stop(this,id)" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
		$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
		$(obj).remove();
		layer.msg('已发布!',{icon: 6,time:1000});
	});
}

/*产品-申请上线*/
function product_shenqing(obj,id){
	$(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">待审核</span>');
	$(obj).parents("tr").find(".td-manage").html("");
	layer.msg('已提交申请，耐心等待审核!', {icon: 1,time:2000});
}

/*产品-编辑*/
function product_edit(title,url,id){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}


var setting = {
	view: {
		dblClickExpand: false,
		showLine: false,
		selectedMulti: false
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: ""
		}
	},
	callback: {
		beforeClick: function(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("tree");
			if (treeNode.isParent) {
				zTree.expandNode(treeNode);
				return false;
			} else {
				//demoIframe.attr("src",treeNode.file + ".html");
				return true;
			}
		}
	}
};

	
		
		
$(document).ready(function(){
	var t = $("#treeDemo");
	t = $.fn.zTree.init(t, setting, zNodes);
	//demoIframe = $("#testIframe");
	//demoIframe.on("load", loadReady);
	var zTree = $.fn.zTree.getZTreeObj("tree");
	//zTree.selectNode(zTree.getNodeByParam("id",'11'));
});

$('.table-sort').dataTable({
	"aaSorting": [[ 1, "desc" ]],//默认第几个排序
	"bStateSave": true,//状态保存
	"aoColumnDefs": [
	  {"orderable":false,"aTargets":[0,7]}// 制定列不参与排序
	]
});



</script>
</body>
</html>