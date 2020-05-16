package cn.wxd.services.fahuo;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.MapListHandler;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "FaBillSearch", urlPatterns = "/FaBillSearch")
public class FaBillSearch extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json = JSON.parseObject(req.getParameter("info"));
        int flag = 0;
        StringBuffer sql = new StringBuffer();

        sql.append(" select * from FABILL_HEAD");
        if (!"".equals(json.get("customer"))) {
            sql.append(" where ");
            sql.append(" CUSTOMER='" + json.get("customer") + "'");
            flag = 1;
        }
        if(!"".equals(json.get("billID"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" PK_FABILL_HEAD='"+json.get("billID")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" PK_FABILL_HEAD='"+json.get("billID")+"'");
            }
        }
        if(!"".equals(json.get("customer_phone"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" CUSTOMER_PHONE='"+json.get("customer_phone")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" CUSTOMER_PHONE='"+json.get("customer_phone")+"'");
            }
        }
        if(!"".equals(json.get("address"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" ADDRESS='"+json.get("address")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" ADDRESS='"+json.get("address")+"'");
            }
        }
        if(!"".equals(json.get("check_time"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" CHECK_TIME='"+json.get("check_time")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" CHECK_TIME='"+json.get("check_time")+"'");
            }
        }
        if(!"".equals(json.get("checker"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" BILL_CHECKER='"+json.get("checker")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" BILL_CHECKER='"+json.get("checker")+"'");
            }
        }
        if(!"".equals(json.get("pk_from"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" PK_FROM='"+json.get("pk_from")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" PK_FROM='"+json.get("pk_from")+"'");
            }
        }
        List<Map<String,String>> result = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        result.remove(result.size()-1);
        JSON resultjson = (JSON) JSON.toJSON(result);

        resp.getWriter().write(resultjson.toJSONString());
    }
}
