<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
 <div id="show" class="content-page">
              <h3>个人中心</h3>
			  <hr>
              <ul id="userMsg">
              <li>用户名:<a id="userNull">
              
				<s:property value="user.guName"/>
			
              </a>
              </li>
				<hr>				
			<li>性别：
			<a>
			    <s:if test="user.guSex==null">
				无
				</s:if>
				<s:else>
				<s:property value="user.guSex"/>
				</s:else>				
			</a>
			</li>
				<hr>
				<li>年龄：
				<a>
				<s:if test="user.guAge==null">
				无
				</s:if>
				<s:else>
				<s:property value="user.guAge"/>
				</s:else>
				</a>
				</li>
				<hr>
				<li>绑定的手机号：<a><s:if test="user.guPhone==null">
				无
				</s:if>
				<s:else>
				<s:property value="user.guPhone"/>
				</s:else></a></li>
				<hr>
				<li>用户地址：<a><s:if test="user.guAddress==null">
				无
				</s:if>
				<s:else>
				<s:property value="user.guAddress"/>
				</s:else></a></li>
				
				<hr>
				<li>用户邮箱：<a><s:if test="user.guEmail==null">
				无
				</s:if>
				<s:else>
				<s:property value="user.guEmail"/>
				</s:else></a></li>
				
			 
              </ul>
     </div>
</body>
</html>