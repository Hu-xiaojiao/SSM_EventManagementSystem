<%-- Created by IntelliJ IDEA.
User: Huxiaojiao
Date: 2024/12/15
Time: 23:23
To change this template use File | Settings | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <title>最新活动</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
</head>

<body style="margin: 0">
<div class="box">
    <table id="dg" title="最新活动">
        <thead>
        <tr>
            <th field="1">活动名称</th>
            <th field="2">详情</th>
            <th field="3">开始日期</th>
            <th field="4">结束日期</th>
            <th field="5">地点</th>
            <th field="7">创建时间</th>
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
                <c:if test="${USER_SESSION.role == 'Admin'}">
                    <td>
                        <button onclick="editEvent(${event.eventId})">修改</button>
                    </td>
                </c:if>
                <c:if test="${USER_SESSION.role != 'Admin'}">
                    <td>
                        <button onclick="attendEvent(${event.eventId})">去参加</button>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%-- 修改活动--%>
<div class="edit-event-dialog">
    <div id="dlgEditEvent" class="easyui-dialog" title="修改活动" style="width:400px;padding:20px"
         closed="true" buttons="#dlgButtons">
        <form id="fmEditEvent" method="post" class="easyui-form" data-options="novalidate:true">
            <input type="hidden" name="eventId" id="eventId">
            <h3>活动信息</h3>
            <div style="margin-bottom:10px">
                <input name="eventName" id="eventName" class="easyui-textbox" required label="活动名称:"
                       style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="location" id="location" class="easyui-textbox" required label="活动地点:"
                       style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="eventStartDate" id="eventStartDate"
                       data-options="formatter:ww4,parser:w4" class="easyui-datetimebox" required
                       label="开始时间:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="eventEndDate" id="eventEndDate" data-options="formatter:ww4,parser:w4"
                       class="easyui-datetimebox" required label="结束时间:" style="width:100%">
            </div>
            <div style="margin-bottom: 10px">
                <select class="easyui-combobox" name="status" id="status" required label="活动状态:"
                        style="width:100%;">
                    <option value="Progressing">进行中</option>
                    <option value="Completed">已结束</option>
                </select>
            </div>
            <div style="margin-bottom:20px">
                <input name="eventDescription" id="eventDescription" multiline="true"
                       class="easyui-textbox" label="活动描述:" style="width:100%; height:120px">
            </div>
        </form>
    </div>
    <!-- 对话框按钮 -->
    <div id="dlgButtons">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateEvent()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"
           onclick="$('#dlgEditEvent').dialog('close')">取消</a>
    </div>
</div>
</body>

<script>
    //datagrid初始化
    $('#dg').datagrid({
        iconCls: 'icon-edit',//图标
        nowrap: true,
        striped: true,
        border: true,
        collapsible: false,//是否可折叠的
        remoteSort: false,
        idField: 'fldId',
        singleSelect: true,//是否单选
    });

    function ww4(date) {
        let y = date.getFullYear();
        let m = date.getMonth() + 1;
        let d = date.getDate();
        let h = date.getHours();
        let min = date.getMinutes();
        let s = date.getSeconds();
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d)
            + ' ' + (h < 10 ? ('0' + h) : h) + ':' + (min < 10 ? ('0' + min) : min)
            + ':' + (s < 10 ? ('0' + s) : s);
    }

    function w4(s) {
        if (!s) return new Date();
        let ss = s.split(' ');
        let d = ss[0].split('-');
        let t = ss[1].split(':');
        return new Date(parseInt(d[0], 10), parseInt(d[1], 10) - 1,
            parseInt(d[2], 10), parseInt(t[0], 10),
            parseInt(t[1], 10), parseInt(t[2], 10));
    }

    function editEvent(eventId) {
        $.ajax({
            url: "findeventbyeventid",
            data: {eventId: eventId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                // 由于已经设置了dataType为json，data已经是解析后的对象
                if (data.success) {
                    var event = data.event;

                    // 将时间戳转换为格式化的日期字符串
                    var formattedStartDate = formatTimestamp(event.eventStartDate);
                    var formattedEndDate = formatTimestamp(event.eventEndDate);

                    $('#eventId').val(event.eventId);
                    $('#eventName').textbox('setValue', event.eventName);
                    $('#location').textbox('setValue', event.location);
                    $('#eventStartDate').textbox('setValue', formattedStartDate);
                    $('#eventEndDate').textbox('setValue', formattedEndDate);
                    $('#status').val(event.status);
                    $('#eventDescription').textbox('setValue', event.eventDescription);
                    $('#dlgEditEvent').dialog('open');

                    // 您可以在这里添加更多逻辑，比如更新页面上的元素等
                } else {
                    console.error("Failed to fetch event data.");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // 处理请求失败的情况
                console.error("AJAX Error: " + textStatus + ' : ' + errorThrown);
            }
        });
    }

    function formatTimestamp(timestamp) {
        var date = new Date(timestamp);
        var y = date.getFullYear();
        var m = ('0' + (date.getMonth() + 1)).slice(-2); // 月份补零
        var d = ('0' + date.getDate()).slice(-2); // 日期补零
        var h = ('0' + date.getHours()).slice(-2); // 小时补零
        var min = ('0' + date.getMinutes()).slice(-2); // 分钟补零
        var s = ('0' + date.getSeconds()).slice(-2); // 秒补零

        return y + '-' + m + '-' + d + ' ' + h + ':' + min + ':' + s;
    }

    function updateEvent() {
        $('#fmEditEvent').form('submit', {
            url: 'updateevent', // 确保这个URL和后端的@RequestMapping相匹配
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if (data) {
                    $.messager.alert('成功', '信息提交成功', 'info', () => {
                        location.reload();
                    });
                } else {
                    $.messager.alert('错误', data.errorMsg, 'error', () => {
                        location.reload();
                    });
                }
            },
            error: function (xhr, status, error) {
                console.log(xhr.responseText); // 打印错误响应
                $.messager.alert('错误', '请求失败，请稍后再试', 'error');
            }
        });
    }

    function attendEvent(eventId) {
        $.messager.confirm('确认报名', '确定要报名这个活动吗？', function (r) {
            if (r) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/attend/addattend",
                    data: {eventId: eventId, userId: ${ USER_SESSION.userId }},
                    type: "POST",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.success) {
                            $.messager.alert('成功', '报名成功', 'info', () => {
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