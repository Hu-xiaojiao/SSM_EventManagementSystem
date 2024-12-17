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
    <title>报名列表</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
</head>
<body style="margin: 0">
<div class="easyui-layout" style="width: auto; height: 100%">
    <div data-options="region:'west',split:true" style="width: 90%">
        <table id="dg" title="报名列表">
            <thead>
            <tr>
                <th field="1" width="150">报名人</th>
                <th field="2" width="200">活动名称</th>
                <th field="3" width="200">报名日期</th>
                <th field="4" width="200">最后更新</th>
                <th field="5" width="75">状态</th>
                <th field="6" width="75">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageResult.rows}" var="attend">
                <tr>
                    <td>${attend.name}</td>
                    <td>${attend.eventName}</td>
                    <td>${attend.createdAt}</td>
                    <td>${attend.updatedAt}</td>
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
                    <td><button onclick="editAttend(${attend.attendId})">修改</button></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div data-options="region:'east',split:true" title="East" style="width:10%">
        测试
    </div>
</div>

<%--&lt;%&ndash;    添加报名&ndash;%&gt;--%>
<%--<div class="add-attend-dialog">--%>
<%--    <div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">--%>
<%--        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">--%>
<%--            <h3>报名信息</h3>--%>
<%--            <div style="margin-bottom:10px">--%>
<%--                <input name="attendName" class="easyui-textbox" required label="活动名称:" style="width:100%">--%>
<%--            </div>--%>
<%--            <div style="margin-bottom:10px">--%>
<%--                <input name="location" class="easyui-textbox" required label="报名人:" style="width:100%">--%>
<%--            </div>--%>
<%--            <div style="margin-bottom: 10px">--%>
<%--                <select class="easyui-combobox" name="state" required label="报名状态:" style="width:100%;">--%>
<%--                    <option value="Pending">未确认</option>--%>
<%--                    <option value="Confirmed">已确认</option>--%>
<%--                    <option value="Declined">已拒绝</option>--%>
<%--                </select>--%>
<%--            </div>--%>
<%--            <div style="margin-bottom:20px">--%>
<%--                <input name="attendDescription" multiline="true" class="easyui-textbox" label="活动描述:" style="width:100%; height:120px">--%>
<%--            </div>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--    <!-- 对话框按钮 -->--%>
<%--    <div id="dlg-buttons">--%>
<%--        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">保存</a>--%>
<%--        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>--%>
<%--    </div>--%>
<%--</div>--%>

<%--    修改状态--%>
<div class="edit-attend-dialog">
    <div id="dlgEditAttend" class="easyui-dialog" title="修改活动" style="width:400px;padding:20px"
         closed="true" buttons="#dlgButtons">
        <form id="fmEditAttend" method="post" class="easyui-form" data-options="novalidate:true">
            <input type="hidden" name="attendId" id="attendId">
            <div style="margin-bottom: 10px">
                <select class="easyui-combobox" name="attendStatus" required label="报名状态:" style="width:100%;">
                    <option value="Pending">未确认</option>
                    <option value="Confirmed">已确认</option>
                    <option value="Declined">已拒绝</option>
                </select>
            </div>
        </form>
    </div>
    <!-- 对话框按钮 -->
    <div id="dlgButtons">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateAttend()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlgEditAttend').dialog('close')">取消</a>
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
            'action': '<%= request.getContextPath() %>/attend/search',
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

    function editAttend(attendId){
        $.ajax({
            url: "findattendbyattendid",
            data: {attendId: attendId},
            type: "POST",
            dataType: "json",
            success: function(data) {
                // 由于已经设置了dataType为json，data已经是解析后的对象
                if (data.success) {
                    var attend = data.Attend;
                    $('#attendId').val(attend.attendId);
                    $('#attendStatus').val(attend.attendStatus);
                    $('#dlgEditAttend').dialog('open')

                    // 您可以在这里添加更多逻辑，比如更新页面上的元素等
                } else {
                    console.error("Failed to fetch attend data.");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                // 处理请求失败的情况
                console.error("AJAX Error: " + textStatus + ' : ' + errorThrown);
            }
        });
    }

    function updateAttend() {
        $('#fmEditAttend').form('submit', {
            url: 'updateattend', // 确保这个URL和后端的@RequestMapping相匹配
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if (data) {
                    $.messager.alert('成功','信息提交成功', 'info', () => {
                        location.reload()
                    });
                } else {
                    $.messager.alert('错误',data.errorMsg, 'error', () => {
                        location.reload()
                    });
                }
            },
            error: function (xhr, status, error) {
                console.log(xhr.responseText); // 打印错误响应
                $.messager.alert('错误', '请求失败，请稍后再试', 'error');
            }
        });
    }
</script>

</html>
