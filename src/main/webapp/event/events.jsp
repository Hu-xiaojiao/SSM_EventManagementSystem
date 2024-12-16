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
</head>
<body>

<div class="box">
    <div class="box-tools pull-right">
        <div class="has-feedback">
            <c:if test="${USER_SESSION.role == 'Admin'}">
                <button>新增</button>
            </c:if>
            <form action="${pageContext.request.contextPath}/event/search" method="post" accept-charset="UTF-8">
                <label>活动名称：<input name="eventName" value="${search.eventName}"></label>
                <label>地点：<input name="location" value="${search.location}"></label>
                <input class="btn btn-default" type="submit" value="查询">
            </form>
        </div>
    </div>
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
                <th>操作</th>
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
    <div id="pagination" class="pagination"></div>
</div>

<!-- 添加和编辑图书的模态窗口 -->
<dialog style="visibility: visible; display: block" class="modal fade" id="addOrEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="myModalLabel">活动信息</h3>
            </div>
            <div class="modal-body">
                <form id="addOrEditBook">
                    <span><input type="hidden" id="ebid" name="id"></span>
                    <table id="addOrEditTab" class="table table-bordered table-striped" width="800px">
                        <%--图书的id,不展示在页面--%>
                        <tr>
                            <td>活动名称</td>
                            <td><input class="form-control" placeholder="活动名称" name="eventName"></td>
                            <td>组织人</td>
                            <td><input class="form-control" placeholder="组织人" name="orgorganizerId" ></td>
                        </tr>
                        <tr>
                            <td>开始时间</td>
                            <td><input class="form-control" name="eventStartDate" type="date"></td>
                            <td>结束时间</td>
                            <td><input class="form-control" name="eventEndDate" type="date"></td>
                        </tr>
                        <tr>
                            <td>地点</td>
                            <td><input class="form-control" placeholder="活动地点" name="location"></td>
                            <td>状态</td>
                            <td>
                                <select class="form-control" name="status" >
                                    <option value="0">未审批</option>
                                    <option value="1">已通过</option>
                                    <option value="2">未通过</option>
                                    <option value="3">已结束</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>详细信息</td>
                            <td colspan="3"><textarea></textarea></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success" data-dismiss="modal" aria-hidden="true" onclick="addOrEdit()">提交
                </button>
                <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
    </div>
</dialog>

</body>

<script>
    pageargs.total = Math.ceil(${pageResult.total}/pageargs.pagesize);
    pageargs.cur = ${pageNum}
        /*分页插件页码变化时将跳转到的服务器端的路径*/
    pageargs.gourl = "${gourl}"
    pagination(pageargs)
</script>

</html>
