package cn.wxd.DAO.handler;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class StringHandler implements Handler {
    @Override
    public Object doHandler(ResultSet result) {
        String string;
        try {
            ResultSetMetaData metaData = result.getMetaData();
            result.next();
            string = String.valueOf(result.getObject(metaData.getColumnLabel(1)));
        } catch (SQLException e) {
            e.printStackTrace();
            string =e.getMessage();
        }
        return string;
    }
}
