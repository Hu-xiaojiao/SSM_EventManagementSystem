<%-- Created by IntelliJ IDEA. User: Huxiaojiao Date: 2024/12/15 Time: 22:44 To change this template use File | Settings
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

        <style>
            html,
            body {
                width: 100%;
                height: 100vh;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                background-image: url("${pageContext.request.contextPath}/js/bg.jpg");
                background-position: center center;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }

            h1, h4 {
                color: rgb(80, 80, 80);
                /*text-align: center;*/
            }

            a:link,
            a:hover,
            a:visited,
            a:active {
                color: rgb(128, 128, 128);
                text-decoration: none;
            }

            .form {
                width: 400px;
                min-width: 400px;
                position: absolute;
                padding: 30px;
                background-color: rgba(255, 255, 255, 0.7);
                border: 2px solid rgba(128, 128, 128, 0.2);
                border-radius: 10px;
            }

            form div {
                margin-bottom: 10px;
            }
        </style>

        <body>
            <div class="form">
                <form action="${pageContext.request.contextPath}/user/login" id="loginform">
                    <div>
                        <h1>活动管理审批系统</h1>
                        <h4>| 用户登录</h4>
                        <hr>
                        <span style="color: red">${msg}</span>
                    </div>
                    <div>
                        <input class="easyui-textbox"
                               data-options="iconCls:'icon-man',iconWidth:30,iconAlign:'left',prompt:'用户名'"
                               style="width:100%;height:35px;" name="name" />
                    </div>
                    <div>
                        <input class="easyui-passwordbox"  data-options="iconAlign:'left',prompt:'密码'"
                               style="width:100%;height:35px;" name="password" />
                    </div>
                    <br>
                    <div>
                        <input class="easyui-linkbutton" type="submit" value="登陆" style="width:100%;height:35px;"
                               href='javascript:document:loginform.submit();' />
                    </div>
                </form>
            </div>
        </body>

        </html>