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
    <title>Title</title>
    <link rel="stylesheet" href="/mainPage/content/purch/css/search.css">
</head>
<body>
<div id="purch_bill_div_info">
    <div id="purch_bill_head_items">
        <div class="purch_bill_head_item" id="purch_bill_info_billid_div"><span>采购单号：</span><input id="purch_bill_info_billid" type="text"></div>
        <div class="purch_bill_head_item"><span>来源单号：</span><input id="purch_bill_info_from_billid" type="text"></div>
        <div class="purch_bill_head_item" id="purch_bill_info_creationtime_div"><span>单据日期：</span><input id="purch_bill_info_billdate" type="text"></div>
        <div class="purch_bill_foot_item" id="commit_button"><input id="purch_bill_info_search" value="查询" type="button">
        </div>
    </div>
    <div id="purch_bill_detail_items">
        <table id="purch_bill_detail_items_table" frame="border" rules="all" cellpadding="50" width="80%">
            <tr class="purch_bill_detail_items_table_tr" >
                <td class="purch_bill_detail_items_table_td">采购单据号</td>
                <td class="purch_bill_detail_items_table_td">来源单据号</td>
                <td class="purch_bill_detail_items_table_td">创建日期</td>
                <td class="purch_bill_detail_items_table_td">采购金额</td>
                <td class="purch_bill_detail_items_table_td">备注</td>
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
        document.getElementById("purch_bill_info_search").click();
    }

    document.getElementById("purch_bill_info_search").onclick = function (ev) {
        document.getElementById("purch_bill_detail_items_table").innerHTML="<tr class=\"purch_bill_detail_items_table_tr\" ><td class=\"purch_bill_detail_items_table_td\">采购单据号</td><td class=\"purch_bill_detail_items_table_td\">来源单据号</td><td class=\"purch_bill_detail_items_table_td\">创建日期</td><td class=\"purch_bill_detail_items_table_td\">采购金额</td><td class=\"purch_bill_detail_items_table_td\">备注</td></tr>"
        var json = {
            "billID":document.getElementById("purch_bill_info_billid").value,
            "from":document.getElementById("purch_bill_info_from_billid").value,
            "billDate":document.getElementById("purch_bill_info_billdate").value
        }
        xmlhttp.open("GET", "/PurchSearch?json=" + JSON.stringify(json), true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var json = JSON.parse(xmlhttp.responseText);
                for(var i =0 ;i<json.length;i++){
                    var tr = document.createElement("tr");
                    tr.setAttribute("ondblclick","detail()");
                    tr.setAttribute("info",json[i].PK_PURCH_HEAD);

                    var td1 = document.createElement("td");
                    td1.setAttribute("id","PK_PURCH_HEAD"+i);
                    td1.innerText =json[i].PK_PURCH_HEAD;
                    tr.appendChild(td1);

                    var td2 = document.createElement("td");
                    td2.setAttribute("id","PK_FROM"+i);
                    td2.innerText =json[i].PK_FROM;
                    tr.appendChild(td2);

                    var td4 = document.createElement("td");
                    td4.setAttribute("id","CREATIONTIME"+i);
                    td4.innerText =json[i].CREATIONTIME;
                    tr.appendChild(td4);

                    var td5 = document.createElement("td");
                    td5.setAttribute("id","MONEY"+i);
                    td5.innerText =json[i].MONEY;
                    tr.appendChild(td5);

                    var td6 = document.createElement("td");
                    td6.setAttribute("id","NOTE"+i);
                    td6.innerText =json[i].NOTE;
                    tr.appendChild(td6);

                    document.getElementById("purch_bill_detail_items_table").appendChild(tr);
                }
            }
        }
    }

    function detail() {
        window.open("/mainPage/content/purch/detail.jsp?billID="+event.srcElement.parentElement.getAttribute("info"))
    }

</script>
</body>
</html>
