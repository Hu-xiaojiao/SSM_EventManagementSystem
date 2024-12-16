<%--
  Created by IntelliJ IDEA.
  User: Huxiaojiao
  Date: 2024/12/15
  Time: 23:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>最新活动</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
</head>
<body style="margin: 0">
<div class="box">
    <table id="dg" title="活动列表">
        <thead>
        <tr>
            <th field="1">活动名称</th>
            <th field="2" style="width: inherit">详情</th>
            <th field="3">开始日期</th>
            <th field="4">结束日期</th>
            <th field="5">地点</th>
            <th field="7">更新时间</th>
            <th field="8">状态</th>
            <th field="9">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.rows}" var="event">
            <tr>
                <td>${event.eventName}</td>
                <td>${event.eventDescription}</td>
                <td>${event.eventStartDate}</td>
                <td>${event.eventEndDate}</td>
                <td>${event.location}</td>
                <td>${event.createdAt}</td>
                <td>
                    <c:if test="${event.status == 'Progressing'}">
                        <span style="color: #007b1f">进行中</span>
                    </c:if>
                    <c:if test="${event.status == 'Completed'}">
                        <span style="color: red">已结束</span>
                    </c:if>
                </td>
                <c:if test="${USER_SESSION.role == 'Admin'}">
                    <td><button>修改</button></td>
                </c:if>
                <c:if test="${USER_SESSION.role != 'Admin'}">
                    <td>
                        <c:if test="${event.status == 'Progressing'}">
                            <button>去参加</button>
                        </c:if>
                        <c:if test="${event.status == 'Completed'}">
                            <button disabled>已结束</button>
                        </c:if>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>

<script>
    //datagrid初始化
    $('#dg').datagrid({
        iconCls: 'icon-edit', //图标
        nowrap: true,
        striped: true,
        border: true,
        collapsible: false, //是否可折叠的
        remoteSort: false,
        idField: 'fldId',
        singleSelect: true, //是否单选
        pagination: true, //分页控件
        rownumbers: true, //行号
        <c:if test="${SESSION_USER.role == 'Admin'}">
            toolbar: [{
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    openDialog("add_dialog", "add");
                }
            }, '-', {
                text: '修改',
                iconCls: 'icon-edit',
                handler: function () {
                    openDialog("add_dialog", "edit");
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    delAppInfo();
                }
            }],
        </c:if>
    });

    function changePage(pageNo, pageSize) {
        $('<form>', {
            'action': '<%= request.getContextPath() %>/event/search',
            'method': 'post',
            'name': 'form1',
            'style': 'display:none'
        }).append(
            $('<input>', { 'type': 'hidden', 'name': 'pageNum', 'value': pageNo }),
            $('<input>', { 'type': 'hidden', 'name': 'pageSize', 'value': pageSize })
        ).appendTo(document.body).submit();
    }

    var totalRecords = ${pageResult.total};
    // 由后端传递的总记录数
    <c:choose>
        <c:when test="${param.pageNum == null}">
        var currentPage = 1; var pageSize = 10;
        </c:when>
        <c:otherwise>
        var currentPage = ${param.pageNum};
        var pageSize = ${param.pageSize};
        </c:otherwise>
    </c:choose>

    // 设置分页控件
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        total: totalRecords,
        pageSize: pageSize,
        pageNumber: currentPage,
        onSelectPage: function (pageNumber, pageSize) {
            changePage(pageNumber, pageSize);
        },
        showPageList: false
    });
</script>

</html>
