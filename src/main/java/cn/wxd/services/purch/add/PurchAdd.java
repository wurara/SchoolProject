package cn.wxd.services.purch.add;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.utils.GlobleUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "PurchAdd", urlPatterns = "/PurchAdd")
public class PurchAdd extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json = (JSONObject) JSON.parse(req.getParameter("json"));
        String pkPurchHead = GlobleUtils.getBillPK("cg","PURCH_BILL_HEAD");
        StringBuffer sql = new StringBuffer();
        //将采购单表头插入到表头中
        sql.append(" insert into PURCH_BILL_HEAD (PK_PURCH_HEAD,DR,CREATIONTIME,PK_FROM,ROWCOUNT)");
        sql.append(" values(");
        sql.append(" '" + pkPurchHead + "',");
        sql.append(" '" + 0 + "',");
        sql.append(" '" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "',");
        sql.append(" '" + json.get("PK_SALE_HEAD") + "',");
        sql.append(" '" + GlobleUtils.getTableCount("PURCH_BILL_HEAD") + "'");
        sql.append(" )");
        String result = new BaseDAO().executeUpdate(sql.toString());

        JSONArray bodyArray = (JSONArray) json.get("body");
        //将采购单表体插入到数据库中
        for (int i = 0; i < bodyArray.size(); i++) {
            sql.delete(0, sql.length());
            sql.append(" insert into PURCH_BILL_BODY (PK_PURCH_HEAD,PK_PURCH_BODY,DR,MATERIAL_NAME,DETAIL_NUM,NOTE,UNIT,ROWCOUNT)");
            sql.append(" values(");
            sql.append(" '" + pkPurchHead + "',");
            sql.append(" '" + pkPurchHead + ("0000" + (i + 1)).substring(("0000" + (i + 1)).length() - 4, ("0000" + (i + 1)).length()) + "',");
            sql.append(" '" + 0 + "',");
            sql.append(" '" + bodyArray.getJSONObject(i).get("MATERIAL_NAME") + "',");
            sql.append(" '" + bodyArray.getJSONObject(i).get("DETAIL_NUM") + "',");
            sql.append(" '" + bodyArray.getJSONObject(i).get("NOTE") + "',");
            sql.append(" '" + bodyArray.getJSONObject(i).get("UNIT") + "',");
            sql.append(" '" + (i + 1) + "'");
            sql.append(" )");
            result += new BaseDAO().executeUpdate(sql.toString());
        }
        resp.getWriter().write(result);


    }
}
