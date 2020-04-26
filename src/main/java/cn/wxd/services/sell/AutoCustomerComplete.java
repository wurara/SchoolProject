package cn.wxd.services.sell;

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

@WebServlet(name = "AutoCustomerComplete",urlPatterns = "/AutoCustomerComplete")
public class AutoCustomerComplete extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        StringBuffer sql = new StringBuffer();
        sql.append(" select name from bd_psndoc");
        sql.append(" where name like '%"+name+"%'");
        sql.append(" and PSNTYPE='02'");
        List<Map<String,String>> resultList = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        resultList.remove(resultList.size()-1);
        StringBuffer result = new StringBuffer();
        for(Map temp : resultList){
            result.append(temp.get("NAME"));
            result.append(",");
        }
        result.delete(result.length()-1,result.length());
        resp.getWriter().write(result.toString());
    }
}
