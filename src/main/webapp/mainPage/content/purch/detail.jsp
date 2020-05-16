<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/5/8
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>采购单详情</title>
    <link rel="stylesheet" href="/mainPage/content/purch/css/detail.css">
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/tool.js"></script>

</head>
<body>
<div id="purch_bill_div_info">
    <table id="purch_bill_head_items" style="text-align: left;">
        <tr>
            <td>
                <div class="purch_bill_head_item"><span>采购单号：</span><span id="purch_bill_info_billID" type="text"></span>
                </div>
            </td>
            <td>
                <div class="purch_bill_head_item"><span>来源单号：</span><span id="purch_bill_info_billfrom"
                                                                         type="text"></span></div>
            </td>
            <td>
                <div class="purch_bill_head_item" id="purch_bill_info_creationtime_div"><span>建表时间：</span><span
                        id="purch_bill_info_creationtime"></span></div>
            </td>
    </table>
    <div id="purch_bill_detail_items">
        <table id="purch_bill_detail_items_table" frame="border" rules="all" width="80%">
            <tr class="purch_bill_detail_items_table_tr">
                <td class="purch_bill_detail_items_table_td">序号</td>
                <td class="purch_bill_detail_items_table_td">名称</td>
                <td class="purch_bill_detail_items_table_td">数量</td>
                <td class="purch_bill_detail_items_table_td">单位</td>
                <td class="purch_bill_detail_items_table_td">单价</td>
                <td class="purch_bill_detail_items_table_td">备注</td>
            </tr>
        </table>
    </div>
    <div class="purch_bill_head_item" id="purch_bill_info_tipinfo_div"><span id="purch_bill_info_tipinfo">请输入商品采购单价</span></div>
    <div class="purch_bill_foot_item" id="commit_button"><input id="purch_bill_info_check_button" value="审批"
                                                               type="button">
    </div>
    <div id="purch_bill_foot_items">
    </div>
</div>
</body>
<script>
    var detail_count = 0;
    var detail_json = "";

    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    window.onload = function (ev) {
        xmlhttp.open("GET", "/GetPurchBillDetail?billID=<%= request.getParameter("billID")%>", true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var json  = JSON.parse(xmlhttp.responseText);
                detail_json = xmlhttp.responseText;
                document.getElementById("purch_bill_info_billID").innerText = json.PK_PURCH_HEAD
                document.getElementById("purch_bill_info_billfrom").innerText = json.PK_FROM
                document.getElementById("purch_bill_info_creationtime").innerText = json.CREATIONTIME
                if(json.BILL_CHECKER!=""){
                    document.getElementById("purch_bill_info_check_button").setAttribute("disabled",false);
                }
                var body = json.body
                for(var i = 0;i<body.length-1;i++){
                    var tr = document.createElement("tr");
                    tr.setAttribute("info",body[i].PK_PURCH_BODY)

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

                    document.getElementById("purch_bill_detail_items_table").appendChild(tr);
                    detail_count++;
                }
            }
        }
    }
    //双击开始修改
    document.getElementById("purch_bill_detail_items_table").ondblclick = function (ev) {
        if(event.srcElement.getAttribute("id").split("_")[0]=="price"||event.srcElement.getAttribute("id").split("_")[0]=="note"){
            if(document.getElementById("tempinput")==null){
                var tempinput = document.createElement("input");
                tempinput.setAttribute("id","tempinput")
                tempinput.setAttribute("type","text");
                tempinput.setAttribute("onblur","commit()");
                tempinput.setAttribute("value",event.srcElement.innerText);
                event.srcElement.innerHTML="";
                event.srcElement.appendChild(tempinput);
                tempinput.focus();
            }
        }
    }
    //失去焦点提交数据
    function commit() {
        var urlparamer = "?billID="+event.srcElement.parentElement.parentElement.getAttribute("info");
        if(event.srcElement.parentElement.getAttribute("id").split("_")[0]=="price"){
            urlparamer += "&name=PRICE";
        }else {
            urlparamer += "&name=NOTE";
        }
        urlparamer += "&info="+event.srcElement.value;
        xmlhttp.open("GET", "/PurchDetailUpdate"+urlparamer, true);
        event.srcElement.parentElement.innerHTML = event.srcElement.value;
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                changeTip("修改成功")
            }
        }
    }
    //点击审批
    document.getElementById("purch_bill_info_check_button").onclick =function (ev) {
        var flag = true;
        for(var i=0;i<detail_count;i++){
            if(document.getElementById("price_"+i).innerText==""){
                flag=false;
            }
        }
        if(flag==false){
            changeTip("请输入所有物料的采购金额后审批")
        }else {
            var money=0;
            for(var i =0;i<detail_count;i++){

                money += (document.getElementById("detail_num_"+i).innerText*document.getElementById("price_"+i).innerText)
            }
            xmlhttp.open("GET", "/PurchBillCheck?checker="+decodeURIComponent(getCookie("user_name"))+"&money="+ money+"&billID="+document.getElementById("purch_bill_info_billID").innerText, true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if(xmlhttp.responseText=="1"){
                        changeTip("审批成功")
                        document.getElementById("purch_bill_info_check_button").setAttribute("disabled",false);
                    }
                }
            }
        }
    }

    function changeTip(message) {
        document.getElementById("purch_bill_info_tipinfo").innerText = message
        setTimeout(function () {
            document.getElementById("purch_bill_info_tipinfo").innerText = "请输入商品采购单价";
        }, 1000);
    }
</script>
</html>
