<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <style>
        .tableImg {
            display: none;
            position: absolute;
        }
    </style>
</head>
<body>
<jsp:forward page="/jsp/goods/mainGoods.jsp"></jsp:forward>
<%--<span id="title1">图片1：</span>--%>
<%--<input type="button"--%>
       <%--name="uploadButton" value="点击修改" id="uploadButton1"--%>
       <%--class="tableButton" style="font-size: 17px; height: 28px" />--%>
<%--<img--%>
        <%--src="" alt="" name="flag1" class="tableImg" width="200"--%>
        <%--height="130">--%>
<%--<input type="text" name="goodsImg" id="goodsImg1" value="" hidden>--%>

<%--<div hidden>--%>
    <%--<input type="file" name="file" id="file1" accept="image/*"--%>
           <%--onchange="upload()">--%>
<%--</div>--%>

<%--<span id="title2">图片2：</span>--%>
<%--<input type="button"--%>
       <%--name="uploadButton" value="点击修改" id="uploadButton2"--%>
       <%--class="tableButton" style="font-size: 17px; height: 28px" />--%>
<%--<img--%>
        <%--src="" alt="" name="flag1" class="tableImg" width="200"--%>
        <%--height="130">--%>
<%--<input type="text" name="goodsImg" id="goodsImg2" value="" hidden>--%>

<%--<div hidden>--%>
    <%--<input type="file" name="file" id="file2" accept="image/*"--%>
           <%--onchange="upload()">--%>
<%--</div>--%>
</body>

<script src="lib/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript">
    var imgTarget;
    var inputTarget;

    $('.tableButton').click(function() {
        imgTarget = $(this).next();
        inputTarget = $(this).next().next();
        console.log(inputTarget);


    $('#file').click();
    });

    $('.tableButton').mouseover(function() {
        $(this).next().show(100);
    }).mouseout(function() {
        $(this).next().hide(100);
    });

    function upload() {
        var fd = new FormData();
        var oldFile = $(imgTarget).attr('src');
        if(oldFile!=null && oldFile != ""){
            fd.append("oldFile",oldFile);
        }
        fd.append('file', $('#file')[0].files[0]);
        $.ajax({
            url : '${pageContext.request.contextPath}/uploadImg.action',
            data : fd,
            processData : false,
            contentType : false,
            type : 'POST',
            success : function(data) {
                if(data!="error") {
                    inputTarget.val("../" + data);
                    imgTarget.attr('src', "../" + data);
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
</script>
</html>