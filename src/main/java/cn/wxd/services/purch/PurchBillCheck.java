package cn.wxd.services.purch;

import cn.wxd.DAO.BaseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "PurchBillCheck",urlPatterns = "/PurchBillCheck")
public class PurchBillCheck extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String checker = req.getParameter("checker");
        String money = req.getParameter("money");
        String billID = req.getParameter("billID");
        StringBuffer sql = new StringBuffer();
        sql.append(" update PURCH_BILL_HEAD set ");
        sql.append(" BILL_CHECKER='"+checker+"'");
        sql.append(" ,CHECK_TIME='"+new SimpleDateFormat("yyyy-MM-dd").format(new Date()) +"'");
        sql.append(" ,MONEY = '"+money+"'");
        sql.append(" WHERE PK_PURCH_HEAD = '"+billID+"'");

        String result = new BaseDAO().executeUpdate(sql.toString());

        resp.getWriter().write(result);
    }
}
