<%--
  Created by IntelliJ IDEA.
  User: ningjialin
  Date: 2024/12/16
  Time: 09:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的信息</title>
</head>
<body>
<h2>我的信息</h2>
<table>
    <tr>
        <td>用户名：</td>
        <td>${USER_SESSION.name}</td>
    </tr>
    <tr>
        <td>电子邮箱：</td>
        <td>${USER_SESSION.email}</td>
    </tr>
    <tr>
        <td>用户类型：</td>
        <td>${USER_SESSION.role}</td>
    </tr>
    <tr>
        <td>用户状态：</td>
        <td>${USER_SESSION.status}</td>
    </tr>
    <!-- 隐藏密码显示，出于安全考虑，不应直接显示密码 -->
    <!-- <tr>
            <td>密码：</td>
            <td>${USER_SESSION.password}</td>
        </tr> -->
    <tr>
        <td>更新时间：</td>
        <td>${USER_SESSION.updatedAt}</td>
    </tr>
</table>

<h3>修改个人信息</h3>
<form action="updateUserInfo" method="post">
    <table>
        <tr>
            <td>用户名：</td>
            <td><input type="text" name="name" value="${USER_SESSION.name}" readonly></td>
        </tr>
        <tr>
            <td>电子邮箱：</td>
            <td><input type="email" name="email" value="${USER_SESSION.email}" required></td>
        </tr>
        <tr>
            <td>密码（如需更改）：</td>
            <td><input type="password" name="password"></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="更新信息">
            </td>
        </tr>
    </table>
</form>

<!-- 如果有更新结果或错误信息，可以在这里显示 -->
<c:if test="${not empty message}">
    <p style="color:red;">${message}</p>
</c:if>
</body>
</html>