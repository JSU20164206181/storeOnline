<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String path = request.getContextPath(); 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"; 
%> 
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->


<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<!--/meta 作为公共模版分离出去-->
    <title>ECharts</title>
    <!-- 引入 echarts.js -->
    <script src="ls/echarts.js"></script>
    <script type="text/javascript" src="ls/china.js" ></script>
    <script type="text/javascript" src="ls/jquery.min.js"></script>
</head>
<body>
<jsp:include page="_header.jsp" flush="true" ></jsp:include>
<jsp:include page="_menu.jsp" flush="true" ></jsp:include>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
  <section class="Hui-article-box">
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 1200px;height:800px;"></div>
    </section>
    <!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/hcharts/Highcharts/5.0.6/js/highcharts.js"></script>
<script type="text/javascript" src="lib/hcharts/Highcharts/5.0.6/js/modules/exporting.js"></script>
<script type="text/javascript" src="lib/hcharts/Highcharts/5.0.6/js/highcharts-3d.js"></script>

<script type="text/javascript">

var mydata = [  
                {name: '北京',value: '0' },
                {name: '天津',value: '0' },
                {name: '上海',value: '0' },
                {name: '重庆',value: '0' },
                {name: '河北',value: 0 },{name: '河南',value: 0 },  
                {name: '云南',value: 0 },{name: '辽宁',value:0  },  
                {name: '黑龙江',value: 0 },{name: '湖南',value: 0 },  
                {name: '安徽',value: 0 },{name: '山东',value: 0 },  
                {name: '新疆',value: 0 },{name: '江苏',value: 0 },  
                {name: '浙江',value: 0 },{name: '江西',value: 0 },  
                {name: '湖北',value: 0 },{name: '广西',value: 0 },  
                {name: '甘肃',value: 0 },{name: '山西',value: 0 },  
                {name: '内蒙古',value:0 },{name: '陕西',value: 0 },  
                {name: '吉林',value: 0 },{name: '福建',value: 0 },  
                {name: '贵州',value: 0 },{name: '广东',value: 0 },  
                {name: '青海',value: 0 },{name: '西藏',value: 0 },  
                {name: '四川',value: 0 },{name: '宁夏',value: 0 },  
                {name: '海南',value: 0 },{name: '台湾',value: 0 },  
                {name: '香港',value: 0 },{name: '澳门',value: 0 }  
            ]; 
            
let arr = [];
          
  
	
	  $.ajax({
			 type: "post",	
			 url: "cityShow.action",
			 dataType:"json",
			 success: function(data) { 
			
			  arr = data;
			  $.each(mydata, function (index, content) {
		    	    
		           	 $.each(arr, function (weizhi, value) {
		           	   	 if(value.city.indexOf(content.name)!=-1){
		           	   		
		           	     content.value =parseInt(content.value)+ parseInt(1);
		           	   	 	
		           	   	 }
		           	   });
		           }); 
			  
			  var optionMap = {  
		                backgroundColor: '#FFFFFF',  
		                title: {  
		                    text: '用户分布图',  
		                    subtext: '',  
		                    x:'center'  
		                },  
		                tooltip : {  
		                    trigger: 'item'  
		                },  
		                
		                //左侧小导航图标
		                visualMap: {  
		                    show : true,  
		                    x: 'left',  
		                    y: 'center',  
		                    splitList: [   
		                        {start: 40, end:100},{start: 21, end: 40},  
		                        {start: 11, end: 20},{start: 4, end: 10},  
		                        {start: 1, end: 3},{start: 0, end: 0},  
		                    ],  
		                    color: ['#3b2d82', '#7f00ff', ' #0000fe','#138aaa', '#0099ff', '#b8e6fe']  
		                }, 
		                
		                //配置属性
		                series: [{  
		                    name: '人数',  
		                    type: 'map',  
		                    mapType: 'china',   
		                    roam: true,  
		                    label: {  
		                        normal: {  
		                            show: true  //省份名称  
		                        },  
		                        emphasis: {  
		                            show: false  
		                        }  
		                    },  
		                    data:mydata  //数据
		                }]  
		            };  
			  
			  
			  //初始化echarts实例
              var myChart = echarts.init(document.getElementById('main'));
     
              //使用制定的配置项和数据显示图表
              myChart.setOption(optionMap);
					
			 },
			   			 
		});   	    
  
 

      

        
    </script>
</body>
</html>
