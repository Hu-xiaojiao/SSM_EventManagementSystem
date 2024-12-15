<%--
  Created by IntelliJ IDEA.
  User: Huxiaojiao
  Date: 2024/12/15
  Time: 23:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>活动审批管理系统</title>
</head>
<body>
    <div id="header">
        <a href="${pageContext.request.contextPath}/user/logout">注销</a>
    </div>

    <div id="menu">
        <a href="${pageContext.request.contextPath}/admin/index.jsp">首页</a>
        <a href="${pageContext.request.contextPath}/admin/activity">全部活动</a>
        <a href="${pageContext.request.contextPath}/admin/approve">全部审批</a>
        <a href="${pageContext.request.contextPath}/admin/account">用户管理</a>
    </div>

    <div id="content">
        <iframe width="100%" id="iframe" name="iframe" src="${pageContext.request.contextPath}/event/getNewBooks"></iframe>
    </div>
</body>
</html>
