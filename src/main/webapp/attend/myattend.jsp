<%-- Created by IntelliJ IDEA. User: Huxiaojiao Date: 2024/12/15 Time: 23:23 To change this template use File | Settings
    | File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <html>

            <head>
                <title>报名列表</title>
                <link rel="stylesheet" type="text/css"
                    href="${pageContext.request.contextPath}/js/themes/default/easyui.css">
                <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css">
                <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
                <script type="text/javascript"
                    src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
            </head>

            <body style="margin: 0">
                <div class="easyui-layout" style="width: auto; height: 100%">
                    <div data-options="region:'west',split:true" style="width: 90%">
                        <table id="dg" title="我的报名">
                            <thead>
                                <tr>
                                    <th field="2" width="200">活动名称</th>
                                    <th field="3" width="200">报名日期</th>
<%--                                    <th field="4" width="200">最后更新</th>--%>
                                    <th field="5" width="75">状态</th>
                                    <th field="6" width="75">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pageResult.rows}" var="attend">
                                    <tr>
                                        <td>${attend.eventName}</td>
                                        <td>${attend.createdAt}</td>
<%--                                        <td>${attend.updatedAt}</td>--%>
                                        <td>
                                            <c:if test="${attend.attendStatus == 'Pending'}">
                                                <span style="color: gray">未确认</span>
                                            </c:if>
                                            <c:if test="${attend.attendStatus == 'Confirmed'}">
                                                <span style="color: #007b1f">已确认</span>
                                            </c:if>
                                            <c:if test="${attend.attendStatus == 'Declined'}">
                                                <span style="color: red">已拒绝</span>
                                            </c:if>
                                        </td>
                                        <td><button onclick="delAttend(${attend.attendId})">删除</button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div data-options="region:'east',split:true" title="East" style="width:10%">
                        测试
                    </div>
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
                });


                function changePage(pageNo, pageSize) {
                    $('<form>', {
                        'action': '<%= request.getContextPath() %>/attend/myattend',
                        'method': 'post',
                        'name': 'form1',
                        'style': 'display:none'
                    }).append(
                        $('<input>', { 'type': 'hidden', 'name': 'pageNum', 'value': pageNo }),
                        $('<input>', { 'type': 'hidden', 'name': 'pageSize', 'value': pageSize })
                    ).appendTo(document.body).submit();
                }

                var totalRecords = ${ pageResult.total };
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

                function delAttend(attendId) {
                    $.messager.confirm('确认报名', '确定要删除这个报名吗？', function (r) {
                        if (r) {
                            $.ajax({
                                url: "${pageContext.request.contextPath}/attend/delattend",
                                data: {attendId: attendId},
                                type: "POST",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    if (data.success) {
                                        $.messager.alert('成功', '删除成功', 'info', () => {
                                            location.reload()
                                        });
                                    } else {
                                        $.messager.alert('错误', data.errorMsg, 'error', () => {
                                            location.reload()
                                        });
                                    }
                                },
                                error: function (xhr, status, error) {
                                    $.messager.alert('错误', JSON.parse(xhr.responseText)['errorMsg'], 'error');
                                }
                            })
                        }
                    });
                }
            </script>

            </html>