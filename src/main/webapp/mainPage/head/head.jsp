<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/2/23
  Time: 20:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>之正管理</title>
    <link rel="stylesheet" href="/mainPage/head/head.css" type="text/css"/>
    <script src="/./js/jquery-3.3.1.min.js"></script>
    <script src="/././js/tool.js"></script>
</head>
<body>
<div id="body">
    <div id="content">
        <img class="head_content" id="ITicon" src="/resources/ITicon.png" onclick='window.location.href="/mainPage/guide.jsp"'>
        <div  id="manage_left_box">
            <a class="manage_left_item" href="/mainPage/guide.jsp" id="firstPage">首页</a>
            <a class="manage_left_item" id="user" onmouseover="show_div(1)">人员</a>
            <a class="manage_left_item" id="sell_bill" onmouseover="show_div(2)">销售单</a>
            <a class="manage_left_item" id="purch_bill" onmouseover="show_div(3)">采购单</a>

            <%--<a class="manage_left_item" id="pay_bill" onmouseover="show_div(4)">付款单</a>--%>
            <a class="manage_left_item" id="fahuo_bill" onmouseover="show_div(5)">发货单</a>
            <a class="manage_left_item" id="earn_bill" onmouseover="show_div(6)">收款单</a>
        </div>
        <div class="function_box" id="user_div" hidden="hidden">
            <a href="/mainPage/content/user/serch.jsp">人员查询</a>
            <a href="/mainPage/content/user/add.jsp">人员新增</a>
        </div>
        <div class="function_box" id="sell_bill_div" hidden="hidden">
            <a href="/mainPage/content/sell/add.jsp">销售单新增</a>
            <a href="/mainPage/content/sell/search.jsp">销售单查询</a>
        </div>
        <div class="function_box" id="purch_bill_div" hidden="hidden">
            <a href="/mainPage/content/purch/search.jsp">采购单查询</a>
        </div>
        <div class="function_box" id="pay_bill_div" hidden="hidden">
            <a href="/mainPage/content/pay/search.jsp">付款单查询</a>
        </div>
        <div class="function_box" id="fahuo_bill_div" hidden="hidden">
            <a href="/mainPage/content/fahuo/search.jsp">发货单查询</a>
        </div>
        <div class="function_box" id="earn_bill_div" hidden="hidden">
            <a href="/mainPage/content/earn/search.jsp">收款单查询</a>
        </div>
        <div  id="login_right_box">
            <a href="" id="user_center_a"></a>
            <span>欢迎 </span><a href="/" id="user_info"></a>
            <span>|</span><a href="/Logout" id="logout_a">注销</a>
        </div>
    </div>

</div>
<script>
    $("#user_div").mouseleave(hideen_all);
    $("#sell_bill_div").mouseleave(hideen_all);
    $("#purch_bill_div").mouseleave(hideen_all);
    $("#pay_bill_div").mouseleave(hideen_all);
    $("#fahuo_bill_div").mouseleave(hideen_all);
    $("#earn_bill_div").mouseleave(hideen_all);
    function hideen_all() {
        if(!$("#user_div").prop("hidden")){
            $("#user_div").prop("hidden",true);
        }
        if(!$("#sell_bill_div").prop("hidden")){
            $("#sell_bill_div").prop("hidden",true);
        }
        if(!$("#purch_bill_div").prop("hidden")){
            $("#purch_bill_div").prop("hidden",true);
        }
        if(!$("#pay_bill_div").prop("hidden")){
            $("#pay_bill_div").prop("hidden",true);
        }
        if(!$("#fahuo_bill_div").prop("hidden")){
            $("#fahuo_bill_div").prop("hidden",true);
        }
        if(!$("#earn_bill_div").prop("hidden")){
            $("#earn_bill_div").prop("hidden",true);
        }
    }
    function show_div(flag) {
        hideen_all();
        if(flag==1){
            document.getElementById("user_div").hidden = false;
        }else if(flag==2){
            document.getElementById("sell_bill_div").hidden = false;
        }else if(flag==3){
            document.getElementById("purch_bill_div").hidden = false;
        }else if(flag==4){
            document.getElementById("pay_bill_div").hidden = false;
        }else if(flag==5){
            document.getElementById("fahuo_bill_div").hidden = false;
        }else if(flag==6){
            document.getElementById("earn_bill_div").hidden = false;
        }
    }


    document.getElementById("user_info").innerText = decodeURIComponent(getCookie("user_job"))+":"+decodeURIComponent(getCookie("user_name"));
</script>

</body>
</html>
