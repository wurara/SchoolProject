package cn.wxd.services.purch.search;

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

@WebServlet(name = "PurchSearch",urlPatterns = "/PurchSearch")
public class PurchSearch extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json = JSON.parseObject(req.getParameter("json"));
        int flag = 0;
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from PURCH_BILL_HEAD");

        if (!"".equals(json.get("from"))) {
            sql.append(" where ");
            sql.append(" PK_FROM='" + json.get("from") + "'");
            flag = 1;
        }

        if(!"".equals(json.get("billID"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" PK_PURCH_HEAD='"+json.get("billID")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" PK_PURCH_HEAD='"+json.get("billID")+"'");
            }
        }
        if(!"".equals(json.get("billDate"))){
            if(flag==0){
                sql.append(" where ");
                sql.append(" CREATIONTIME='"+json.get("billDate")+"'");
                flag = 1;
            }else {
                sql.append(" and ");
                sql.append(" CREATIONTIME='"+json.get("billDate")+"'");
            }
        }

        List<Map<String,String>> result = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        result.remove(result.size()-1);
        JSONArray jsonArray = (JSONArray) JSON.toJSON(result);

        resp.getWriter().write(jsonArray.toJSONString());
    }
}
