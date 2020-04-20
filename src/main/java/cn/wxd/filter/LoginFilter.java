package cn.wxd.filter;

import cn.wxd.utils.TokenUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 登陆过滤器
 */
@WebFilter(filterName = "LoginFilter",urlPatterns = "/mainPage/*")
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        String uri = req.getRequestURI();
        //检查cookie中的token，如果有且能解析则放行，否则跳到登陆页面
        if (req.getCookies() == null) {
            req.getRequestDispatcher("/outer/NoLoginPage.jsp").forward(servletRequest, servletResponse);
            return;
        }
        Cookie[] cookies = req.getCookies();
        int flag = 0;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("token")) {
                try {
                    TokenUtils.parseToken(cookie.getValue());
                    req.getRequestDispatcher(uri).forward(servletRequest,servletResponse);
                    flag=1;
                } catch (Exception e) {
                    resp.sendRedirect("/outer/NoLoginPage.jsp");
                }
            }
        }
        if (flag==0){
            resp.sendRedirect("/outer/NoLoginPage.jsp");
        }
    }

    @Override
    public void destroy() {

    }
}
