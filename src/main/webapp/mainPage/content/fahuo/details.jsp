<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/5/10
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发货单详情</title>
    <link rel="stylesheet" href="/mainPage/content/fahuo/css/details.css">
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/tool.js"></script>
</head>
<body>
<div id="fahuo_bill_div_info">
    <table id="fahuo_bill_head_items" style="text-align: left;">
        <tr>
            <td>
                <div class="fahuo_bill_head_item"><span>发货单号：</span><span id="fahuo_bill_info_billID" type="text"></span>
                </div>
            </td>
            <td>
                <div class="fahuo_bill_head_item"><span>销售单号：</span><span id="fahuo_bill_info_billfrom"
                                                                          type="text"></span></div>
            </td>
            <td>
                <div class="fahuo_bill_head_item" id="fahuo_bill_info_customer_div"><span>客户名称：</span><span
                        id="fahuo_bill_info_customer"></span></div>
            </td>
            <td>
                <div class="fahuo_bill_head_item" id="fahuo_bill_info_customer_phone_div"><span>客户电话：</span><span
                        id="fahuo_bill_info_customer_phone"></span></div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="fahuo_bill_head_item" id="fahuo_bill_info_address_div"><span>收货地址：</span><span
                        id="fahuo_bill_info_address"></span></div>
            </td>
            <td>
                <div class="fahuo_bill_head_item" id="fahuo_bill_info_fahuo_date_div"><span>发货日期：</span><span
                        id="fahuo_bill_info_fahuo_date"></span></div>
            </td>
            <td>
                <div class="fahuo_bill_head_item" id="fahuo_bill_info_fahuoer_div"><span>发货人：</span><span
                        id="fahuo_bill_info_fahuoer"></span></div>
            </td>
    </table>
    <div id="fahuo_bill_detail_items">
        <table id="fahuo_bill_detail_items_table" frame="border" rules="all" width="80%">
            <tr class="fahuo_bill_detail_items_table_tr">
                <td class="fahuo_bill_detail_items_table_td">序号</td>
                <td class="fahuo_bill_detail_items_table_td">名称</td>
                <td class="fahuo_bill_detail_items_table_td">数量</td>
                <td class="fahuo_bill_detail_items_table_td">单位</td>
                <td class="fahuo_bill_detail_items_table_td">单价</td>
                <td class="fahuo_bill_detail_items_table_td">备注</td>
            </tr>
        </table>
    </div>
    <div class="fahuo_bill_foot_item" id="commit_button"><input id="fahuo_bill_info_check_button" value="发货"
                                                                type="button" >
    </div>
    <div id="fahuo_bill_foot_items">
    </div>
</div>
</body>
<script>
    var detail_json = "";

    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    window.onload = function (ev) {
        xmlhttp.open("GET", "/GetFahuoBillDetail?billID=<%= request.getParameter("billID")%>", true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var json = JSON.parse(xmlhttp.responseText);
                detail_json = xmlhttp.responseText;
                console.log(json)
                document.getElementById("fahuo_bill_info_billID").innerText= json.PK_FABILL_HEAD;
                document.getElementById("fahuo_bill_info_billfrom").innerText= json.PK_FROM;
                document.getElementById("fahuo_bill_info_customer").innerText= json.CUSTOMER;
                document.getElementById("fahuo_bill_info_customer_phone").innerText= json.CUSTOMER_PHONE;
                document.getElementById("fahuo_bill_info_address").innerText= json.ADDRESS;
                document.getElementById("fahuo_bill_info_fahuo_date").innerText= json.CHECK_TIME;
                document.getElementById("fahuo_bill_info_fahuoer").innerText= json.BILL_CHECKER;
                if(json.BILL_CHECKER!=""){
                    document.getElementById("fahuo_bill_info_check_button").setAttribute("disabled",false);
                }
                var body = json.body;

                for(var i=0;i<body.length;i++){
                    var tr = document.createElement("tr");
                    tr.setAttribute("info",body[i].PK_SALE_HEAD)

                    var td1 = document.createElement("td");
                    td1.setAttribute("id","count_"+i);
                    td1.innerText = i;
                    tr.appendChild(td1);

                    var td2 = document.createElement("td");
                    td2.setAttribute("id","material_name_"+i);
                    td2.innerText = body[i].MATERIAL_NAME;
                    tr.appendChild(td2);

                    var td3 = document.createElement("td");
                    td3.setAttribute("id","detail_num_"+i);
                    td3.innerText = body[i].DETAIL_NUM;
                    tr.appendChild(td3);

                    var td4 = document.createElement("td");
                    td4.setAttribute("id","unit_"+i);
                    td4.innerText = body[i].UNIT;
                    tr.appendChild(td4);

                    var td5 = document.createElement("td");
                    td5.setAttribute("id","price_"+i);
                    td5.innerText = body[i].PRICE;
                    tr.appendChild(td5);

                    var td6 = document.createElement("td");
                    td6.setAttribute("id","note_"+i);
                    td6.innerText = body[i].NOTE;
                    tr.appendChild(td6);

                    document.getElementById("fahuo_bill_detail_items_table").appendChild(tr);
                }
            }
        }
    }
    //付款单审批
    document.getElementById("fahuo_bill_info_check_button").onclick = function (ev) {
        xmlhttp.open("GET", "/FahuoBillCheck?checker="+decodeURIComponent(getCookie("user_name"))+"&billID="+document.getElementById("fahuo_bill_info_billID").innerText, true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                if(xmlhttp.responseText=="1"){
                    //生成收款单
                    xmlhttp.open("GET", "/EarnBillAdd?json="+detail_json, true);
                    xmlhttp.send();
                    xmlhttp.onreadystatechange = function () {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                            if(xmlhttp.responseText!="1"){
                                alert(xmlhttp.responseText);
                            }
                        }
                    }
                    alert("您已确认发货，请当面确认用户付款")
                    document.getElementById("fahuo_bill_info_check_button").setAttribute("disabled",false);
                    location.reload()
                }
            }
        }
    }
</script>
</html>
