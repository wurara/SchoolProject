package cn.wxd.services.purch.search;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.MapListHandler;
import com.alibaba.fastjson.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "GetPurchBillDetail",urlPatterns = "/GetPurchBillDetail")
public class GetPurchBillDetail extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String billID= req.getParameter("billID");
        Map result = new HashMap();
        StringBuffer sql = new StringBuffer();

        sql.append(" select * from PURCH_BILL_HEAD where PK_PURCH_HEAD = '"+billID+"'");

        result.putAll(((List<Map<String,String>>)new BaseDAO().executeQuarry(sql.toString(),new MapListHandler())).get(0));

        sql.delete(0,sql.length());

        sql.append(" select * from PURCH_BILL_BODY where PK_PURCH_HEAD='"+billID+"'");

        result.put("body",(new BaseDAO().executeQuarry(sql.toString(),new MapListHandler())));

        String resultJson =  JSON.toJSONString(result);

        resp.getWriter().write(resultJson);
    }
}
