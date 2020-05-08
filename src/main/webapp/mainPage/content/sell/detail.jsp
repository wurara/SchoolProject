<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/5/2
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>销售单详情</title>
    <script src="/./js/jquery-3.3.1.min.js"></script>
    <script src="/./js/tool.js"></script>
    <link rel="stylesheet" href="/./mainPage/content/sell/css/detail.css">
</head>
<body>
<div id="sell_bill_div_info">
    <table id="sell_bill_head_items" style="text-align: left;">
        <tr>
            <td>
                <div class="sell_bill_head_item"><span>客户：</span><span id="sell_bill_info_customer" type="text"></span>
                </div>
            </td>
            <td>
                <div class="sell_bill_head_item"><span>客户电话：</span><span id="sell_bill_info_customer_phone"
                                                                         type="text"></span></div>
            </td>
            <td>
                <div class="sell_bill_head_item" id="sell_bill_info_billid_div"><span>单号：</span><span
                        id="sell_bill_info_billid"></span></div>
            </td>
            <td>
                <div class="sell_bill_head_item" id="sell_bill_info_creator_div"><span>制单人：</span><span
                        id="sell_bill_info_creator"></span></div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="sell_bill_head_item"><span>地址：</span><span id="sell_bill_info_address" type="text"></span>
                </div>
            </td>
            <td>
                <div class="sell_bill_head_item"><span>总金额：&nbsp&nbsp</span><span id="sell_bill_info_all_money">0</span>
                </div>
            </td>
            <td>
                <div class="sell_bill_head_item" id="sell_bill_info_creationtime_div"><span>日期：</span><span
                        id="sell_bill_info_creationtime"></span></div>
            </td>
            <td>
                <div class="sell_bill_head_item" id="sell_bill_info_checker_div">审批人：<span id="sell_bill_info_checker"
                                                                                           type="button"></span>
                </div>
            </td>
            <td>
                <div class="sell_bill_head_item" id="sell_bill_info_checker_date_div">审批日期：<span
                        id="sell_bill_info_checker_date"
                        type="button"></span>
                </div>
            </td>
        </tr>
    </table>
    <div id="sell_bill_detail_items">
        <table id="sell_bill_detail_items_table" frame="border" rules="all" width="80%">
            <tr class="sell_bill_detail_items_table_tr">
                <td class="sell_bill_detail_items_table_td">序号</td>
                <td class="sell_bill_detail_items_table_td">名称</td>
                <td class="sell_bill_detail_items_table_td">数量</td>
                <td class="sell_bill_detail_items_table_td">单位</td>
                <td class="sell_bill_detail_items_table_td">单价</td>
                <td class="sell_bill_detail_items_table_td">备注</td>
            </tr>
        </table>
    </div>
    <div class="sell_bill_foot_item" id="commit_button"><input id="sell_bill_info_check_button" value="审批"
                                                               type="button">
    </div>
    <div id="sell_bill_foot_items">
    </div>
</div>
<script>
    var json = "";
    var sale_bill_json = "";
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    window.onload = function (ev) {
        xmlhttp.open("GET", "/GetSellBillDetail?billID=" + "<%= request.getParameter("billID")%>", true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                sale_bill_json = JSON.parse(xmlhttp.responseText);
                json = xmlhttp.responseText;
                document.getElementById("sell_bill_info_customer").innerText = sale_bill_json.CUSTOMER;
                document.getElementById("sell_bill_info_customer_phone").innerText = sale_bill_json.CUSTOMER_PHONE;
                document.getElementById("sell_bill_info_billid").innerText = sale_bill_json.PK_SALE_HEAD;
                document.getElementById("sell_bill_info_creator").innerText = sale_bill_json.BILL_MAKER;
                document.getElementById("sell_bill_info_address").innerText = sale_bill_json.ADDRESS;
                document.getElementById("sell_bill_info_all_money").innerText = sale_bill_json.MONEY;
                document.getElementById("sell_bill_info_creationtime").innerText = sale_bill_json.CREATIONTIME;
                document.getElementById("sell_bill_info_checker").innerText = sale_bill_json.BILL_CHECKER;
                document.getElementById("sell_bill_info_checker_date").innerText = sale_bill_json.BILL_CHECK_DATE;
                if (document.getElementById("sell_bill_info_checker").innerText != "") {
                    document.getElementById("sell_bill_info_check_button").setAttribute("disabled", true);
                }

                for (var i = 0; i < sale_bill_json.body.length; i++) {
                    var tr = document.createElement("tr");
                    tr.setAttribute("id", "tr_" + i);
                    tr.setAttribute("info", sale_bill_json.body[i].PK_SALE_BODY)

                    var td1 = document.createElement("td");
                    td1.setAttribute("id", "count_" + i);
                    td1.innerText = (sale_bill_json.body[i].PK_SALE_BODY).charAt(17);
                    tr.appendChild(td1);

                    var td2 = document.createElement("td");
                    td2.setAttribute("id", "material_name_" + i);
                    td2.innerText = sale_bill_json.body[i].MATERIAL_NAME
                    tr.appendChild(td2);

                    var td3 = document.createElement("td");
                    td3.setAttribute("id", "detail_num_" + i);
                    td3.innerText = sale_bill_json.body[i].DETAIL_NUM
                    tr.appendChild(td3);

                    var td4 = document.createElement("td");
                    td4.setAttribute("id", "unit_" + i);
                    td4.innerText = sale_bill_json.body[i].UNIT
                    tr.appendChild(td4);

                    var td5 = document.createElement("td");
                    td5.setAttribute("id", "price_" + i);
                    td5.innerText = sale_bill_json.body[i].PRICE
                    tr.appendChild(td5);

                    var td6 = document.createElement("td");
                    td6.setAttribute("id", "note_" + i);
                    td6.innerText = sale_bill_json.body[i].NOTE
                    tr.appendChild(td6);

                    document.getElementById("sell_bill_detail_items_table").appendChild(tr);
                }
            }
        }
    }

    document.getElementById("sell_bill_info_check_button").onclick = function (ev) {
        var certain = confirm("是否通过<%= request.getParameter("billID")%>的审批");
        if (certain == true) {
            xmlhttp.open("GET", "/SellBillCheck?billID=" + "<%= request.getParameter("billID")%>", true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText == "1") {
                        xmlhttp.open("GET", "/FaBillAdd?json=" + json, true);
                        xmlhttp.send();
                        xmlhttp.onreadystatechange = function () {
                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                if (xmlhttp.responseText == "1") {
                                    document.getElementById("sell_bill_info_check_button").setAttribute("disabled", true);
                                    certain = confirm("发货已自动生成,是否生成采购单？？");
                                    if (certain == true) {
                                        xmlhttp.open("GET", "/PurchAdd?json=" + json, true);
                                        xmlhttp.send();
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                                if(xmlhttp.responseText=="1111"){
                                                    alert("采购单生成成功")
                                                }else {
                                                    alert(xmlhttp.responseText)
                                                }
                                            }
                                        }
                                    }
                                    location.reload();
                                } else {
                                    alert(xmlhttp.responseText);
                                }
                            }
                        }
                    }
                }
            }
        }

    }
</script>
</body>
</html>
