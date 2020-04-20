<%@ page import="cn.wxd.utils.PropertiesUtils" %><%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2019/3/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="/css/index2.css" type="text/css"/>
    <script src="../js/jquery-3.3.1.min.js"></script>
    <%--<script type="text/javascript"  charset="utf-8"
            src="js/qc_jssdk.js"
            data-appid="APPID"
            data-redirecturi="REDIRECTURI"
    ></script>--%>
</head>
<body>
    <%
        if(request.getCookies()!=null){
            for(Cookie cookie:request.getCookies()){
                if(cookie.getName().equals("token")){
                   response.sendRedirect("/mainPage/guide.jsp");
                }
            }
        }
    %>
    <div id="login_body"></div>
    <div id="login_div">
        <form id="login_form" action="/login" method="post">
            <%
                String usercode = "";
                if (request.getParameter("usercode")!=null){
                    usercode=request.getParameter("usercode");
                }
            %>
            <div><input class="login_info" id="login_code" type="text" name="usercode" value="<%= usercode%>" autocomplete="off"></div>
            <div><input class="login_info" id="login_pwd" type="password" name="password" autocomplete="off"></div>
            <input id="login_submit" type="submit" value="✔✔✔">
        </form>
    </div>
    <script>
        //随机选取背景从index.properties中读取背景数量
        //$("#login_body").css("background",
        //    "url(\"/resources/bg"+Math.ceil(Math.random()*<%=PropertiesUtils.propertiesMapReader("index").get("bgnum")%>)+".jpg\") no-repeat fixed")
        $("#login_body").css("background","url(\"/resources/bg.jpg\") no-repeat scroll")
        //设置登陆框的隐藏
        //$("#login_div").hide();
        //$("#login_body").hide();
        //设置背景大小自适应
        document.getElementById("login_body").style.height = window.innerHeight;
        document.getElementById("login_body").style.width = window.innerWidth;
        //设置登陆框位置
        document.getElementById("login_div").style.left = window.innerWidth*4/5;
        document.getElementById("login_form").style.top = window.innerHeight*2/7;
        //框内提示
        document.getElementById("login_code").placeholder = "用户名"
        document.getElementById("login_pwd").placeholder = "密 码"
    </script>
</body>
</html>