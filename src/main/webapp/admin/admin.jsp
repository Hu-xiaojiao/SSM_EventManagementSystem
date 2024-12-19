<%-- Created by IntelliJ IDEA. User: Huxiaojiao Date: 2024/12/15 Time: 23:16 To change this template use File | Settings
    | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>活动审批管理系统</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
</head>

<body class="easyui-layout">
<div title="活动管理系统" data-options="region:'north'" style="height: 60px">
    您好，${USER_SESSION.name}
    身份：${USER_SESSION.role}
    <a href="${pageContext.request.contextPath}/user/logout">注销</a>
</div>
<div data-options="region:'west',title:'菜单',split:true" style="width:180px;">
    <ul id="menu" class="easyui-tree" style="margin-top: 10px;margin-left: 5px;">
        <li>
            <a href="${pageContext.request.contextPath}/admin/admin.jsp">首页</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/event/search" target="iframe">全部活动</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/attend/search" target="iframe">全部报名</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/user/search" target="iframe">账号管理</a>
        </li>
    </ul>
</div>
<div data-options="region:'center',title:''">
    <div title="首页">
        <iframe style="border: none" height="100%" width="100%" id="iframe" name="iframe"
                src="${pageContext.request.contextPath}/event/getNewEvents"></iframe>
    </div>
</div>
</body>

</html>