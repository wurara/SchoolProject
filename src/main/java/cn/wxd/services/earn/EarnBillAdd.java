package cn.wxd.services.earn;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.utils.GlobleUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "EarnBillAdd",urlPatterns = "/EarnBillAdd")
public class EarnBillAdd extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json = JSON.parseObject(req.getParameter("json"));

        StringBuffer sql =new StringBuffer();

        sql.append( " insert into EARN_BILL (PK_EARN,CUSTOMER,CUSTOMER_PHONE,PK_FROM,MONEY,EARN_FLAG,ROWCOUNT,CREATIONTIME)");
        sql.append(" values ('"+GlobleUtils.getBillPK("sk","EARN_BILL") +"',");
        sql.append(" '"+json.get("CUSTOMER")+"',");
        sql.append(" '"+json.get("CUSTOMER_PHONE")+"',");
        sql.append(" '"+json.get("PK_FABILL_HEAD")+"',");
        sql.append(" '"+json.get("MONEY")+"',");
        sql.append(" '"+0+"',");
        sql.append(" '"+(Integer.parseInt(GlobleUtils.getTableCount("EARN_BILL"))+1)+"',");
        sql.append(" '"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"'");
        sql.append(" )");

        String result = new BaseDAO().executeUpdate(sql.toString());

        resp.getWriter().write(result);
    }
}
