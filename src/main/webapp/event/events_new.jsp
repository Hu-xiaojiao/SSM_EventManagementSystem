<%--
  Created by IntelliJ IDEA.
  User: Huxiaojiao
  Date: 2024/12/15
  Time: 23:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>最新活动</title>
</head>
<body>

<div class="box">
    <table id="dataList" border="1">
        <thead>
            <tr>
                <th>活动名称</th>
                <th>详情</th>
                <th>开始日期</th>
                <th>结束日期</th>
                <th>地点</th>
                <th>组织人</th>
                <th>更新时间</th>
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
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
