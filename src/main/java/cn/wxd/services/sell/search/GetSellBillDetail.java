package cn.wxd.services.sell.search;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.MapListHandler;
import com.alibaba.fastjson.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "GetSellBillDetail",urlPatterns = "/GetSellBillDetail")
public class GetSellBillDetail extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuffer sql = new StringBuffer();

        sql.append("select * from SALE_BILL_HEAD where PK_SALE_HEAD='"+req.getParameter("billID")+"'");

        List<Map<String,String>> headResultList = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        Map result = headResultList.get(0);
        sql.delete(0,sql.length());

        sql.append("select * from SALE_BILL_BODY where PK_SALE_HEAD='"+req.getParameter("billID")+"'");
        List<Map<String,String>> bodyResult = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        bodyResult.remove(bodyResult.size()-1);
        result.put("body",bodyResult.toArray());

        JSON json = (JSON) JSON.toJSON(result);

        resp.getWriter().write(json.toJSONString());
    }
}
