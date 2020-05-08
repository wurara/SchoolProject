package cn.wxd.services.sell;

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

@WebServlet(name = "SellBillCheck",urlPatterns = "/SellBillCheck")
public class SellBillCheck extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String billID= req.getParameter("billID");

        StringBuffer sql = new StringBuffer();

        sql.append(" update SALE_BILL_HEAD set ");
        sql.append(" BILL_CHECKER='"+GlobleUtils.getCreatorCode(req) +"'");
        sql.append(" , BILL_CHECK_DATE='"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"'");
        int rowCount = Integer.parseInt(GlobleUtils.getTableCount("FABILL_HEAD"))+1;
        String pkFaBillHead = "fh"+new SimpleDateFormat("YYYYMMdd").format(new Date())+ ("0000"+Integer.valueOf(rowCount)).substring(("0000"+rowCount).length()-4,("0000"+rowCount).length());
        sql.append(" ,PK_AFTER='"+pkFaBillHead+"'");
        sql.append(" ,AFTER_BILL_TYPE='FABILL_HEAD'");
        sql.append(" where PK_SALE_HEAD = '"+billID +"'");

        String result = new BaseDAO().executeUpdate(sql.toString());

        resp.getWriter().write(result);
    }
}
