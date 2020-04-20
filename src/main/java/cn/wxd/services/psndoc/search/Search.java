package cn.wxd.services.psndoc.search;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.MapListHandler;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "psndoc_search", urlPatterns = "/psndoc_search")
public class Search extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //用于判断是否第一次读到数据
        int flag = 0;
        JSONObject json = JSON.parseObject(req.getParameter("json"));
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT ");
        sql.append(" BD_PSNDOC.BIRTHDATE,");//生日
        sql.append(" BD_PSNDOC.BLOODTYPE,");//血型
        sql.append(" BD_PSNDOC.CREATIONTIME,");//创建时间
        sql.append(" BD_PSNDOC.CREATOR,");//创建人
        sql.append(" BD_PSNDOC.EDU,");//学历
        sql.append(" BD_PSNDOC.ID,");//身份证
        sql.append(" BD_PSNDOC.PHONE,");//电话
        sql.append(" BD_PSNDOC.NAME,");//名称
        sql.append(" BD_PSNDOC.SEX,");//性别
        sql.append(" BD_JOB.NAME JOB_NAME,");//职位
        sql.append(" BD_PSNDOC.SCHOOL,");//学校
        sql.append(" BD_DEPT.DEPTNAME");//部门
        sql.append(" FROM BD_PSNDOC");
        sql.append(" left JOIN BD_JOB on BD_PSNDOC.JOB_CODE = BD_JOB.CODE");
        sql.append(" left JOIN BD_DEPT on BD_JOB.DEPTCODE = BD_DEPT.CODE");
        if (!json.get("SCHOOL").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.SCHOOL='" + json.get("SCHOOL") + "'");
                flag = 1;
            }
        }
        if (!json.get("DEPT").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_DEPT.CODE='" + json.get("DEPT") + "'");
                flag = 1;
            }
        }
        if (!json.get("BIRDAY").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.BIRTHDATE='" + json.get("BIRDAY") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.BIRTHDATE='" + json.get("BIRDAY") + "'");
            }
        }
        if (!json.get("BLOOD").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.BLOODTYPE='" + json.get("BLOOD") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.BLOODTYPE='" + json.get("BLOOD") + "'");
            }
        }
        if (!json.get("PHONE").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.PHONE='" + json.get("PHONE") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.PHONE='" + json.get("PHONE") + "'");
            }
        }
        if (!json.get("ID").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.ID='" + json.get("ID") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.ID='" + json.get("ID") + "'");
            }
        }
        if (!json.get("SEX").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.SEX='" + json.get("SEX") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.SEX='" + json.get("SEX") + "'");
            }
        }
        if (!json.get("NAME").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.NAME='" + json.get("NAME") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.NAME='" + json.get("NAME") + "'");
            }
        }
        if (!json.get("JOB").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.JOB_CODE ='" + json.get("JOB") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.JOB_CODE ='" + json.get("JOB") + "'");
            }
        }
        if (!json.get("EDU").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.EDU='" + json.get("EDU") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.EDU='" + json.get("EDU") + "'");
            }
        }
        if (!json.get("CREATOR").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.CREATOR='" + json.get("CREATOR") + "'");
                flag = 1;
            }else {
                sql.append(" AND BD_PSNDOC.CREATOR='" + json.get("CREATOR") + "'");
            }
        }
        if (!json.get("CREATIONTIME").toString().isEmpty()) {
            if (flag == 0) {
                sql.append(" WHERE");
                sql.append(" BD_PSNDOC.CREATIONTIME='" + json.get("CREATIONTIME") + "'");
            }else {
                sql.append(" AND BD_PSNDOC.CREATIONTIME='" + json.get("CREATIONTIME") + "'");
            }
        }
        List<Map<String,String>> result = (List<Map<String,String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        JSON jsonResult = (JSON)JSON.toJSON(result);
        resp.getWriter().write(jsonResult.toJSONString());
    }
}
