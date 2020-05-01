<%--
  Created by IntelliJ IDEA.
  User: wuxia
  Date: 2020/3/26
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/mainPage/head/head.jsp" flush="true"/>
<html>
<head>
    <title>人员查询</title>
    <link rel="stylesheet" href="/mainPage/content/user/css/search.css">
</head>
<body>
<div>
    <div id="search_box" >
        <div class="search_item"><span>姓名：&nbsp&nbsp</span><input id="user_info_name" type="text"></div>
        <div class="search_item" id="user_info_sex"><span>性别：&nbsp&nbsp&nbsp</span>
            <select id="sex_select">
                <option value=""></option>
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>
        <div class="search_item"><span>生日：&nbsp</span><input id="user_info_birday" type="date"></div>
        <div class="search_item" id="user_info_blood"><span>&nbsp血型：&nbsp</span>
            <select id="blood_select">
                <option value=""></option>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="AB">AB</option>
                <option value="O">O</option>
            </select>
        </div>
        <div class="search_item"><span>电话：&nbsp&nbsp</span><input id="user_info_phone" type="text"></div>
        <br>
        <div class="search_item"><span>学校：&nbsp&nbsp</span><input id="user_info_school" type="text"></div>
        <div class="search_item" id="user_info_dept"><span>部门：&nbsp&nbsp&nbsp</span>
            <select id="dept_select"></select>
        </div>
        <div class="search_item" id="user_info_job"><span>职位：</span>
            <select id="job_select"></select>
        </div>

        <div class="search_item" id="user_info_edu"><span>&nbsp学历：&nbsp</span>
            <select id="edu_select">
                <option value=""></option>
                <option value="大专">大专</option>
                <option value="本科">本科</option>
                <option value="硕士">硕士</option>
                <option value="博士">博士</option>
                <option value="博士后">博士后</option>
            </select>
        </div>
        <div class="search_item"><span>身份证：</span><input id="user_info_id" type="text"></div>
        <br>
        <div class="search_item"><span>创建人：</span><input id="user_info_creator" type="text"></div>
        <div class="search_item"><span>创建时间：</span><input id="user_info_creationtime" type="date"></div>
        <div class="search_item" id="user_info_psntype"><span> 人员类别：</span>
            <select id="psntype_select">
                <option value="01">用户</option>
                <option value="02">客户</option>
            </select>
        </div>
        <div class="search_button"><span id="tip">双击数据可修改数据，点击其他地方提交修改</span></div>
        <div class="search_button"><input type="button" value="查询" id="search_button"></div>
        <div class="search_button"><input type="button" value="清空" id="clear_button"></div>
    </div>
</div>
<div>
    <div id="show_box">
        <div id="show_head">
            <table id="show_head_table" frame="border" rules="all" cellpadding="5" width="80%">

            </table>
        </div>
        <div id="show_body">
            <table id="show_body_table" frame="border" rules="all" cellpadding="50" width="80%">
            </table>
        </div>
    </div>
</div>
<script>
    //获取页面上的提示文本
    var tip = document.getElementById("tip");
    //页面上成功与否的全局标志
    var allFlag = 0;
    //创建ajax对象
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //查询有多少部门
    window.onload = function (ev) {
        document.getElementById("show_body_table").innerHTML = "<tr><td>名称</td><td>性别</td><td>部门</td><td>职位</td><td>电话</td><td>学位</td><td>学校</td><td>生日</td><td>身份证</td><td>血型</td><td>创建人</td><td>创建时间</td></tr>"
        //ajax提交请求查询密码
        xmlhttp.open("GET", "/dept_select", true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {   //解析返回的json
                var job_select = document.getElementById("dept_select");
                var jsonArray = JSON.parse(xmlhttp.responseText);
                var node = document.createElement("option");
                node.innerText = "";
                node.value = "";
                job_select.appendChild(node);
                for (var i = 0; i < jsonArray.length - 1; i++) {
                    var node = document.createElement("option");
                    node.innerText = jsonArray[i].DEPTNAME;
                    node.value = jsonArray[i].CODE;
                    job_select.appendChild(node);
                }
            }
        }
    }

    //查询部门的职位
    document.getElementById("dept_select").onmouseup = function () {
        var job_select = document.getElementById("job_select");
        //清空select中的option
        job_select.innerHTML = "";
        //ajax提交请求查询信息
        xmlhttp.open("GET", "/job_select?code=" + document.getElementById("dept_select").value, true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {   //解析返回的json
                var jsonArray = JSON.parse(xmlhttp.responseText);
                {
                    var node = document.createElement("option");
                    node.innerText = "";
                    node.value = "";
                    job_select.appendChild(node);
                }
                for (var i = 0; i < jsonArray.length - 1; i++) {
                    var node = document.createElement("option");
                    node.innerText = jsonArray[i].NAME;
                    node.value = jsonArray[i].CODE;
                    job_select.appendChild(node);
                }
            }
        }
    }


    //设置查询按钮功能，提交json字符串格式的数据
    document.getElementById("search_button").onclick = function (ev1) {
        var showBody = document.getElementById("show_body_table");
        showBody.innerHTML = "";
        document.getElementById("show_body_table").innerHTML = "<tr><td>名称</td><td>性别</td><td>部门</td><td>职位</td><td>电话</td><td>学位</td><td>学校</td><td>生日</td><td>身份证</td><td>血型</td><td>创建人</td><td>创建时间</td></tr>"
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
            "CREATOR": document.getElementById("user_info_creator").value,
            "CREATIONTIME": document.getElementById("user_info_creationtime").value,
            "PSNTYPE":document.getElementById("psntype_select").value
        }
        xmlhttp.open("GET", "/psndoc_search?json=" + JSON.stringify(json), true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var jsonArray = JSON.parse(xmlhttp.responseText);
                for (var i = 0; i < jsonArray.length - 1; i++) {
                    var tr = document.createElement("tr");
                    tr.setAttribute("id",jsonArray[i].ID);
                    tr.setAttribute("info",jsonArray[i].DEPTNAME);


                    var td1 = document.createElement("td");
                    td1.innerHTML = jsonArray[i].NAME
                    td1.setAttribute("name","NAME");
                    tr.appendChild(td1);

                    var td2 = document.createElement("td");
                    td2.innerHTML = jsonArray[i].SEX
                    td2.setAttribute("name","SEX");
                    tr.appendChild(td2);

                    var td3 = document.createElement("td");
                    td3.innerHTML = jsonArray[i].DEPTNAME
                    td3.setAttribute("name","DEPTNAME");
                    tr.appendChild(td3);

                    var td4 = document.createElement("td");
                    td4.innerHTML = jsonArray[i].JOB_NAME
                    td4.setAttribute("name","JOB_NAME");
                    tr.appendChild(td4);

                    var td03 = document.createElement("td");
                    td03.innerHTML = jsonArray[i].PHONE
                    td03.setAttribute("name","PHONE");
                    tr.appendChild(td03);

                    var td5 = document.createElement("td");
                    td5.innerHTML = jsonArray[i].EDU
                    td5.setAttribute("name","EDU");
                    tr.appendChild(td5);

                    var td6 = document.createElement("td");
                    td6.innerHTML = jsonArray[i].SCHOOL
                    td6.setAttribute("name","SCHOOL");
                    tr.appendChild(td6);

                    var td9 = document.createElement("td");
                    td9.innerHTML = jsonArray[i].BIRTHDATE
                    td9.setAttribute("name","BIRTHDATE");
                    tr.appendChild(td9);

                    var td10 = document.createElement("td");
                    td10.innerHTML = jsonArray[i].ID
                    td10.setAttribute("name","ID");
                    tr.appendChild(td10);

                    var td11 = document.createElement("td");
                    td11.innerHTML = jsonArray[i].BLOODTYPE
                    td11.setAttribute("name","BLOODTYPE");
                    tr.appendChild(td11);

                    var td7 = document.createElement("td");
                    td7.innerHTML = jsonArray[i].CREATOR
                    td7.setAttribute("name","CREATOR");
                    tr.appendChild(td7);

                    var td8 = document.createElement("td");
                    td8.innerHTML = jsonArray[i].CREATIONTIME
                    td8.setAttribute("name","CREATIONTIME");
                    tr.appendChild(td8);

                    var td08 = document.createElement("td");
                    var delete_button = document.createElement("input");
                    delete_button.setAttribute("id","delete_button");
                    delete_button.setAttribute("type","button");
                    delete_button.setAttribute("value","删除");
                    delete_button.setAttribute("onclick","deleteInfo(\""+ jsonArray[i].ID+"\")");
                    td08.appendChild(delete_button);
                    tr.appendChild(td08);

                    showBody.appendChild(tr);
                }
            }
        }
    }

    //设置删除按钮功能
    function deleteInfo(ID) {
        var certain= confirm("是否删除身份证为"+ID+"的用户");
        if(certain==true){
            xmlhttp.open("GET", "/psndoc_delete?ID=" + ID, true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if(xmlhttp.responseText=="1"){
                        alert("删除成功");
                        $("#search_button").click();
                    }else{
                        alert("删除失败");
                    }
                }
            }
        }
    }


    //设置清空按钮功能
    document.getElementById("clear_button").onclick = function (ev) {
        document.getElementById("user_info_name").value = "";
        document.getElementById("user_info_birday").value = "";
        document.getElementById("blood_select").value = "";
        document.getElementById("dept_select").value = "";
        document.getElementById("edu_select").value = "";
        document.getElementById("user_info_id").value = "";
        document.getElementById("job_select").value = "";
        document.getElementById("user_info_phone").value = "";
        document.getElementById("sex_select").value = "";
        document.getElementById("user_info_school").value = "";
        document.getElementById("user_info_creator").value = "";
        document.getElementById("user_info_creationtime").value = "";
    }

    //设置点击内容时变成编辑内容
    document.getElementById("show_body_table").ondblclick =function (ev) {
        //获取被点击的数据
        var node = event.srcElement;
        //获取被点击的td
        var fatherNode = node.parentElement;
        //保存旧信息
        var text =node.innerText;
        //获取要修改的字段名
        var name =node.getAttribute("name");
        node.innerHTML="";
        //如果是输入类的则创建输入框
        if(name=="NAME"||name=="PHONE"||name=="SCHOOL"){
            var inputbox = document.createElement("input");
            inputbox.setAttribute("value",text);
            inputbox.setAttribute("oldText",text);
            inputbox.setAttribute("id","info_change_input_box");
            inputbox.setAttribute("uerID",fatherNode.getAttribute("ID"));
            inputbox.setAttribute("onblur","commitChange()")
            node.appendChild(inputbox);
            inputbox.focus();
        }else if(name=="SEX"||name=="DEPTNAME"||name=="JOB_NAME"||name=="EDU"||name=="BOLLDTYPE"){
            //如果是选择类的则创建select节点
            var inputbox = document.createElement("select");
            inputbox.setAttribute("oldText",text);
            inputbox.setAttribute("id","info_change_input_box");
            inputbox.setAttribute("onblur","commitChange()")
            if(name=="SEX"){
                var option1 = document.createElement("option");
                option1.innerText = "男";
                inputbox.appendChild(option1);
                var option2 = document.createElement("option");
                option2.innerText = "女";
                inputbox.appendChild(option2);
                node.appendChild(inputbox);
            }if(name=="EDU"){
                var option1 = document.createElement("option");
                option1.innerText = "大专";
                inputbox.appendChild(option1);

                var option2 = document.createElement("option");
                option2.innerText = "本科";
                inputbox.appendChild(option2);

                var option3 = document.createElement("option");
                option3.innerText = "研究生";
                inputbox.appendChild(option3);

                var option4 = document.createElement("option");
                option4.innerText = "博士生";
                inputbox.appendChild(option4);

                var option5 = document.createElement("option");
                option5.innerText = "博士生后";
                inputbox.appendChild(option5);
            }else if(name=="JOB_NAME"){
                console.log(fatherNode.getAttribute("info"))
                xmlhttp.open("GET", "/QueryAllJobByDeptName?name=" + fatherNode.getAttribute("info"), true);
                xmlhttp.send();
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var tempJson = JSON.parse(xmlhttp.responseText);
                        for(var i=0;i<=tempJson.length-2;i++){
                            var option = document.createElement("option");
                            option.innerText = tempJson[i].NAME;
                            inputbox.appendChild(option);
                        }
                    }
                }
            }else if(name=="BLOODTYPE"){
                var option1 = document.createElement("option");
                option1.innerText = "A";
                inputbox.appendChild(option1);

                var option2 = document.createElement("option");
                option2.innerText = "B";
                inputbox.appendChild(option2);

                var option3 = document.createElement("option");
                option3.innerText = "AB";
                inputbox.appendChild(option3);

                var option4 = document.createElement("option");
                option4.innerText = "O";
                inputbox.appendChild(option4);
            }else if(name=="DEPTNAME"){
                xmlhttp.open("GET", "/dept_select", true);
                xmlhttp.send();
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var tempJson = JSON.parse(xmlhttp.responseText);
                        for(var i=0;i<=tempJson.length-2;i++){
                            var option = document.createElement("option");
                            option.innerText = tempJson[i].DEPTNAME;
                            inputbox.appendChild(option);
                        }
                    }
                }
            }
            node.appendChild(inputbox);
            inputbox.focus();
        }else{
            node.innerHTML=text;
            changetip("该项数据无法修改")
        }
    }
    //当输入框失去焦点使提交编辑内容
    function commitChange() {
        var info = document.getElementById("info_change_input_box").value;
        var deptname = document.getElementById("info_change_input_box").parentElement.parentElement.getAttribute("info");
        var name =document.getElementById("info_change_input_box").parentElement.getAttribute("name");
        var old = document.getElementById("info_change_input_box").getAttribute("oldText");
        var psndocID = document.getElementById("info_change_input_box").parentElement.parentElement.getAttribute("id");
        //如果是部门则只改变显示的值，还需要将职位选择后才能存入数据库
        if(name=="DEPTNAME"){
            event.srcElement.parentElement.parentElement.setAttribute("info",info)
            event.srcElement.parentElement.innerHTML = info;
            changetip("还需要更改职位信息")
            return ;
        }
        if(info!=old&&info!=""){
            event.srcElement.parentElement.innerHTML = info;
            xmlhttp.open("GET", "/psndoc_update?name=" + name+"&info="+info+"&psndocID="+psndocID+"&deptName="+deptname, true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText == "success") {
                        changetip("修改成功")
                    }else {
                        changetip(xmlhttp.responseText)
                    }
                }
            }
        }else{
            event.srcElement.parentElement.innerHTML = old;
        }

    }

    function changetip(message) {
        tip.innerText = message;
        setTimeout(function () {
            tip.innerText="双击数据可修改数据，输入框失去焦点提交修改"
        },1000);
    }

</script>
</body>
</html>
