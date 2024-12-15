<%--
  Created by IntelliJ IDEA.
  User: Huxiaojiao
  Date: 2024/12/15
  Time: 22:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>活动审批管理系统</title>
</head>
<body>

<div>
    <h2>用户登录</h2>
    <span>${msg}</span>
    <form id="loginform" class="sui-form" action="${pageContext.request.contextPath}/user/login"
          method="post">
        <div class="input-prepend"><span class="add-on loginname">用户名</span>
            <input type="text" placeholder="企业邮箱" class="span2 input-xfat" name="name">
        </div>
        <div class="input-prepend"><span class="add-on loginpwd">密码</span>
            <input type="password" placeholder="请输入密码" class="span2 input-xfat" name="password">
        </div>
        <div class="logined">
            <a class="sui-btn btn-block btn-xlarge btn-danger"
               href='javascript:document:loginform.submit();' target="_self">登&nbsp;&nbsp;录</a>
        </div>
    </form>
</div>

</body>
</html>
