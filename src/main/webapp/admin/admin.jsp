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
  您好，${USER_SESSION.name}
  身份：${USER_SESSION.role}
  <a href="${pageContext.request.contextPath}/user/logout">注销</a>
</div>

<div id="menu">
  <a href="${pageContext.request.contextPath}/admin/admin.jsp">首页</a>
  <a href="${pageContext.request.contextPath}/event/search" target="iframe">全部活动</a>
  <a href="${pageContext.request.contextPath}/admin/approve" target="iframe">全部审批</a>
  <a href="${pageContext.request.contextPath}/admin/info" target="iframe">用户管理</a>
</div>

<div id="content">
  <iframe height="600px" width="100%"  id="iframe" name="iframe" src="${pageContext.request.contextPath}/event/getNewEvents"></iframe>
</div>
</body>
</html>
