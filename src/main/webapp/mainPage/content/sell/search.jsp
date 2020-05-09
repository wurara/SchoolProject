<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/3/27
  Time: 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/mainPage/head/head.jsp" flush="true"/>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/./mainPage/content/sell/css/search.css">
    <script src="/./js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div id="sell_bill_div_info">
    <div id="sell_bill_head_items">
        <div class="sell_bill_head_item"><span>客户：</span><input id="sell_bill_info_customer" type="text"></div>
        <div class="sell_bill_head_item" id="sell_bill_info_billid_div"><span>单号：</span><input id="sell_bill_info_billid" type="text"></div>
        <div class="sell_bill_head_item"><span>客户电话：</span><input id="sell_bill_info_customer_phone" type="text"></div>
        <br>
        <div class="sell_bill_head_item"><span>地址：</span><input id="sell_bill_info_address" type="text"></div>
        <div class="sell_bill_head_item" id="sell_bill_info_creationtime_div"><span>日期：</span><input
                id="sell_bill_info_creationtime" type="text"></div>
        <div class="sell_bill_head_item" id="sell_bill_info_creator_div"><span>制单人：&nbsp&nbsp</span><input id="sell_bill_info_creator" type="text"></div>
        <br>
        <div class="sell_bill_foot_item" id="commit_button"><input id="sell_bill_info_search" value="查询" type="button">
        </div>
    </div>
    <div id="sell_bill_detail_items">
        <table id="sell_bill_detail_items_table" frame="border" rules="all" cellpadding="50" width="80%">
            <tr class="sell_bill_detail_items_table_tr" >
                <td class="sell_bill_detail_items_table_td">单据号</td>
                <td class="sell_bill_detail_items_table_td">客户名</td>
                <td class="sell_bill_detail_items_table_td">客户电话</td>
                <td class="sell_bill_detail_items_table_td">总金额</td>
                <td class="sell_bill_detail_items_table_td">单据日期</td>
                <td class="sell_bill_detail_items_table_td">制单人</td>
                <td class="sell_bill_detail_items_table_td">地址</td>
                <td class="sell_bill_detail_items_table_td">审批人</td>
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
        document.getElementById("sell_bill_info_search").click();
    }
    //查询按钮点击
    document.getElementById("sell_bill_info_search").onclick =function (ev) {
        var json = {
            "CUSTOMER": document.getElementById("sell_bill_info_customer").value,
            "BILLID": document.getElementById("sell_bill_info_billid").value,
            "CUSTOMER_PHONE": document.getElementById("sell_bill_info_customer_phone").value,
            "ADDRESS": document.getElementById("sell_bill_info_address").value,
            "CREATIONTIME": document.getElementById("sell_bill_info_creationtime").value,
            "CREATOR": document.getElementById("sell_bill_info_creator").value
        }
        xmlhttp.open("GET", "/sale_search?json=" + JSON.stringify(json), true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var jsonarray = JSON.parse(xmlhttp.responseText);
                document.getElementById("sell_bill_detail_items_table").innerHTML = "<tr class=\"sell_bill_detail_items_table_tr\" ><td class=\"sell_bill_detail_items_table_td\">单据号</td><td class=\"sell_bill_detail_items_table_td\">客户名</td><td class=\"sell_bill_detail_items_table_td\">客户电话</td><td class=\"sell_bill_detail_items_table_td\">总金额</td> <td class=\"sell_bill_detail_items_table_td\">单据日期</td> <td class=\"sell_bill_detail_items_table_td\">制单人</td> <td class=\"sell_bill_detail_items_table_td\">地址</td> <td class=\"sell_bill_detail_items_table_td\">审批人</td> </tr>";

                for(var i=0;i<jsonarray.length;i++){
                    var tr = document.createElement("tr");
                    tr.setAttribute("id","tr_"+i);
                    tr.setAttribute("info",jsonarray[i].PK_SALE_HEAD)
                    tr.setAttribute("ondblclick","detail()")

                    var td0= document.createElement("td");
                    td0.setAttribute("id","customer_"+i);
                    td0.innerText = jsonarray[i].PK_SALE_HEAD
                    tr.appendChild(td0);

                    var td1= document.createElement("td");
                    td1.setAttribute("id","customer_"+i);
                    td1.innerText = jsonarray[i].CUSTOMER
                    tr.appendChild(td1);

                    var td2= document.createElement("td");
                    td2.setAttribute("id","customer_phone_"+i);
                    td2.innerText = jsonarray[i].CUSTOMER_PHONE
                    tr.appendChild(td2);

                    var td3= document.createElement("td");
                    td3.setAttribute("id","money_"+i);
                    td3.innerText = jsonarray[i].MONEY
                    tr.appendChild(td3);

                    var td4= document.createElement("td");
                    td4.setAttribute("id","creationtime_"+i);
                    td4.innerText = jsonarray[i].CREATIONTIME
                    tr.appendChild(td4);

                    var td5= document.createElement("td");
                    td5.setAttribute("id","bill_maker_"+i);
                    td5.innerText = jsonarray[i].BILL_MAKER
                    tr.appendChild(td5);

                    var td6= document.createElement("td");
                    td6.setAttribute("id","address_"+i);
                    td6.innerText = jsonarray[i].ADDRESS
                    tr.appendChild(td6);

                    var td7= document.createElement("td");
                    td7.setAttribute("id","bill_checker_"+i);
                    td7.innerText = jsonarray[i].BILL_CHECKER
                    tr.appendChild(td7);

                    document.getElementById("sell_bill_detail_items_table").appendChild(tr);
                }
            }
        }
    }
    function detail() {
        window.open("/mainPage/content/sell/detail.jsp?billID="+event.srcElement.parentElement.getAttribute("info"))
    }
</script>
</body>
</html>
