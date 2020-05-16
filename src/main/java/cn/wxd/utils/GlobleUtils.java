package cn.wxd.utils;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.StringHandler;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwt;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class GlobleUtils {
    /**
     * 获取项目的根目录
     * @return 项目的根路径
     */
    public static String  getProjectRootPath(){
        String rootDirectory = System.getProperty("user.dir");
        return rootDirectory;
    }

    /**
     *   查询当前操作员
     * @param req   浏览器的请求
     * @return
     */
    public static String getCreatorCode(HttpServletRequest req){
        String USER_NAME ="";
        Cookie[] cookies = req.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("token")) {
                try {
                    Jwt jwt= TokenUtils.parseToken(cookie.getValue());
                    Map s = (Claims) jwt.getBody();
                    USER_NAME = (String)s.get("USER_NAME");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return USER_NAME;
    }

    /**
     * 传入表名后查询行数量
     * @param req
     * @return
     */
    public static String getTableCount(HttpServletRequest req){
        String name = req.getParameter("name");
        StringBuffer sql = new StringBuffer();

        sql.append(" select \"MAX\"(ROWCOUNT)  num from "+name);
        sql.append(" where CreationTime = '"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"'");
        String num = String.valueOf(new BaseDAO().executeQuarry(sql.toString(),new StringHandler()));
        return  num=="null"?"0":num;
    }

    /**
     *      传入表名后查询行数量
     * @param name
     * @return
     */
    public static String getTableCount(String name){
        StringBuffer sql = new StringBuffer();

        sql.append(" select \"MAX\"(ROWCOUNT)  num from "+name);
        sql.append(" where CreationTime = '"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"'");
        String num = String.valueOf(new BaseDAO().executeQuarry(sql.toString(),new StringHandler()));
        return  num=="null"?"0":num;
    }

    public static  String getBillPK(String head,String table_name){
        int rowCount = Integer.parseInt(GlobleUtils.getTableCount(table_name))+1;
        String pkBillHead = head+new SimpleDateFormat("YYYYMMdd").format(new Date())+ ("0000"+(Integer.valueOf(rowCount))).substring(("0000"+(Integer.valueOf(rowCount))).length()-4,("0000"+(Integer.valueOf(rowCount))).length());
        return pkBillHead;
    }
}
