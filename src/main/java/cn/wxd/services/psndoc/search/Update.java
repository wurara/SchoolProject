package cn.wxd.services.psndoc.search;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.StringHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "psndoc_update", urlPatterns = "/psndoc_update")
public class Update extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //获取要跟新的字段名
        String name = req.getParameter("name");
        //获取更新后的字段值
        String info = req.getParameter("info");
        //获取更新前的字段值
        String ID = req.getParameter("psndocID");
        //设置成功标记
        String flag;
        StringBuffer sql = new StringBuffer();
        //如果是职业更新的话
        if(name.equals("JOB_NAME")){
            //查询出这个职业的code
            //部门名称
            String deptName = req.getParameter("deptName");
            sql.append(" select bd_job.code");
            sql.append(" from bd_dept");
            sql.append(" left join bd_job on bd_dept.code = bd_job.deptcode");
            sql.append(" where bd_dept.deptname = '"+deptName+"'");
            sql.append(" and bd_job.name='"+info+"'");
            String JOB_CODE = (String) new BaseDAO().executeQuarry(sql.toString(),new StringHandler());
            sql.delete(0,sql.length());
            sql.append(" update BD_PSNDOC");
            sql.append(" SET JOB_CODE='"+JOB_CODE+"'");
            sql.append(" WHERE ID='"+ID+"'");
        }else {
            sql.append(" update BD_PSNDOC");
            sql.append(" SET "+name+"='"+info+"'");
            sql.append(" WHERE ID='"+ID+"'");
        }
        flag = new BaseDAO().executeUpdate(sql.toString());
        //如果是电话更改的话，还要同步到用户表
        if(name.equals("PHONE")&&flag.equals("1")){
            sql.delete(0,sql.length());
            sql.append(" update SM_USER");
            sql.append(" SET USER_CODE='"+info+"'");
            sql.append(" WHERE CUSERID='yh"+ID+"'");
             flag = new BaseDAO().executeUpdate(sql.toString());
        }
        if(flag.equals("1")){
                resp.getWriter().write("success");
            }else {
                resp.getWriter().write(flag);
            }
        }
}
