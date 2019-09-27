<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/6/29
  Time: 18:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String path = request.getContextPath();
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>用户注册界面</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
<s:form method="post" action="userRegister.action"
      onsubmit="return checkForm()" theme="simple">
    <div class="regist">
        <div class="regist_center">
            <div class="regist_top">
                <div class="left fl">会员注册</div>
                <div class="right fr">
                    <a href="showSubject" target="_self">jila网上投票系统</a>
                </div>
                <div class="clear"></div>
                <div class="xian center"></div>
            </div>
            <div class="regist_main center">
                <div class="username">
                    用&nbsp;&nbsp;户&nbsp;&nbsp;名:&nbsp;&nbsp;<s:textfield class="shurukuang"
                                                                   id="name" onblur="if(this.value!=''){checkName()}" type="text"
                                                                   name="user.userName" placeholder="请输入你的用户名" /><span id="nameSpan">请输入用户名</span>
                </div>
                <div class="username">
                    密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;&nbsp;<s:password
                        class="shurukuang" id="npass1" name="user.userPass"
                        onblur="if(this.value!=''){checkPassWord()}"
                        placeholder="请输入你的密码" /><span id="passWordSpan">请输入6位以上字符</span>
                </div>

                <div class="username">
                    确认密码:&nbsp;&nbsp;<s:password class="shurukuang"
                                            onblur="if(this.value!=''){checkInput()}" id="npass2"
                                            name="userPass1" placeholder="请确认你的密码" /><span
                        id="passWordSpan1">两次密码要输入一致哦</span>
                </div>

                <div class="username">
                    手&nbsp;&nbsp;机&nbsp;&nbsp;号:&nbsp;&nbsp;<s:textfield class="shurukuang"
                                                                         id="userTel" onblur="if(this.value!=''){checkTel()}" type="text"
                                                                         name="user.phone" placeholder="请填写正确的手机号" /><span id="telSpan">填写下手机号吧，方便我们联系您！</span>
                </div>

                <div class="username">
                    &nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;&nbsp; 龄:&nbsp;&nbsp;<s:textfield class="shurukuang" onkeyup="this.value=this.value.replace(/\D/g,'')"
                                                                         onafterpaste="this.value=this.value.replace(/\D/g,'')" id="age"  type="text"
                                                                         name="user.age" placeholder="请填写你的年龄"/><span id="ageSpan">输入您的年龄吧！</span>
                </div>

                <div class="username">
                    &nbsp;&nbsp;性 &nbsp;&nbsp;&nbsp;&nbsp; 别:&nbsp;&nbsp;<s:radio id="sex" style="margin: 0 5px 0 15px;"
                                           name="user.sex" list="#{'男':'男','女':'女'}" value="'男'"/>
                </div>



            </div>
            <div class="regist_submit">
                <input class="submit" type="submit" name="submit" value="立即注册">
            </div>
        </div>
    </div>
</s:form>
</body>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script>
    function checkInput(){
        var p1 = document.getElementById("npass1").value;
        var p2 = document.getElementById("npass2").value;

        if(p1 != '' && p2 != '' && p1!=p2){
            document.getElementById("npass2").value = "";
            document.getElementById("npass2").focus();
            $("#passWordSpan1").html("两次密码不一致");
            $("#passWordSpan1").css("color","red");
            return false;
        }else{
            $("#passWordSpan1").html("符合要求");
            $("#passWordSpan1").css("color","green");
            return true;
        }
    }

    function checkName() {
        var name = document.getElementById("name").value;
        var nameSpan = document.getElementById("nameSpan");
        var reg = /^\w+$/;
        if (name.length < 1) {
            nameSpan.innerHTML = "<font size='2' color='red'>用户名不能为空</font>"
        } else if (name.length < 6) {
            nameSpan.innerHTML = "<font size='2' color='red'>用户名要至少六位</font>"
        } else if (!reg.test(name)) {
            nameSpan.innerHTML = "<font size='2' color='red'>只能由字母数字下划线组成</font>"
        } /*else {
            nameSpan.innerHTML = "<font size='2' color='green'>符合要求</font>";
            return true;
        }*/
        else {
            var flag = false;
            $.ajax({
                url:'${pageContext.request.contextPath}/userExist.action',
                type:'post',
                data: {'userName':name},
                async:false,
                success:function(data) {
                if (data == 'true') {
                    nameSpan.innerHTML = "<font size='2' color='green'>符合要求</font>";
                    flag =  true;
                }else {
                    console.log(data);
                    nameSpan.innerHTML = "<font size='2' color='red'>该用户名已存在</font>";
                    flag = false;
                }
            }
            });
            return flag;
        }
    }

    function checkPassWord() {
        var pass = document.getElementById("npass1").value;
        var passWordSpan = document.getElementById("passWordSpan");
        if (pass.length < 1) {
            passWordSpan.innerHTML = "<font size='2' color='red'>密码不能为空</font>"
        } else if (pass.length < 6) {
            passWordSpan.innerHTML = "<font size='2' color='red'>密码至少6位</font>"
        } else if (pass.length > 16) {
            passWordSpan.innerHTML = "<font size='2' color='red'>密码最长为16位</font>"
        } else {
            passWordSpan.innerHTML = "<font size='2' color='green'>符合要求</font>"
            return true;
        }
    }

    function checkTel() {
        var tel = $("#userTel").val();
        var reg = /^[1][3,4,5,7,8][0-9]{9}$/;
        if (!reg.test(tel)) {
            telSpan.innerHTML = "<font size='2' color='red'>请输入正确的手机号格式</font>"
        } else {
            telSpan.innerHTML = "<font size='2' color='green'>符合要求</font>"
            return true;
        }
    }

    function checkForm() {
        if (checkPassWord() && checkInput()&&checkName()&&checkTel()) {
            return true;
        } else {
            alert("输入格式不规范");
            return false;
        }
    }



</script>
<c:if test="${not empty error }">
    <script type="text/javascript">
        alert('${error}')
    </script>
</c:if>
</html>
