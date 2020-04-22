package cn.wxd.DAO.handler;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MapListHandler implements Handler {
    public List<Map> doHandler(ResultSet result) {
        List<Map> resultList = new ArrayList<>();
        try {
            if (result == null) {
                //未知错误引起
                HashMap map = new HashMap();
                map.put("Error","false:请联系管理员");
                resultList.add(map);
                return resultList;
            }
            ResultSetMetaData metaData=null;
            try{
                //当执行的是插入语句时会报错，但是插入执行成功，所以返回true
                metaData = result.getMetaData();
            }catch (Exception e){
                //返回插入语句的成功标识
                HashMap map = new HashMap();
                map.put("info","true");
                resultList.add(map);
                return resultList;
            }
            //分析处理resultset的数据
            while (result.next()) {
                Map<String, String> map = new HashMap<>();
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    map.put(metaData.getColumnLabel(i),
                            result.getObject(metaData.getColumnLabel(i)) == null ? "" : result.getObject(metaData.getColumnLabel(i)).toString());
                }
                resultList.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            HashMap map = new HashMap();
            map.put("Error",e.getMessage());
            resultList.add(map);
            return resultList;
        }finally {
            //如果查询操作无返回则查询失败
            if(resultList.size()==0){
                HashMap map = new HashMap();
                resultList.add(map);
                return resultList;
            }
        }
        //执行查询时可执行到这一步所以返回值为true
        HashMap map = new HashMap();
        map.put("info","true");
        resultList.add(map);
        return resultList;
    }

}
