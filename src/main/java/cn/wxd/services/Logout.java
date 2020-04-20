package cn.wxd.services;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 注销功能
 */
public class Logout extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie cookie = new Cookie("token","");
        cookie.setMaxAge(0);
        resp.addCookie(cookie);
        req.getRequestDispatcher("/outer/NoLoginPage.jsp?before=Logout").forward(req,resp);
    }
}
