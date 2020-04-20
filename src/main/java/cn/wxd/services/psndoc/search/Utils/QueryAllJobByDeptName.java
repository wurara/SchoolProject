package cn.wxd.services.psndoc.search.Utils;

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

@WebServlet(name = "QueryAllJobByDeptName",urlPatterns = "/QueryAllJobByDeptName")
public class QueryAllJobByDeptName extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        StringBuffer sql = new StringBuffer();
        sql.append(" select bd_job.name");
        sql.append(" from bd_dept");
        sql.append(" left join bd_job on bd_Dept.code = bd_job.deptcode");
        sql.append(" where bd_dept.DEPTname='" +name+"'");
        List<Map<String,String>> list = (List<Map<String, String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        JSON json = (JSON)JSON.toJSON(list);
        resp.getWriter().write(json.toJSONString());

    }
}
