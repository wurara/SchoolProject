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

@WebServlet(name = "GetFahuoBillDetail",urlPatterns = "/GetFahuoBillDetail")
public class GetFahuoBillDetail extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String billID= req.getParameter("billID");

        StringBuffer sql =new StringBuffer();

        sql.append(" select * from FABILL_HEAD where pk_FABILL_HEAD= '"+billID+"'");

        List<Map<String,String>> headResult = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());

        Map result = headResult.get(0);

        sql.delete(0,sql.length());

        sql.append(" select * from SALE_BILL_BODY where PK_SALE_HEAD='"+headResult.get(0).get("PK_FROM")+"'");

        List<Map<String,String>> bodyResult = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        bodyResult.remove(bodyResult.size()-1);
        result.put("body",bodyResult.toArray());

        resp.getWriter().write(JSON.toJSONString(result));
    }
}
