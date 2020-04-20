<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2019/4/9
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>请登陆</title>
</head>
<body>
<script>
    if("<%=request.getParameter("before")%>" =="Logout"){
        alert("注销成功");
        window.location.href="/"
    }
    else{
        alert("你还没有登陆，三秒后跳转登陆页面");
        window.location.href="/"
    }
</script>
</body>
</html>
