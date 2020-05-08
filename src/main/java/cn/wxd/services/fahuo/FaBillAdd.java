package cn.wxd.services.fahuo;

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

@WebServlet(name = "FaBillAdd",urlPatterns = "/FaBillAdd")
public class FaBillAdd extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json = (JSONObject) JSON.parse(req.getParameter("json"));
        StringBuffer sql = new StringBuffer();
        String result = "";
        sql.append(" insert into FaBILL_HEAD (PK_FABILL_HEAD,DR,CREATIONTIME,ADDRESS,PK_FROM,CUSTOMER,CUSTOMER_PHONE,ROWCOUNT)");

        sql.append(  "values (");
        sql.append(" '"+GlobleUtils.getBillPK("fh","FABILL_HEAD")+"',");
        sql.append(" '0',");
        sql.append(" '"+new SimpleDateFormat("YYYY-MM-dd").format(new Date())+"',");
        sql.append(" '"+json.get("ADDRESS")+"',");
        sql.append(" '"+json.get("PK_SALE_HEAD")+"',");
        sql.append(" '"+json.get("CUSTOMER")+"',");
        sql.append(" '"+json.get("CUSTOMER_PHONE")+"',");
        sql.append(" '"+(Integer.valueOf(GlobleUtils.getTableCount("FaBILL_HEAD"))+1)+"'");
        sql.append(")");
        try {
            result = new BaseDAO().executeUpdate(sql.toString());
        }catch (Exception e){
            e.printStackTrace();
            resp.getWriter().write(result);
        }
        resp.getWriter().write(result);
    }
}
