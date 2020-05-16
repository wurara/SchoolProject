package cn.wxd.services.earn;

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

@WebServlet(name = "EarnBillSearch",urlPatterns = "/EarnBillSearch")
public class EarnBillSearch extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json = JSON.parseObject(req.getParameter("json"));
        int flag = 0;
        StringBuffer sql = new StringBuffer();

        sql.append(" select * from EARN_BILL");
        if (!"".equals(json.get("customer"))) {
            sql.append(" where ");
            sql.append(" CUSTOMER='" + json.get("customer") + "'");
            flag = 1;
        }
        if(!"".equals(json.get("billID"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" PK_EARN='"+json.get("billID")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" PK_EARN='"+json.get("billID")+"'");
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

        if(!"".equals(json.get("earn_flag"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" EARN_FLAG='"+json.get("earn_flag")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" EARN_FLAG='"+json.get("earn_flag")+"'");
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
