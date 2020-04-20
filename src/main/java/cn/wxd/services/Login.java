package cn.wxd.services;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.MapListHandler;
import cn.wxd.utils.JDBCUtils;
import cn.wxd.utils.TokenUtils;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 登陆功能
 */
public class Login extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String usercode = req.getParameter("usercode");
        String password = req.getParameter("pwd");
        HashMap pwd = new HashMap();
        pwd.put("usercode",usercode);
        pwd.put("password",password);
        Map<String,String> userInfo=JDBCUtils.quarryUser(pwd);
        JSONObject json  =  new JSONObject();
        if(userInfo.size()==0){
            json.put("flag","1");
            json.put("msg","用户名或密码错误");
            resp.getWriter().write(json.toJSONString());

        }else{
            String token = TokenUtils.createToken(userInfo);
            json.put("flag","0");
            json.put("msg",token);
            json.put("user_name",userInfo.get("USER_NAME"));
            json.put("user_job",userInfo.get("JOB_NAME"));
            resp.getWriter().write(json.toJSONString());
        }

    }
}