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
@WebServlet(name="job_select",urlPatterns="/job_select")
public class JobSelect extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONArray jsonArray = new JSONArray();
        List<Map<String, String>> deptInfo = JDBCUtils.queryJobByCode(req.getParameter("code"));
        for (Map<String, String> temp : deptInfo) {
            JSONObject json = new JSONObject();
            json.put("NAME", temp.get("NAME"));
            json.put("CODE", temp.get("CODE"));
            jsonArray.add(json);
        }
        resp.getWriter().write(jsonArray.toJSONString());
    }
}
