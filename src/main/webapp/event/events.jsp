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
    <div class="easyui-layout" style="width: auto; height: 100%">
        <div data-options="region:'west',split:true" style="width: 90%">
            <table id="dg" title="活动列表">
                <thead>
                <tr>
                    <th field="1">活动名称</th>
                    <th field="2" width="200">详情</th>
                    <th field="3">开始日期</th>
                    <th field="4">结束日期</th>
                    <th field="5">地点</th>
                    <th field="6">更新时间</th>
                    <th field="7">状态</th>
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
                        <td>${event.createdAt}</td>
                        <td>
                            <c:if test="${event.status == 'Progressing'}">
                                <span style="color: #007b1f">进行中</span>
                            </c:if>
                            <c:if test="${event.status == 'Completed'}">
                                <span style="color: red">已结束</span>
                            </c:if>
                        </td>
                        <c:if test="${USER_SESSION.role != 'Admin'}">
                            <td><button onclick="editEvent(${event.eventId})">修改</button></td>
                        </c:if>
                        <c:if test="${USER_SESSION.role == 'Admin'}">
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
        <div data-options="region:'east',split:true" title="East" style="width:10%">
            测试
        </div>
    </div>

<%--    添加活动--%>
    <div class="add-event-dialog">
        <div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
            <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
                <h3>活动信息</h3>
                <div style="margin-bottom:10px">
                    <input name="eventName" class="easyui-textbox" required label="活动名称:" style="width:100%">
                </div>
                <div style="margin-bottom:10px">
                    <input name="location" class="easyui-textbox" required label="活动地点:" style="width:100%">
                </div>
                <div style="margin-bottom:10px">
                    <input name="eventStartDate" type="datetime-local" class="easyui-textbox" required label="开始时间:" style="width:100%">
                </div>
                <div style="margin-bottom:10px">
                    <input name="eventEndDate" type="datetime-local" class="easyui-textbox" required label="结束时间:" style="width:100%">
                </div>
                <div style="margin-bottom: 10px">
                    <select class="easyui-combobox" name="state" required label="活动状态:" style="width:100%;">
                        <option value="Progressing">进行中</option>
                        <option value="Completed">已结束</option>
                    </select>
                </div>
                <div style="margin-bottom:20px">
                    <input name="eventDescription" multiline="true" class="easyui-textbox" label="活动描述:" style="width:100%; height:120px">
                </div>
            </form>
        </div>
        <!-- 对话框按钮 -->
        <div id="dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
        </div>
    </div>

<%--    修改活动--%>
    <div class="edit-event-dialog">
        <div id="dlgEditEvent" class="easyui-dialog" title="修改活动" style="width:400px;padding:20px"
             closed="true" buttons="#dlgButtons">
            <form id="fmEditEvent" method="post" class="easyui-form" data-options="novalidate:true">
                <input type="hidden" name="eventId" id="eventId">
                <div style="margin-bottom:20px">
                    <label for="eventName">活动名称:</label>
                    <input class="easyui-textbox" name="eventName" id="eventName" style="width:100%" required="true">
                </div>
                <div style="margin-bottom:20px">
                    <label for="eventDescription">活动描述:</label>
                    <textarea class="easyui-textbox" name="eventDescription" id="eventDescription" style="width:100%;height:80px" required="true"></textarea>
                </div>
            </form>
        </div>
        <!-- 对话框按钮 -->
        <div id="dlgButtons">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveEvent()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlgEditEvent').dialog('close')">取消</a>
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
        toolbar: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function newUser(){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','新建活动');
                $('#fm').form('clear');
                url = 'addEvent';
            },
        }],
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

    var url
    function saveUser(){
        $('#fm').form('submit',{
            url: url,
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                var result = eval('('+result+')');
                if (result.errorMsg){
                    $.messager.alert('错误',result.errorMsg, 'error', () => {
                        location.reload()
                    });
                } else {
                    $.messager.alert('成功','信息提交成功', 'info', () => {
                        location.reload()
                    });
                }
            }
        });
    }

    function editEvent(eventId){
        $.ajax({
            url: "findeventbyeventid",
            data: {eventId: eventId},
            type: "POST",
            dataType: "json",
            success: function(data) {
                // 由于已经设置了dataType为json，data已经是解析后的对象
                if (data.success) {
                    var event = data.event;
                    $('#eventId').val(event.eventId);
                    $('#eventName').textbox('setValue', event.eventName);
                    $('#eventDescription').textbox('setValue', event.eventDescription);
                    $('#dlgEditEvent').dialog('open')

                    // 您可以在这里添加更多逻辑，比如更新页面上的元素等
                } else {
                    console.error("Failed to fetch event data.");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                // 处理请求失败的情况
                console.error("AJAX Error: " + textStatus + ' : ' + errorThrown);
            }
        });
    }

    function saveEvent() {
        $('#fmEditEvent').form('submit', {
            url: 'updateevent', // 确保这个URL和后端的@RequestMapping相匹配
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if (data) {
                    $.messager.alert('成功','信息提交成功', 'info', () => {
                        location.reload()
                    });
                } else {
                    $.messager.alert('错误',result.errorMsg, 'error', () => {
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
