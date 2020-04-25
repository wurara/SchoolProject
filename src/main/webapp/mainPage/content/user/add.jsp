<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/3/27
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/mainPage/head/head.jsp" flush="true"/>
<html>
<head>
    <link rel="stylesheet" href="/mainPage/content/user/css/add.css" type="text/css"/>
    <title>人员入职</title>
</head>
<body>
<div id="information_input_box">
    <div class="add_info_left" ><span>姓名：&nbsp&nbsp</span><input id="user_info_name" type="text" ></div>
    <div class="add_info_right" id="user_info_sex"><span>性别：&nbsp</span>
        <select id="sex_select">
            <option value="男">男</option>
            <option value="女">女</option>
        </select>
    </div>
    <br>
    <div class="add_info_left" ><span>生日：&nbsp&nbsp</span><input id="user_info_birday" type="date" required="required"></div>
    <div class="add_info_right" id="user_info_blood"><span>血型：&nbsp</span>
        <select id="blood_select">
            <option value="A">A</option>
            <option value="B">B</option>
            <option value="AB">AB</option>
            <option value="O">O</option>
        </select>
    </div>
    <br>
    <div class="add_info_left" ><span>电话：&nbsp&nbsp</span><input id="user_info_phone" type="text" required="required"></div>
    <div class="add_info_right" id="user_info_dept"><span>部门：&nbsp</span>
        <select id="dept_select"></select>
    </div>
    <div class="add_info_right" id="user_info_job"><span>职位：</span>
        <select id="job_select"></select>
    </div>
    <br>
    <div class="add_info_left" ><span>学校：&nbsp&nbsp</span><input id="user_info_school" type="text" required="required"></div>
    <div class="add_info_right" id="user_info_edu"><span>学历：&nbsp</span>
        <select id="edu_select">
            <option value="大专">大专</option>
            <option value="本科">本科</option>
            <option value="硕士">硕士</option>
            <option value="博士">博士</option>
            <option value="博士后">博士后</option>
        </select>
    </div>

    <br>
    <div class="add_info_left"><span>身份证：</span><input  id="user_info_id" type="text" required="required"></div>
    <div class="add_info_right" id="user_info_psntype"><span>类别：&nbsp</span>
        <select id="psntype_select">
            <option value="01">用户</option>
            <option value="02">客户</option>
        </select>
    </div>
    <br>
    <div class="add_info"><input type="button" value="确认新增" id="add_button"></div>
</div>
<script>
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //查询有多少部门
    window.onload = function (ev) {
        //ajax提交请求查询部门
        xmlhttp.open("GET", "/dept_select", true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {   //解析返回的json
                var job_select = document.getElementById("dept_select");
                if (!job_select.hasChildNodes()) {
                    var jsonArray = JSON.parse(xmlhttp.responseText);
                    for (var i = 0; i <jsonArray.length-1; i++) {
                        var node = document.createElement("option");

                        node.innerText = jsonArray[i].DEPTNAME;
                        node.value = jsonArray[i].CODE;
                        job_select.appendChild(node);
                    }
                }
            }
        }
    }
    //查询部门的职位
    document.getElementById("dept_select").onmouseup = function () {
        var job_select = document.getElementById("job_select");
        job_select.innerHTML = "";
        //ajax提交请求查询密码
        xmlhttp.open("GET", "/job_select?code=" + document.getElementById("dept_select").value, true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {   //解析返回的json
                var jsonArray = JSON.parse(xmlhttp.responseText);
                for (var i = 0; i < jsonArray.length-1; i++) {
                    var node = document.createElement("option");
                    node.innerText = jsonArray[i].NAME;
                    node.value = jsonArray[i].CODE;
                    job_select.appendChild(node);
                }
            }
        }
    }

    document.getElementById("add_button").onclick = function (ev) {
        //传入后台的数据
        var json = {
            "NAME": document.getElementById("user_info_name").value,
            "BIRDAY": document.getElementById("user_info_birday").value,
            "BLOOD": document.getElementById("blood_select").value,
            "DEPT": document.getElementById("dept_select").value,
            "EDU": document.getElementById("edu_select").value,
            "ID": document.getElementById("user_info_id").value,
            "JOB": document.getElementById("job_select").value,
            "PHONE": document.getElementById("user_info_phone").value,
            "SEX": document.getElementById("sex_select").value,
            "SCHOOL": document.getElementById("user_info_school").value,
            "PSNTYPE" :document.getElementById("psntype_select").value,
        }
        if(json.NAME==""){
            alert("请输入姓名");
        }else if(json.ID==""){
            alert("请输入身份证");
        } else if(json.PHONE==""){
            alert("请输入电话");
        }else if(json.SCHOOL==""){
            alert("请输入学校");
        }else if(json.JOB==""){
            alert("请选择职位");
        }else{
            xmlhttp.open("GET", "/add_psndoc?json=" + JSON.stringify(json), true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {   //解析返回的json
                    if(xmlhttp.responseText=="truetrue"){
                        alert("用户添加成功");
                        document.getElementById("user_info_name").value = "";
                        document.getElementById("user_info_birday").value = "";
                        document.getElementById("user_info_id").value = "";
                        document.getElementById("user_info_phone").value = "";
                        document.getElementById("user_info_school").value = "";
                    }else if(xmlhttp.responseText=="true"){
                        alert("客户添加成功");
                        document.getElementById("user_info_name").value = "";
                        document.getElementById("user_info_birday").value = "";
                        document.getElementById("user_info_id").value = "";
                        document.getElementById("user_info_phone").value = "";
                        document.getElementById("user_info_school").value = "";
                    }else if(xmlhttp.responseText.search("ORA-00001")!=-1){
                        alert(xmlhttp.responseText+"该用户已经注册");
                    }else{
                        alert(xmlhttp.responseText);
                    }
                }
            }
        }

    }
</script>
</body>
</html>
