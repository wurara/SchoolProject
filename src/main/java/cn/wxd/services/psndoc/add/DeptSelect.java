package cn.wxd.services.psndoc.add;

import cn.wxd.utils.JDBCUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name="dept_select",urlPatterns="/dept_select")
public class DeptSelect extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONArray jsonArray = new JSONArray();
        List<Map<String,String>> deptInfo = JDBCUtils.queryDept();
        for (Map<String,String> temp : deptInfo){
            JSONObject json  =  new JSONObject();
            json.put("DEPTNAME",temp.get("DEPTNAME"));
            json.put("CODE",temp.get("CODE"));
            jsonArray.add(json);
        }
        resp.getWriter().write(jsonArray.toJSONString());
    }
}
