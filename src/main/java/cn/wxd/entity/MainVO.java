package cn.wxd.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *  基础字段
 */
public abstract class MainVO implements BaseVO{
    String DR="0";
    String CREATIONTIME=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    public String getDR() {
        return DR;
    }

    public void setDR(String DR) {
        this.DR = DR;
    }

    public String getCREATIONTIME() {
        return CREATIONTIME;
    }

    public void setCREATIONTIME(String CREATIONTIME) {
        this.CREATIONTIME = CREATIONTIME;
    }

    @Override
    public String getClassName() {
        return this.getClass().getName();
    }
}
