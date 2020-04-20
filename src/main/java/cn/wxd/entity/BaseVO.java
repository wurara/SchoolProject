package cn.wxd.entity;

/**
 * 基础VO
 */
public interface BaseVO {
    //获取该VO对应的数据库表
    public String getTable();
    //获取类名
    public String getClassName();
}
