package cn.wxd.services.sell.add;

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

@WebServlet(name = "AutoCustomerPhoneComplete",urlPatterns = "/AutoCustomerPhoneComplete")
public class AutoCustomerPhoneComplete extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        StringBuffer sql = new StringBuffer();

        sql.append(" select * from BD_PSNDOC where name = '"+name+"'");

        List<Map<String,String>> info = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        JSON json  = (JSON) JSON.toJSON(info.get(0));

        resp.getWriter().write(json.toJSONString());
    }
}
