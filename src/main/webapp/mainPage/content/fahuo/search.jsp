<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/3/27
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/mainPage/head/head.jsp" flush="true"/>
<html>
<head>
    <title>发货单查询</title>
    <link rel="stylesheet" href="/mainPage/content/fahuo/css/search.css">
    <script src="/./js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div id="fahuo_bill_div_info">
    <div id="fahuo_bill_head_items">
        <div class="fahuo_bill_head_item"><span>客户名称：</span><input id="fahuo_bill_info_customer" type="text"></div>
        <div class="fahuo_bill_head_item" id="fahuo_bill_info_billid_div"><span>发货单号：</span><input id="fahuo_bill_info_billid" type="text"></div>
        <div class="fahuo_bill_head_item"><span>客户电话：</span><input id="fahuo_bill_info_customer_phone" type="text"></div>
        <br>
        <div class="fahuo_bill_head_item"><span>收货地址：</span><input id="fahuo_bill_info_address" type="text"></div>
        <div class="fahuo_bill_head_item" id="fahuo_bill_info_fahuo_date_div"><span>发货日期：</span><input
                id="fahuo_bill_info_fahuo_date" type="text"></div>
        <div class="fahuo_bill_head_item" id="fahuo_bill_info_checker_div"><span>发货人：&nbsp&nbsp</span><input id="fahuo_bill_info_checker" type="text"></div>
        <br>
        <div class="fahuo_bill_head_item" id="fahuo_bill_info_pk_from_div"><span>来源单号：</span><input id="fahuo_bill_info_pk_from" type="text"></div>
        <div class="fahuo_bill_foot_item" id="commit_button"><input id="fahuo_bill_info_search" value="查询" type="button">
        </div>
    </div>
    <div id="fahuo_bill_detail_items">
        <table id="fahuo_bill_detail_items_table" frame="border" rules="all" cellpadding="50" width="80%">
            <tr class="fahuo_bill_detail_items_table_tr" id="infoTr">
                <td class="fahuo_bill_detail_items_table_td">单据号</td>
                <td class="fahuo_bill_detail_items_table_td">来源单号</td>
                <td class="fahuo_bill_detail_items_table_td">客户名称</td>
                <td class="fahuo_bill_detail_items_table_td">客户电话</td>
                <td class="fahuo_bill_detail_items_table_td">收货地址</td>
                <td class="fahuo_bill_detail_items_table_td">发货日期</td>
                <td class="fahuo_bill_detail_items_table_td">发货人</td>
            </tr>
        </table>
    </div>
</div>
<script>
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    window.onload = function (ev) {
        document.getElementById("fahuo_bill_info_search").click()
    }

    document.getElementById("fahuo_bill_info_search").onclick = function (ev) {
        var info ={
            customer:document.getElementById("fahuo_bill_info_customer").value,
            billID: document.getElementById("fahuo_bill_info_billid").value,
            customer_phone:document.getElementById("fahuo_bill_info_customer_phone").value,
            address: document.getElementById("fahuo_bill_info_address").value,
            check_time :document.getElementById("fahuo_bill_info_fahuo_date").value,
            checker: document.getElementById("fahuo_bill_info_checker").value,
            pk_from:document.getElementById("fahuo_bill_info_pk_from").value
        }
        xmlhttp.open("GET", "/FaBillSearch?info="+JSON.stringify(info), true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var infoTr = document.getElementById("infoTr");
                document.getElementById("fahuo_bill_detail_items_table").innerHTML = "";
                document.getElementById("fahuo_bill_detail_items_table").appendChild(infoTr);

                var head = JSON.parse(xmlhttp.responseText);
                console.log(head);
                for(var i = 0;i<head.length;i++){
                    var tr = document.createElement("tr");
                    tr.setAttribute("id","tr_"+i);
                    tr.setAttribute("info",head[i].PK_FABILL_HEAD)
                    tr.setAttribute("ondblclick","detail()")

                    var td0= document.createElement("td");
                    td0.setAttribute("id","billID_"+i);
                    td0.innerText = head[i].PK_FABILL_HEAD
                    tr.appendChild(td0);

                    var td1= document.createElement("td");
                    td1.setAttribute("id","pk_from_"+i);
                    td1.innerText = head[i].PK_FROM
                    tr.appendChild(td1);

                    var td2= document.createElement("td");
                    td2.setAttribute("id","customer_"+i);
                    td2.innerText = head[i].CUSTOMER
                    tr.appendChild(td2);

                    var td3= document.createElement("td");
                    td3.setAttribute("id","customer_phone_"+i);
                    td3.innerText = head[i].CUSTOMER_PHONE
                    tr.appendChild(td3);

                    var td5= document.createElement("td");
                    td5.setAttribute("id","address_"+i);
                    td5.innerText = head[i].ADDRESS
                    tr.appendChild(td5);

                    var td6= document.createElement("td");
                    td6.setAttribute("id","check_time_"+i);
                    td6.innerText = head[i].CHECK_TIME
                    tr.appendChild(td6);

                    var td7= document.createElement("td");
                    td7.setAttribute("id","bill_checker_"+i);
                    td7.innerText = head[i].BILL_CHECKER
                    tr.appendChild(td7);

                    document.getElementById("fahuo_bill_detail_items_table").appendChild(tr);
                }
            }
        }
    }

    function detail() {
        window.open("/mainPage/content/fahuo/details.jsp?billID="+event.srcElement.parentElement.getAttribute("info"))
    }
</script>
</body>
</html>
