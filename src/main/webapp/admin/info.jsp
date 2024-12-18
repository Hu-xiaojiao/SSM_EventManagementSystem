<%-- Created by IntelliJ IDEA. User: ningjialin Date: 2024/12/16 Time: 09:04 To change this template use File | Settings
    | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>我的信息</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
</head>

<body>
<h2>我的信息</h2>
<table id="pg" class="easyui-propertygrid" style="width:300px">
    <tr>
        <td></td>
        <td>用户名：</td>
        <td>${USER_SESSION.name}</td>
    </tr>
    <tr>
        <td></td>
        <td>电子邮箱：</td>
        <td>${USER_SESSION.email}</td>
    </tr>
    <tr>
        <td></td>
        <td>用户类型：</td>
        <td>${USER_SESSION.role}</td>
    </tr>
    <tr>
        <td></td>
        <td>用户状态：</td>
        <td>${USER_SESSION.status}</td>
    </tr>
    <tr>
        <td></td>
        <td>更新时间：</td>
        <td>${USER_SESSION.updatedAt}</td>
    </tr>
</table>

<h3>修改个人信息</h3>
<form id="updateUserInfoForm" method="post">
    <table>
        <tr>
            <td>用户名：</td>
            <td>
                <input type="hidden" name="userId" value="${USER_SESSION.userId}">
                <input type="text" name="name" value="${USER_SESSION.name}"></td>
        </tr>
        <tr>
            <td>电子邮箱：</td>
            <td><input type="email" name="email" value="${USER_SESSION.email}" required></td>
        </tr>
        <tr>
            <td>密码（留空则不更改）：</td>
            <td><input type="password" name="password"></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="更新信息">
            </td>
        </tr>
    </table>
</form>

<script>
    $(document).ready(function(){
        $('#updateUserInfoForm').on('submit', function(event){
            event.preventDefault(); // Prevent the default form submission

            $.ajax({
                url: '${pageContext.request.contextPath}/user/updateUserInfo',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    if(response.status === 'success') {
                        // Redirect the parent window to the login page on success
                        $.messager.alert('成功', '信息提交成功，即将自动注销！', 'info', parent.window.location.href = '${pageContext.request.contextPath}/');
                    } else {
                        $.messager.alert('错误', esponse.msg, 'error');
                    }
                },
                error: function(xhr, status, error) {
                    $.messager.alert('发生错误', xhr.responseText, 'error');
                }
            });
        });
    });
</script>
</body>

</html>