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
</head>
<body>
<div id="sell_bill">
    <div id="sell_bill_head_items">

        <div class="sell_bill_head_item"><span>销售单号：</span><input id="sell_bill_info_billid" type="text"></div>
        <div class="sell_bill_head_item"><span>客户电话：</span><input id="sell_bill_info_customer_phone" type="text"></div>
        <div class="sell_bill_head_item"><span>日期：</span><input id="sell_bill_info_creationtime" type="date"></div>
        <div class="sell_bill_head_item"><span>客户：</span><input id="sell_bill_info_customer" type="text"></div>
    </div>
    <div id="sell_bill_detail_items">
        <div>

        </div>
    </div>
    <div id="sell_bill_foot_items">
        <div class="sell_bill_foot_item"><span>经办人：</span><input id="sell_bill_info_user" type="text"></div>
    </div>
</div>
</body>
</html>
