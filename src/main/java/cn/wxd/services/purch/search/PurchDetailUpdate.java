package cn.wxd.services.purch.search;

import cn.wxd.DAO.BaseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "PurchDetailUpdate",urlPatterns = "/PurchDetailUpdate")
public class PurchDetailUpdate extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String billID= req.getParameter("billID");
        String name = req.getParameter("name");
        String info = req.getParameter("info");

        StringBuffer  sql = new StringBuffer();

        sql.append(" update PURCH_BILL_BODY ");
        sql.append(" SET "+name+"='"+info+"'");
        sql.append(" where PK_PURCH_BODY='"+billID+"'");

        String result = new BaseDAO().executeUpdate(sql.toString());

        resp.getWriter().write(result);
    }
}
