package cn.wxd.services.earn;

import cn.wxd.DAO.BaseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(name = "SureMoney",urlPatterns = "/SureMoney")
public class SureMoney extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String billID= req.getParameter("billID");

    StringBuffer sql = new StringBuffer();

    sql.append(" update EARN_BILL");
    sql.append(" set EARN_FLAG='1'");
    sql.append(" where pk_EARN='"+billID+"'");

    String result = new BaseDAO().executeUpdate(sql.toString());

    resp.getWriter().write(result);

    }
}
