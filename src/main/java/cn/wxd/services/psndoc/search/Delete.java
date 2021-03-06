package cn.wxd.services.psndoc.search;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.MapListHandler;
import cn.wxd.DAO.handler.StringHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "psndoc_delete", urlPatterns = "/psndoc_delete")
public class Delete extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //人员的身份证号码作为id
        String ID = req.getParameter("ID");
        //数据库执行返回消息
        Map<String,String> result =  new HashMap();
        StringBuffer sql = new StringBuffer();
        //查询该人员是否用户
        sql.append(" select PSNTYPE from BD_PSNDOC where id = '"+ID+"'");
        String PSNTYPE = (String) new BaseDAO().executeQuarry(sql.toString(),new StringHandler());
        sql.delete(0,sql.length());
        //删除BD_PSNDOC中的数据
        sql.append(" DELETE FROM BD_PSNDOC WHERE ID = '"+ ID+"'");
        result.put("BD_PSNDOC",new BaseDAO().executeUpdate(sql.toString()));
        sql.delete(0,sql.length());
        //先设置为成功，若失败则覆盖成功的值
        result.put("SM_USER","1");
        //如果用户类型是用户，则删除SM_USER的数据
        if(PSNTYPE.equals("01")){
            sql.append(" DELETE FROM SM_USER WHERE PK_PSNDOC = 'ry"+ ID+"'");
            result.put("SM_USER",new BaseDAO().executeUpdate(sql.toString()));
        }
        if(result.get("BD_PSNDOC").equals("1")&&result.get("SM_USER").equals("1")){
            resp.getWriter().write("1");
        }else {
            resp.getWriter().write("0");
        }
    }
}
