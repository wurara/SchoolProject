package cn.wxd.DAO.handler;


import java.sql.ResultSet;

public interface Handler {
    public Object doHandler(ResultSet result);
}
