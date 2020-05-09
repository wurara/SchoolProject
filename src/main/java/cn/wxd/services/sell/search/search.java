package cn.wxd.services.sell.search;

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

@WebServlet(name = "sale_search", urlPatterns = "/sale_search")
public class search extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json = (JSONObject) JSON.parse(req.getParameter("json"));
        int flag = 0;
        StringBuffer sql = new StringBuffer();

        sql.append(" select * from SALE_BILL_HEAD");

        if (!"".equals(json.get("CUSTOMER"))) {
            sql.append(" where ");
            sql.append(" CUSTOMER='" + json.get("CUSTOMER") + "'");
            flag = 1;
        }
        if(!"".equals(json.get("CREATOR"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" BILL_MAKER='"+json.get("CREATOR")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" BILL_MAKER='"+json.get("CREATOR")+"'");
            }
        }
        if(!"".equals(json.get("ADDRESS"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" ADDRESS='"+json.get("ADDRESS")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" ADDRESS='"+json.get("ADDRESS")+"'");
            }
        }
        if(!"".equals(json.get("CUSTOMER_PHONE"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" CUSTOMER_PHONE='"+json.get("CUSTOMER_PHONE")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" CUSTOMER_PHONE='"+json.get("CUSTOMER_PHONE")+"'");
            }
        }
        if(!"".equals(json.get("BILLID"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" PK_SALE_HEAD='"+json.get("BILLID")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" PK_SALE_HEAD='"+json.get("BILLID")+"'");
            }
        }
        if(!"".equals(json.get("CREATIONTIME"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" CREATIONTIME='"+json.get("CREATIONTIME")+"'");
            }else {
                sql.append(" and ");
                sql.append(" CREATIONTIME='"+json.get("CREATIONTIME")+"'");
            }
        }
        List<Map<String,String>> headResult = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        headResult.remove(headResult.size()-1);
        JSONArray resultJson = (JSONArray) JSON.toJSON(headResult);
        resp.getWriter().write(resultJson.toJSONString());
    }
}
