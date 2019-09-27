<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/8/9
  Time: 16:47
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
    <title>上传商品</title>
    <meta charset="utf-8">

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
    <link href="css/shop.css" rel="stylesheet" type="text/css">
    <!-- Theme styles END -->
    <style>
        .tableImg{
            position: absolute;
            display: none;
            z-index: 999;
        }

        .form-group{
            margin-top: 20px;
        }

        .error{
            color: red;
        }

        .addImg{
            text-align: center;
            color: blue;
            cursor: pointer;
        }

        .remove{
            color: red;
            font-weight: 900;
            cursor: pointer;
        }

    </style>
</head>
<body>

<jsp:include page="goods_head.jsp"/>

<div class="main">
    <div class="container">
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">

            <!-- BEGIN CONTENT -->
            <div class="col-md-9 col-sm-7">
                <h1>发布商品</h1>
                <div class="content-form-page">
                    <form role="form" id="goodsForm" action="submitAddGoods.action" class="form-horizontal form-without-legend" method="post">
                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品名称 <span class="require">*</span></label>
                            <div class="col-lg-8">
                                <input type="text" id="goodsName" name="goods.gpName" class="form-control" required>
                                <label for="goodsName"></label>
                            </div>
                        </div>
                        <input type="text" name="goods.gpUid" value="${cookie.userId.value}" hidden>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品价格 <span class="require">*</span></label>
                            <div class="col-lg-8">
                                <input type="text" id="goodsPrice" name="goods.gpPromotePrice" required class="form-control">
                                <label for="goodsPrice"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品数量 <span class="require">*</span></label>
                            <div class="col-lg-8">
                                <input type="text" id="goodsNum" name="goods.gpStock" required class="form-control">
                                <label for="goodsNum"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品描述</label>
                            <div class="col-lg-8">
                                <textarea class="form-control" id="goodsIntroduce" name="goods.gpIntroduce" rows="6" required minlength="10"></textarea>
                                <label for="goodsIntroduce"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">商品分类</label>
                            <div class="col-md-8">
                                <select class="form-control" name="goods.gpCid">
                                    <c:forEach items="${categoryList}" var="type">
                                    <option value="${type.gcId}">${type.gcName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品封面图：</label>
                            <div class="col-lg-8">
                                <input type="button"
                                       name="uploadButton" value="点击修改" id="uploadButton"
                                       class="tableButton" style="font-size: 15px; height: 25px" />
                                <img
                                        src="" alt="" name="flag1" class="tableImg" width="200"
                                        height="130">
                                <input type="text" name="goods.titleImg" id="titleImg" required value="">
                                <label for="titleImg"></label>
                                <input type="file" name="file" id="file" style="display: none;" accept="image/*"
                                           onchange="update(this)">
                                <span>上传商品封面图</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品图片：</label>
                            <div class="col-lg-8">
                                <input type="button"
                                       name="uploadButton" value="点击修改" id="uploadButton2"
                                       class="tableButton" style="font-size: 15px; height: 25px" />
                                <img
                                        src="" alt="" name="flag1" class="tableImg" width="200"
                                        height="130">
                                <input type="text" name="goodsImg" id="goodsImg2" required value="" >
                                <label for="goodsImg2"></label>
                                <input type="file" name="file" id="file2" style="display: none;" accept="image/*"
                                           onchange="update(this)">
                                <span>上传商品图片</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品图片：</label>
                            <div class="col-lg-8">
                                <input type="button"
                                       name="uploadButton" value="点击修改" id="uploadButton3"
                                       class="tableButton" style="font-size: 15px; height: 25px" />
                                <img
                                        src="" alt="" name="flag1" class="tableImg" width="200"
                                        height="130">
                                <input type="text" name="goodsImg" id="goodsImg3" required value="" >
                                <label for="goodsImg3"></label>
                                    <input type="file" name="file" id="file3" style="display: none;" accept="image/*"
                                           onchange="update(this)">
                                <span>上传商品图片</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-2 control-label">商品图片：</label>
                            <div class="col-lg-8">
                                <input type="button"
                                       name="uploadButton" value="点击修改" id="uploadButton1"
                                       class="tableButton" style="font-size: 15px; height: 25px" />
                                <img
                                        src="" alt="" name="flag1" class="tableImg" width="200"
                                        height="130">
                                <input type="text" name="goodsImg" id="goodsImg1" required value="" >
                                <label for="goodsImg1"></label>
                                    <input type="file" name="file" id="file1" style="display: none;" accept="image/*"
                                           onchange="update(this)">
                                <span>上传商品图片</span>
                            </div>
                        </div>
                        <p class="addImg">+添加图片</p>
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-2 padding-left-0 padding-top-20">
                                <button class="btn btn-primary" id="uploadImg" type="button" onclick="upload()">图片上传</button>
                                <button class="btn btn-primary" type="submit">发布</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </div>
</div>

<jsp:include page="goods_footer.jsp"/>
</body>

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

<script src="lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script src="lib/jquery.validation/1.14.0/messages_zh.js"></script>

<script type="text/javascript">
    jQuery(document).ready(function() {
        Layout.init();
        Layout.initOWL();
        Layout.initImageZoom();
        Layout.initTouchspin();
        Layout.initFixHeaderWithPreHeader();
        Layout.initNavScrolling();
    });

    var imgTarget;
    var inputTarget;



    $('.tableButton').live('mouseover',function() {
        $(this).next().show(100);
    }).live('mouseout',function() {
        $(this).next().hide(100);
    });

    $('.remove').live('click',function () {
        $(this).parent().parent().remove();
    })

    $('.addImg').click(function () {
        if($('input[name=goodsImg]').length>=5){
            alert("最多只能上传5张图片");
        }else {
            $(this).before("           <div class=\"form-group\">\n" +
                "                            <label class=\"col-lg-2 control-label\">商品图片：</label>\n" +
                "                            <div class=\"col-lg-8\">\n" +
                "                                <input type=\"button\"\n" +
                "                                       name=\"uploadButton\" value=\"点击修改\" id=\"uploadButton1\"\n" +
                "                                       class=\"tableButton\" style=\"font-size: 15px; height: 25px\" />\n" +
                "                                <img\n" +
                "                                        src=\"\" alt=\"\" name=\"flag1\" class=\"tableImg\" width=\"200\"\n" +
                "                                        height=\"130\">\n" +
                "                                <input type=\"text\" name=\"goodsImg\" id=\"goodsImg1\" required value=\"\" >\n" +
                "                                <label for=\"goodsImg1\"></label>\n" +
                "                                    <input type=\"file\" name=\"file\" id=\"file1\" style=\"display: none;\" accept=\"image/*\"\n" +
                "                                           onchange=\"update(this)\">\n" +
                "                                <span>上传商品图片</span><span class='remove' title='移除图片'>&nbsp;&nbsp;&nbsp;&nbsp;X</span> \n" +
                "                            </div>\n" +
                "                        </div>");
        }
    });

    $('.tableButton').live('click',function() {
        imgTarget = $(this).next();
        inputTarget = $(this).next().next();
        console.log(inputTarget);


        $(inputTarget).next().next().click();
    });

    /**
     *解析出图片的真是路径并回显
     * */
    function update(file) {
        var file1 = $(file)[0].files[0]

        if (window.FileReader) {
            var reader = new FileReader();
            reader.readAsDataURL(file1);
            //监听文件读取结束后事件    
            reader.onloadend = function (e) {
                imgTarget.attr("src",e.target.result);    //e.target.result就是最后的路径地址
            };
        }

    }

    function upload(){
        var fd = new FormData();
        var files1 = $('input[type=file][name=file]');
        for(var i = 0;i<files1.length; i++){
            if(files1[i].files[0]==null){
                $(files1[i]).prev().html("<span class='error'>请选择一张图片</span>");
                return;
            }else {
                $(files1[i]).prev().html("");
                fd.append("file",files1[i].files[0]);
            }
        }

        $.ajax({
            url : '${pageContext.request.contextPath}/uploadImg.action',
            data : fd,
            processData : false,
            contentType : false,
            dataType:'json',
            type : 'POST',
            success : function(data) {
                console.log(data);
                var jsonData = data;
                console.log(jsonData[0]);
                if(data!="error") {
                    var inputImgs = $("input[name=goodsImg]");
                    $('#titleImg').val(jsonData[0]);
                    for(var i = 0;i<inputImgs.length; i++){
                        $(inputImgs[i]).val("../"+jsonData[i+1]);
                    }
                    $('#uploadImg').attr("disabled",true);
                    /* inputTarget.val("../" + data);
                     imgTarget.attr('src', "../" + data);*/
                    layer.msg('图片上传成功', {
                        icon: 1,
                        time: 1000
                    });
                }else {
                    layer.msg('图片上传失败', {
                        icon: 2,
                        time: 1000
                    });
                }
            }
        });

    }

    $().ready(function() {
        // 提交时验证表单
        var validator = $("#goodsForm").validate({
            errorPlacement: function(error, element) {
                // Append error within linked label
                $( element )
                    .closest( "form" )
                    .find( "label[for='" + element.attr( "id" ) + "']" )
                    .append( error );
            },
            errorElement: "span",
            messages: {
                goodsName: {
                    required: " (必需字段)",
                },
                goodsPrice: {
                    required: " (必需字段)",
                },
                goodsIntroduce:{
                    required: " (必需字段)",
                    minlength: " (请至少输入10个字描述商品)",
                },
                goodsNum:{
                    required: " (必需字段)",
                },
                titleImg:{
                    required: " (请选择封面图)",
                    minlength:" (请选择封面图)",
                },
                goodsImg1:{
                    required: " (请选择一张商品详情图)",
                },
                goodsImg2:{
                    required: " (请选择一张商品详情图)",
                },
                goodsImg3:{
                    required: " (请选择一张商品详情图)",
                },
            }
        });

        $(".cancel").click(function() {
            validator.resetForm();
        });
    });
</script>
<!-- END PAGE LEVEL JAVASCRIPTS -->
</html>
