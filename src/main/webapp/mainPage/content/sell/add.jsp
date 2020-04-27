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
<div id="sell_bill_div_info">
    <div id="sell_bill_head_items">
        <div class="sell_bill_head_item"><span>客户：</span><input id="sell_bill_info_customer" type="text"></div>
        <div class="sell_bill_head_item"><span>客户电话：</span><input id="sell_bill_info_customer_phone" type="text"></div>
        <div class="sell_bill_head_item" id="sell_bill_info_billid_div"><span>销售单号：</span><span id="sell_bill_info_billid" type="text"></span></div>
        <div class="sell_bill_head_item" id="sell_bill_info_creationtime_div"><span>日期：</span><span id="sell_bill_info_creationtime" type="date"></span></div>
        <br>
        <div class="sell_bill_head_item"><span>地址：</span><input id="sell_bill_info_address" type="text"></div>
        <div class="sell_bill_head_item"><span>总金额：&nbsp&nbsp</span><input id="sell_bill_info_all_money" type="text"></div>
        <div class="sell_bill_foot_item" id="commit_button"><input id="sell_bill_info_commit" value="提交" type="button"></div>
    </div>
    <div id="sell_bill_detail_items">
        <table id="sell_bill_detail_items_table" frame="border" rules="all" cellpadding="50" width="80%">
            <tr>
                <td>名称</td>
                <td>数量</td>
                <td>单位</td>
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
    //在查询数据库后自动生成销售单号
    window.onload = function (ev) {
        var d = new Date();
        xmlhttp.open("GET", "/GetTableCount?name=SALE_BILL_HEAD", true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById("sell_bill_info_billid").innerText = "xs"+ d.getFullYear()+"0"+(d.getMonth()+1)+d.getDate()+  (Array(4).join(0) + (xmlhttp.responseText+1)).slice(-4);
            }
        }
        document.getElementById("sell_bill_info_creationtime").innerText = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
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
        }
    });
    $("#sell_bill_info_customer").on( "blur", function( event, ui ) {
        xmlhttp.open("GET", "/AutoCustomerPhoneComplete?name="+document.getElementById("sell_bill_info_customer").value, true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var info = JSON.parse(xmlhttp.responseText);
                console.log(info.PHONE)
                if(info.PHONE!=null){
                    document.getElementById("sell_bill_info_customer_phone").value = info.PHONE
                }
            }
        }
    } );
</script>
</html>
