<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/2/19
  Time: 23:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        //获取当前页面制定的cookie
        function getCookie(cookieName) {
            var strCookie = document.cookie;
            var arrCookie = strCookie.split("; ");
            for(var i = 0; i < arrCookie.length; i++){
                var arr = arrCookie[i].split("=");
                if(cookieName == arr[0]){
                    return arr[1];
                }
            }
            return "";
        }
        //设置回车键登录
        function keyLogin(){
            if (event.keyCode==13)  //回车键的键值为13
                document.getElementById("login-button").click();//调用登录按钮的登录事件
        }
    </script>
    <title>之正管理</title>
    <link rel="stylesheet" href="/css/index.css" type="text/css"/>
    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/tool.js"></script>
</head>
<body onkeydown="keyLogin()">
<div id="content">
    <div id="background-div"></div>
    <div id="float-box">
        <div id="login-box">
            <div id="login-text">欢迎使用之正管理</div>
            <div id="login_form">
                <form>
                    <div class="login-content"><img class="login-icon" src="/resources/icon/usercode.png" alt="">
                        <input class="login-info" id="usercode" name="usercode" type="text" autocomplete="off"
                               placeholder="用户名或手机号">
                    </div>

                    <div class="login-content" style="margin-top: -1px"<%--去除重复边框--%>><img class="login-icon"
                                                                                           src="/resources/icon/password.png"
                                                                                           alt="">
                        <input class="login-info" id="password" name="pwd" 0 type="password" autocomplete="off"
                               placeholder="密  码">
                    </div>

                    <div><input id="login-button" type="button" value="登  录"></div>
                    <div id="return-msg" style="color: red;"></div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    //如果已经登录就到主页面
    if(getCookie("token")!=""){
        window.location.href = "/mainPage/guide.jsp";
    }
    //设置背景的大小
    var background = $("#background-div");
    background.css("background", "url(\"/resources/bg.jpg\")");
    background.css("width", window.innerWidth);
    background.css("height", window.innerHeight);
    background.css("background-size", "100% 100%");
    //处理表单提交事件
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    document.getElementById("login-button").onclick = function (ev) {
        //判断账号密码不为空
        if($("#usercode").val()==""){
            $("#usercode").attr("placeholder","请输入账号或手机号");
        }
        else if($("#password").val()==""){
            $("#password").attr("placeholder","请输入密码");
        }
        else{
            //ajax提交请求查询密码
            xmlhttp.open("GET", "/Login?usercode=" + $("#usercode").val() + "&pwd=" + $("#password").val(), true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function()
            {
                if (xmlhttp.readyState==4 && xmlhttp.status==200)
                {   //解析返回的json
                    var json = JSON.parse(xmlhttp.responseText);
                    if(json.flag == "1"){
                        //显示错误信息
                        document.getElementById("return-msg").innerText = json.msg;
                        $("#return-msg").shake(2,5,200);
                    }else {
                        //跳转主页
                        document.getElementById("return-msg").innerText="";
                        document.cookie = "token="+json.msg;
                        document.cookie = "user_name="+encodeURIComponent(json.user_name);
                        document.cookie = "user_job="+encodeURIComponent(json.user_job);
                        window.location.href = "/mainPage/guide.jsp";
                    }
                }
            }
        }
    }
</script>
</body>
</html>
