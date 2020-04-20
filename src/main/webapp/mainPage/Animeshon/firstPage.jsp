<%@ page import="cn.wxd.crawl.BangumiCrawl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2019/4/4
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include   page="/mainPage/head/head.jsp" flush="true"/>
<html>
<head>
    <title>用户菜单</title>
    <link rel="stylesheet" href="/css/firstPage.css" type="text/css"/>
</head>
<body>
<div id="container">

    <%
        List<List<Map<String, Object>>> bangumiList = BangumiCrawl.bangumiCrawl("http://www.anitama.cn/bangumi");
        for (List<Map<String, Object>> bangumi : bangumiList) {
    %>
    <div class="dayBangumi" >
        <p class="date"><%=bangumi.get(0).get("date")+"日"%>
        </p>
        <%
            for (Map weblio : bangumi) {
        %>
        <div class="bangumi">
            <img src=<%=weblio.get("imgSrc")%>>
            <p class="title"><%=weblio.get("title")%>
            </p>
            <p class="placeOuter">国外:<%=weblio.get("place1")%>
            </p>
            <p class="placeInner">国内:<%=weblio.get("place0")%>
            </p>
        </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>

</div>
</body>
</html>
