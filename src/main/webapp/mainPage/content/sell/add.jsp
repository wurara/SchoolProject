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
    <title>新增销售单</title>
    <script src="/./js/jquery-3.3.1.min.js"></script>
    <script src="/./js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/mainPage/content/sell/css/add.css" type="text/css"/>
</head>
<body>
<div id="sell_bill">
    <div id="sell_bill_head_items">
        <div class="sell_bill_head_item"><span>销售单号：</span><input id="sell_bill_info_billid" type="text"></div>
        <div class="sell_bill_head_item"><span>客户电话：</span><input id="sell_bill_info_customer_phone" type="text"></div>
        <div class="sell_bill_head_item"><span>日期：</span><input id="sell_bill_info_creationtime" type="date"></div>
        <div class="sell_bill_head_item"><span>客户：</span><input id="sell_bill_info_customer" type="text"></div>
        <div class="sell_bill_head_item"><span>总金额：</span><input id="sell_bill_info_all_money" type="text"></div>

    </div>
    <div id="sell_bill_detail_items">
        <table>
            <tr>
                <td>名称</td>
                <td>数量</td>
                <td>单价</td>
                <td>备注</td>
            </tr>
        </table>
    </div>
    <div id="sell_bill_foot_items">
        <div class="sell_bill_foot_item"><span>制单人：</span><input id="sell_bill_info_creator" type="text"></div>
        <div class="sell_bill_foot_item"><span>审批人：</span><input id="sell_bill_info_checker" type="text"></div>
        <div class="sell_bill_foot_item"><span>审批日期：</span><input id="sell_bill_info_check_date" type="text"></div>
    </div>
</div>
</body>
<script>
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    $( "#sell_bill_info_customer" ).autocomplete({
        source: function( request, response ) {
            $("#sell_bill_info_customer").on("compositionend", function () {
                xmlhttp.open("GET", "/AutoCustomerComplete?name="+document.getElementById("sell_bill_info_customer").value, true);
                xmlhttp.send();
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var options = xmlhttp.responseText.split(",");
                        response(options);

                    }
                }
            })
        },
        messages:{
            noResults: "",
            results : function () {}
        }
    });
</script>
</html>
