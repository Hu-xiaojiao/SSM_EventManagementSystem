<%-- Created by IntelliJ IDEA. User: Huxiaojiao Date: 2024/12/15 Time: 23:23 To change this template use File | Settings
    | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
  <title>全部账号</title>
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
    <table id="dg" title="全部账号">
      <thead>
      <tr>
        <th field="2" width="50">用户 ID</th>
        <th field="3" width="150">用户名</th>
        <th field="4" width="150">电子邮件</th>
        <th field="5" width="75">用户类型</th>
        <th field="6" width="200">创建时间</th>
        <th field="7" width="150">操作</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${pageResult.rows}" var="user">
        <tr>
          <td>${user.userId}</td>
          <td>${user.name}</td>
          <td>${user.email}</td>
          <td>
            <c:if test="${user.role == 'Admin'}">
              <span style="color: gray">管理员</span>
            </c:if>
            <c:if test="${user.role == 'Participant'}">
              <span style="color: #007b1f">普通用户</span>
            </c:if>
          </td>
          <td>${user.createdAt}</td>
          <td>
            <button onclick="editUser(${user.userId})">修改</button>
            <button onclick="delUser(${user.userId})">删除</button>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
  <div data-options="region:'east',split:true" title="East" style="width:10%">
    测试
  </div>
</div>

<%-- 添加用户--%>
<div class="add-user-dialog">
  <div id="dlg" class="easyui-dialog" style="width:400px"
       data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
      <h3>用户信息</h3>
      <div style="margin-bottom:10px">
        <input name="name" class="easyui-textbox" required label="用户名:"
               style="width:100%">
      </div>
      <div style="margin-bottom:10px">
        <input name="email" class="easyui-textbox" required label="电子邮箱:"
               style="width:100%">
      </div>
      <div style="margin-bottom:10px">
        <input name="password" class="easyui-textbox" required label="密码:"
               style="width:100%">
      </div>
      <div style="margin-bottom: 10px">
        <select class="easyui-combobox" name="role" required label="用户类型:"
                style="width:100%;">
          <option value="Admin">管理员</option>
          <option value="Participant">参与者</option>
        </select>
      </div>
    </form>
  </div>
  <!-- 对话框按钮 -->
  <div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok"
       onclick="addUser()" style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
  </div>
</div>

<%-- 修改用户--%>
<div class="edit-user-dialog">
  <div id="dlgEditUser" class="easyui-dialog" title="修改用户" style="width:400px;padding:20px"
       closed="true" buttons="#dlgButtons">
    <form id="fmEditUser" method="post" class="easyui-form" data-options="novalidate:true">
      <h3>用户信息</h3>
      <div style="margin-bottom:10px">
        <input name="userId" type="hidden">
        <input name="name" class="easyui-textbox" required label="用户名:"
               style="width:100%">
      </div>
      <div style="margin-bottom:10px">
        <input name="email" class="easyui-textbox" required label="电子邮箱:"
               style="width:100%">
      </div>
      <div style="margin-bottom:10px">
        <input name="password" class="easyui-textbox" required label="密码:"
               style="width:100%">
      </div>
      <div style="margin-bottom: 10px">
        <select class="easyui-combobox" name="role" required label="用户类型:"
                style="width:100%;">
          <option value="Admin">管理员</option>
          <option value="Participant">参与者</option>
        </select>
      </div>
    </form>
  </div>
  <!-- 对话框按钮 -->
  <div id="dlgButtons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateUser()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton"
       onclick="$('#dlgEditUser').dialog('close')">取消</a>
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
      handler: function newUser() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新建用户');
        $('#fm').form('clear');
        url = 'addUser';
      },
    }],
  });


  function changePage(pageNo, pageSize) {
    $('<form>', {
      'action': '<%= request.getContextPath() %>/user/account',
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

  var url

  function addUser() {
    $('#fm').form('submit', {
      url: url,
      onSubmit: function () {
        return $(this).form('validate');
      },
      success: function (result) {
        var result = eval('(' + result + ')');
        if (result.errorMsg) {
          $.messager.alert('错误', result.errorMsg, 'error', () => {
            location.reload()
          });
        } else {
          $.messager.alert('成功', '信息提交成功', 'info', () => {
            location.reload()
          });
        }
      }
    });
  }

  function delUser(userId) {
    $.messager.confirm('确认删除', '确定要删除这个用户吗？', function (r) {
      if (r) {
        $.ajax({
          url: "${pageContext.request.contextPath}/user/deluser",
          data: {userId: userId},
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

  function editUser(userId) {
    $.ajax({
      url: "finduserbyuserid",
      data: {userId: userId},
      type: "POST",
      dataType: "json",
      success: function (data) {
        // 由于已经设置了dataType为json，data已经是解析后的对象
        if (data.success) {
          var user = data.user;
          console.log(user)

          $('#fmEditUser').form('load', {
            userId: user.userId,
            name: user.name,
            email: user.email,
            password: user.password,
            role: user.role,
          });

          $('#dlgEditUser').dialog('open');

          // 您可以在这里添加更多逻辑，比如更新页面上的元素等
        } else {
          console.error("Failed to fetch user data.");
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // 处理请求失败的情况
        console.error("AJAX Error: " + textStatus + ' : ' + errorThrown);
      }
    });
  }

  function updateUser() {
    $('#fmEditUser').form('submit', {
      url: 'updateuser', // 确保这个URL和后端的@RequestMapping相匹配
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

  function delUser(userId) {
    $.messager.confirm('确认删除', '确定要删除这个用户吗？', function (r) {
      if (r) {
        $.ajax({
          url: "${pageContext.request.contextPath}/user/deluser",
          data: { userId: userId },
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