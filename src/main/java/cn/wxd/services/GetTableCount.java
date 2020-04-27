package cn.wxd.services;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.StringHandler;
import cn.wxd.utils.GlobleUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
@WebServlet(name = "GetTableCount",urlPatterns = "/GetTableCount")
public class GetTableCount extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().write(GlobleUtils.getTableCount(req));
    }
}
