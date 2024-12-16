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
    <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
</head>
<body>
    <div class="box">
        <table id="dg" title="活动列表">
            <thead>
                <tr>
                    <th field="1">活动名称</th>
                    <th field="2">详情</th>
                    <th field="3">开始日期</th>
                    <th field="4">结束日期</th>
                    <th field="5">地点</th>
                    <th field="6">组织人</th>
                    <th field="7">更新时间</th>
                    <th field="8">操作</th>
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
                        <td>${event.organizerId}</td>
                        <td>${event.createdAt}</td>
                        <c:if test="${USER_SESSION.role == 'Admin'}">
                            <td>
                                <c:if test="${event.status == 'Approved'}">
                                    <button>去参加</button>
                                </c:if>
                                <c:if test="${event.status == 'Pending'}">
                                    <button>去审批</button>
                                </c:if>
                                <c:if test="${event.status == 'Rejected'}">
                                    <button>未通过</button>
                                </c:if>
                                <c:if test="${event.status == 'Completed'}">
                                    <button disabled>已结束</button>
                                </c:if>
                            </td>
                        </c:if>
                        <c:if test="${USER_SESSION.role != 'Admin'}">
                            <td>
                                <c:if test="${event.status == 'Approved'}">
                                    <button>去参加</button>
                                </c:if>
                                <c:if test="${event.status == 'Pending'}">
                                    <button disabled>未审批</button>
                                </c:if>
                                <c:if test="${event.status == 'Rejected'}">
                                    <button disabled>未通过</button>
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
        title:'应用系统列表',
        iconCls:'icon-edit',//图标
        nowrap: true,
        striped: true,
        border: true,
        collapsible:false,//是否可折叠的
        remoteSort:false,
        idField:'fldId',
        singleSelect:false,//是否单选
        pagination:true,//分页控件
        rownumbers:true,//行号
        toolbar: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function() {
                openDialog("add_dialog","add");
            }
        }, '-', {
            text: '修改',
            iconCls: 'icon-edit',
            handler: function() {
                openDialog("add_dialog","edit");
            }
        }, '-',{
            text: '删除',
            iconCls: 'icon-remove',
            handler: function(){
                delAppInfo();
            }
        }],
    });
    function StandardPost(url, args) {
        var form = $("<form method='post'></form>");
        form.attr({"action": url});
        for (var arg in args) {
            var input = $("<input type='hidden'>");
            input.attr({"name": arg});
            input.val(args[arg]);
            form.append(input);
        }
        form.appendTo("body").submit();  // 将表单添加到 body 中并提交，确保表单能正确提交
    }

    // 设置分页控件
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        total: ${pageResult.total},
        pageSize: 10, // 每页显示的记录条数，默认为10
        pageList: [5, 10, 15], // 可以设置每页记录条数的列表
        beforePageText: '第', // 页数文本框前显示的汉字
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        onSelectPage: function(pageNumber, pageSize) {
            $(this).pagination('loading'); // 显示加载状态
            // 调用 StandardPost 函数，传递 URL 和参数
            StandardPost('search', { // 假设你的搜索页面是 search.php
                pageNum: pageNumber,
                pageSize: pageSize
            });
            $(this).pagination('loaded'); // 隐藏加载状态
        }
    });
</script>

</html>
