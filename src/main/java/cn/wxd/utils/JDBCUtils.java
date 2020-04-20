package cn.wxd.utils;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.DAO.handler.MapListHandler;
import cn.wxd.entity.MainVO;

import javax.swing.*;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

public class JDBCUtils {
    /**
     * 查找单个用户
     * @param user 用户的账户密码
     * @return
     */
    public static Map<String,String> quarryUser(HashMap user){
        StringBuffer sql = new StringBuffer();
        sql.append(" select ");
        sql.append(" SM_USER.USER_NAME USER_NAME,");
        sql.append(" BD_JOB.name JOB_NAME,");
        sql.append(" SM_USER.USER_CODE USER_CODE");
        sql.append(" from sm_user");
        sql.append(" left join BD_PSNDOC on BD_PSNDOC.PK_PSNDOC = SM_USER.PK_PSNDOC");
        sql.append(" left join BD_JOB on BD_PSNDOC.JOB_CODE = BD_JOB.CODE");
        sql.append(" where user_code = '"+user.get("usercode")+"'");
        sql.append(" and user_password = '"+user.get("password")+"'");
        List<Map<String,String>> userInfo =  (List<Map<String,String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        if(userInfo.size()==2){
            return  userInfo.get(0);
        }else{
            return new HashMap();
        }
    }

    /**
     *  查询部门
     * @return 所有部门的信息
     */
    public static List<Map<String,String>> queryDept(){
        StringBuffer sql = new StringBuffer();
        sql.append(" select *");
        sql.append(" from bd_dept");
        List<Map<String,String>> deptInfo =  (List<Map<String,String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        return deptInfo;
    }

    /**
     *  按照部门编码查询职位
     * @param code 部门的编码
     * @return
     */
    public static List<Map<String,String>> queryJobByCode(String code){
        StringBuffer sql = new StringBuffer();
        sql.append(" select *");
        sql.append(" from bd_job");
        sql.append(" where DEPTCODE="+code);
        List<Map<String,String>> jobInfo =  (List<Map<String,String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        return jobInfo;
    }

    /**
     *  按照部门名称查询职位
     * @param name 部门的名称
     * @return
     */
    public static List<Map<String,String>> queryJobByNane(String name){
        StringBuffer sql = new StringBuffer();
        sql.append(" select *");
        sql.append(" from bd_job");
        sql.append(" left join BD_DEPT on BD_JOB.DEPTCODE = BD_DEPT.CODE");
        sql.append(" where BD_DEPT.DEPTNAME="+name);
        List<Map<String,String>> jobInfo =  (List<Map<String,String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        return jobInfo;
    }

    /**
     *  将VO中的数据持久化存储到数据库中
     * @param tempVO 要储存的VO
     * @return
     */
    public static String saveVO(MainVO tempVO){
        Class classObject = null ;
        try{
            classObject = Class.forName(tempVO.getClassName());
            classObject.cast(tempVO);
        }catch (Exception e){
        }
        StringBuffer sql = new StringBuffer();
        sql.append("INSERT INTO ");
        sql.append(tempVO.getTable()+"(");
        //获得所有的get方法
        Method[] tempMethods = classObject.getMethods();
        List<Method> getMethods = new ArrayList<>();
        List<Method> setMethods = new ArrayList<>();
        for(Method method:tempMethods){
            if(method.getName().contains("get")){
                getMethods.add(method);
            }
            if(method.getName().contains("set")){
                setMethods.add(method);
            }
        }
        //将字段名称插入到sql语句中
        for(int i=0;i<setMethods.size();i++){
            Method method = setMethods.get(i);
            sql.append(method.getName().substring(3)+",");
        }
        sql.delete(sql.length()-1,sql.length());
        //开始插入字段的值
        sql.append(")  values (");
        for(int i=0;i<setMethods.size();i++){
            //所有的set方法都是字段，所以将所有的set方法对应的字段值取出
            Method setMethod = setMethods.get(i);
            String fieldName = setMethod.getName().substring(3,setMethod.getName().length());
            for(Method method :getMethods){
                if(method.getName().equals("get"+fieldName)){
                    try {
                        //字段值插入sql语句中
                        if((method.invoke(tempVO))==null){
                            sql.append("'',");
                        }else {
                            sql.append("'"+ method.invoke(tempVO)+"',");
                        }
                    } catch (IllegalAccessException e) {
                        sql.append("'',");
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        sql.append("'',");
                        e.printStackTrace();
                    }
                }
            }
        }
        sql.delete(sql.length()-1,sql.length());
        sql.append(")");
        List<Map<String,String>> deptInfo =  (List<Map<String,String>>) new BaseDAO().executeQuarry(sql.toString(),new MapListHandler());
        return deptInfo.get(0).get("info");
}
}
