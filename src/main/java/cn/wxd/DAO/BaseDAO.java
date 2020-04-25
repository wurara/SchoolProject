package cn.wxd.DAO;

import cn.wxd.DAO.handler.Handler;
import cn.wxd.utils.PropertiesUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 执行基础的数据库操作
 */
public class BaseDAO {
    private Connection conn = null;

    public BaseDAO() {

    }

    public Object executeQuarry(String sql, Handler handler) {
        try {
            return handler.doHandler(this.executeQuarry(sql));
        } catch (SQLException e) {
            List<Map<String, String>> result = new ArrayList<>();
            Map map = new HashMap();
            map.put("info", e.getMessage());
            result.add(map);
            return result;
        }

    }

    /**
     *  执行更新或删除操作
     * @param sql sql语句
     * @return
     */
    public String executeUpdate(String sql) {
        String result = new String();
        try {
            int i = this.executeUpdateInner(sql);
            result = String.valueOf(i);
        } catch (SQLException e) {
            e.printStackTrace();
            result="Error："+e.getMessage();
        }
        return result;
    }

    //执行查询
    private ResultSet executeQuarry(String sql) throws SQLException {
        ResultSet rs = null;
        PreparedStatement st;
        st = getConn().prepareStatement(sql);
        rs = st.executeQuery();
        return rs;
    }

    //执行删除或更新
    private int executeUpdateInner(String sql) throws SQLException {
        PreparedStatement st;
        st = getConn().prepareStatement(sql);
        int rs = st.executeUpdate();
        return rs;
    }

    private Connection getConn() {
        if (conn == null) {
            try {
                Map<String, String> propertiesMap = PropertiesUtils.propertiesMapReader("jdbc");
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection(
                        propertiesMap.get("uri"),
                        propertiesMap.get("user"),
                        propertiesMap.get("pwd"));
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return conn;
    }

}
