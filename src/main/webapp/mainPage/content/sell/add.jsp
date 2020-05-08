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
        <div class="sell_bill_head_item" id="sell_bill_info_billid_div"><span>单号：</span><span
                id="sell_bill_info_billid"></span></div>
        <div class="sell_bill_head_item" id="sell_bill_info_creator_div"><span>制单人：</span><span
                id="sell_bill_info_creator"></span></div>
        <br>
        <div class="sell_bill_head_item"><span>地址：</span><input id="sell_bill_info_address" type="text"></div>
        <div class="sell_bill_head_item"><span>总金额：&nbsp&nbsp</span><span id="sell_bill_info_all_money">0</span>
        </div>
        <div class="sell_bill_head_item" id="sell_bill_info_creationtime_div"><span>日期：</span><span
                id="sell_bill_info_creationtime"></span></div>
        <div class="sell_bill_foot_item" id="commit_button"><input id="sell_bill_info_commit" value="提交" type="button">
        </div>
    </div>
    <div id="sell_bill_detail_items">
        <table id="sell_bill_detail_items_table" frame="border" rules="all" cellpadding="50" width="80%">
            <tr class="sell_bill_detail_items_table_tr">
                <td class="sell_bill_detail_items_table_td">序号</td>
                <td class="sell_bill_detail_items_table_td">名称</td>
                <td class="sell_bill_detail_items_table_td">数量</td>
                <td class="sell_bill_detail_items_table_td">单位</td>
                <td class="sell_bill_detail_items_table_td">单价</td>
                <td class="sell_bill_detail_items_table_td">备注</td>
            </tr>
            <tr class="sell_bill_detail_items_table_tr" id="tr_1">
                <td id="count_1"></td>
                <td id="name_1"></td>
                <td id="number_1"></td>
                <td id="unit_1"></td>
                <td id="price_1"></td>
                <td id="note_1"></td>
            </tr>
        </table>
    </div>
    <div id="sell_bill_foot_items">
    </div>
</div>
</body>
<script>
    var ROWCOUNT=0;
    var count = 1;
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //在查询数据库后自动生成销售单号和列表序号
    window.onload = function (ev) {
        var d = new Date();
        var month =0;
        var day =0;
        if(d.getMonth()<10){
            month = "0"+ (d.getMonth()+1);
        }else {
            month= d.getMonth()+1;
        }
        if(d.getDate()<10){
            day = "0"+d.getDate();
        }else {
            day =d.getDate();
        }
        xmlhttp.open("GET", "/GetTableCount?name=SALE_BILL_HEAD", true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById("sell_bill_info_billid").innerText = "xs" + d.getFullYear() + month + day + (Array(4).join(0) + (parseInt(xmlhttp.responseText) + 1)).slice(-4);
                ROWCOUNT=parseInt(xmlhttp.responseText) + 1;
            }
        }
        document.getElementById("sell_bill_info_creationtime").innerText = d.getFullYear() + "-" +month + "-" + day;
        document.getElementById("count_1").innerText = count;
        document.getElementById("sell_bill_info_creator").innerText = decodeURIComponent(getCookie("user_name"));
    }
    //设置客户的填写建议
    $("#sell_bill_info_customer").autocomplete({
        source: function (request, response) {
            $("#sell_bill_info_customer").on("compositionend", function () {
                xmlhttp.open("GET", "/AutoCustomerComplete?name=" + document.getElementById("sell_bill_info_customer").value, true);
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
    //设置自动填写电话
    $("#sell_bill_info_customer").on("blur", function (event, ui) {
        console.log(1)
        xmlhttp.open("GET", "/AutoCustomerPhoneComplete?name=" + document.getElementById("sell_bill_info_customer").value, true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var info = JSON.parse(xmlhttp.responseText);
                if (info.PHONE != null) {
                    document.getElementById("sell_bill_info_customer_phone").value = info.PHONE
                }
            }
        }
    });

    //设置子表单击开始填写
    document.getElementById("sell_bill_detail_items_table").onclick = function (ev) {
        if (document.getElementById("material_input_temp") == null) {
            var tdid = event.srcElement.getAttribute("id").split("_")[0];
            var old = event.srcElement.innerHTML;
            event.srcElement.innerHTML = "";
            //设置序号不可修改
            if (tdid != "count") {
                if (document.getElementById("material_input_temp") == null) {
                    var td = event.srcElement;
                    var input = document.createElement("input")
                    input.value = old;
                    input.setAttribute("id", "material_input_temp");
                    input.setAttribute("onblur", "material_input_temp_onblur()")
                    td.appendChild(input);
                    input.focus();
                }
            }
        }
    }
    //当输入框失去焦点时将数据临时保存在页面上
    function material_input_temp_onblur(ev) {
        var lastTr = document.getElementById("tr_" + count);
        //如果是最后一行，则新增一行
        if (lastTr.getAttribute("id") == event.srcElement.parentElement.parentElement.getAttribute("id")) {
            count++;
            var tr = document.createElement("tr");
            tr.setAttribute("id", "tr_" + count);
            tr.setAttribute("class","sell_bill_detail_items_table_tr")

            var td_count = document.createElement("td");
            td_count.setAttribute("id", "count_" + count);
            td_count.innerText = count;
            tr.appendChild(td_count);

            var td_name = document.createElement("td");
            td_name.setAttribute("id", "name_" + count);
            tr.appendChild(td_name);

            var td_number = document.createElement("td");
            td_number.setAttribute("id", "number_" + count);
            tr.appendChild(td_number);

            var td_unit = document.createElement("td");
            td_unit.setAttribute("id", "unit_" + count);
            tr.appendChild(td_unit);

            var td_price = document.createElement("td");
            td_price.setAttribute("id", "price_" + count);
            tr.appendChild(td_price);

            var td_note = document.createElement("td");
            td_note.setAttribute("id", "note_" + count);
            tr.appendChild(td_note);

            document.getElementById("sell_bill_detail_items_table").appendChild(tr);
        }
        var parentNode =event.srcElement.parentElement;
        event.srcElement.parentElement.innerHTML = event.srcElement.value;
        //如果是金额或者数量修改，则总金额变更
        if (parentNode.getAttribute("id").split("_")[0] == "price"
            || parentNode.getAttribute("id").split("_")[0] == "number") {
            var money = 0;
            var num = 0;
            var price = 0;
            for (var i = 1; i < count - 1; i++) {
                num = document.getElementById("number_" + i).innerText;
                if (num == "") {
                    num = 0;
                }
                price = document.getElementById("price_" + i).innerText;
                if(price == ""){
                    price = 0;
                }
                money =money+(price * num);
            }
            num = document.getElementById("number_" + (count - 1)).innerText;
            if (num == "") {
                num = 0;
            }
            price = document.getElementById("price_" + (count - 1)).innerText;
            money =money+(price * num);
            document.getElementById("sell_bill_info_all_money").innerText = money;
        }

    }
    //提交按钮功能
    document.getElementById("commit_button").onclick = function (ev) {
        var bill = [];
        var head = {
            "CUSTOMER":document.getElementById("sell_bill_info_customer").value,
            "CUSTOMER_PHONE":document.getElementById("sell_bill_info_customer_phone").value,
            "MONEY":document.getElementById("sell_bill_info_all_money").innerText,
            "CREATIONDATE":document.getElementById("sell_bill_info_creationtime").innerText,
            "BILLMAKER":document.getElementById("sell_bill_info_creator").innerText,
            "PK_SALE_HEAD":document.getElementById("sell_bill_info_billid").innerText,
            "ADDRESS":document.getElementById("sell_bill_info_address").value,
            "ROWCOUNT":ROWCOUNT
        }
        bill.push(head);
        var body = [];
        for( var i =1;i<count;i++) {
            var json = {
                "PK_SALE_BODY": document.getElementById("sell_bill_info_billid").innerText + (Array(4).join(0) + (i)).slice(-4),
                "PK_SALE_HEAD": document.getElementById("sell_bill_info_billid").innerText,
                "MATERIAL_NAME":document.getElementById("name_"+i).innerText,
                "NUMBER":document.getElementById("number_"+i).innerText,
                "UNIT":document.getElementById("unit_"+i).innerText,
                "PRICE":document.getElementById("price_"+i).innerText,
                "NOTE":document.getElementById("note_"+i).innerText,
                "MONEY":document.getElementById("price_"+i).innerText*document.getElementById("number_"+i).innerText
        }
        body.push(json)
        }
        bill.push(body);
        xmlhttp.open("GET", "/sell_add?json=" + JSON.stringify(bill).toString(), true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                console.log(xmlhttp.responseText)
                if(xmlhttp.responseText=="SUCCESS"){
                    alert("新增销售单成功");
                    location.reload();
                }else {
                    alert("新增失败,原因:"+xmlhttp.responseText);
                }
            }
        }
    }

</script>
</html>
