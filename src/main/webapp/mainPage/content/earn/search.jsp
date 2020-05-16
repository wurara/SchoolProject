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
    <title>search</title>
    <link rel="stylesheet" href="/./mainPage/content/earn/css/search.css">
</head>
<body>
<div id="earn_bill_div_info">
    <div id="earn_bill_head_items">
        <div class="earn_bill_head_item"><span>客户名称：</span><input id="earn_bill_info_customer" type="text"></div>
        <div class="earn_bill_head_item" id="earn_bill_info_billid_div"><span>收款单号：</span><input id="earn_bill_info_billid" type="text"></div>
        <div class="earn_bill_head_item" id="earn_bill_info_earn_flag_div"><span>付款标识：</span><input
                id="earn_bill_info_earn_flag" type="text"></div>
        <br>
        <div class="earn_bill_head_item"><span>客户电话：</span><input id="earn_bill_info_customer_phone" type="text"></div>
        <div class="earn_bill_head_item" id="earn_bill_info_pk_from_div"><span>来源单号：</span><input id="earn_bill_info_pk_from" type="text"></div>
        <div class="earn_bill_foot_item" id="commit_button"><input id="earn_bill_info_search" value="查询" type="button">
        </div>
    </div>
    <div id="earn_bill_detail_items">
        <table id="earn_bill_detail_items_table" frame="border" rules="all" cellpadding="50" width="80%">
            <tr class="earn_bill_detail_items_table_tr" id="infoTr">
                <td class="earn_bill_detail_items_table_td">收款单号</td>
                <td class="earn_bill_detail_items_table_td">来源单号</td>
                <td class="earn_bill_detail_items_table_td">客户名称</td>
                <td class="earn_bill_detail_items_table_td">客户电话</td>
                <td class="earn_bill_detail_items_table_td">付款标识</td>
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
        document.getElementById("earn_bill_info_search").click()
    }

    document.getElementById("earn_bill_info_search").onclick = function (ev) {
        var info ={
            customer:document.getElementById("earn_bill_info_customer").value,
            billID: document.getElementById("earn_bill_info_billid").value,
            customer_phone:document.getElementById("earn_bill_info_customer_phone").value,
            earn_flag :document.getElementById("earn_bill_info_earn_flag").value,
            pk_from:document.getElementById("earn_bill_info_pk_from").value
        }
        xmlhttp.open("GET", "/EarnBillSearch?json="+JSON.stringify(info), true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var infoTr = document.getElementById("infoTr");
                document.getElementById("earn_bill_detail_items_table").innerHTML = "";
                document.getElementById("earn_bill_detail_items_table").appendChild(infoTr);
                var head = JSON.parse(xmlhttp.responseText);
                for(var i = 0;i<head.length;i++){
                    var tr = document.createElement("tr");
                    tr.setAttribute("id","tr_"+i);
                    tr.setAttribute("info",head[i].PK_EARN)

                    var td0= document.createElement("td");
                    td0.setAttribute("id","billID_"+i);
                    td0.innerText = head[i].PK_EARN
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
                    if(head[i].EARN_FLAG=="0"){
                        td5.innerText = "未付款"
                    }else {
                        td5.innerText = "已付款"
                    }
                    tr.appendChild(td5);
                    //确认付款按钮
                    var td6= document.createElement("td");
                    var tempImput = document.createElement("input");
                    tempImput.setAttribute("id","tempInput");
                    tempImput.setAttribute("type","button");
                    if(head[i].EARN_FLAG!="0"){
                        tempImput.setAttribute("disabled",false);
                    }
                    tempImput.setAttribute("value","确认付款");
                    tempImput.setAttribute("style","width:80px");
                    tempImput.setAttribute("onclick","commit_money(\""+head[i].PK_EARN+"\")");
                    td6.setAttribute("style","width:100px")
                    td6.setAttribute("id","update_input_"+i);
                    td6.appendChild(tempImput)
                    tr.appendChild(td6);

                    document.getElementById("earn_bill_detail_items_table").appendChild(tr);
                }
            }
        }
    }
function commit_money(billID) {
    console.log(billID)
    xmlhttp.open("GET", "/SureMoney?billID="+billID, true);
    xmlhttp.send();
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            if(xmlhttp.responseText=="1"){
                alert("确认收款成功");
                location.reload()
            }
        }
    }
}

</script>
</body>
</html>
