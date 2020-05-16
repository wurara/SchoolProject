package cn.wxd.services.fahuo;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.utils.GlobleUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "FahuoBillCheck",urlPatterns = "/FahuoBillCheck")
public class FahuoBillCheck extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String checker = req.getParameter("checker");
        String date = new SimpleDateFormat("yyyy-mm-dd").format(new Date());
        String billID= req.getParameter("billID");

        StringBuffer sql = new StringBuffer();

        sql.append(" update FABILL_HEAD");
        sql.append(" set BILL_CHECKER='"+checker+"'");
        sql.append(" ,CHECK_TIME='"+date+"'");
        sql.append(" ,pk_AFTER='"+GlobleUtils.getBillPK("sk","EARN_BILL") +"'");
        sql.append(" ,AFTER_TYPE='EARN_BILL'");
        sql.append( " where pk_FaBILL_HEAD='"+billID+"'");

        String result = new BaseDAO().executeUpdate(sql.toString());

        resp.getWriter().write(result);
    }
}
