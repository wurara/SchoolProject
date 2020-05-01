package cn.wxd.entity;

/**
 * 用户VO
 */
public class UserVO extends MainVO{
    String USER_NAME;
    String USER_PASSWORD;
    String USER_CODE;
    String PK_PSNDOC;
    String EMAIL;
    String DISABLEDATE;
    String CREATOR;
    String CUSERID;

    public String getUSER_NAME() {
        return USER_NAME;
    }

    public void setUSER_NAME(String USER_NAME) {
        this.USER_NAME = USER_NAME;
    }

    public String getUSER_PASSWORD() {
        return USER_PASSWORD;
    }

    public void setUSER_PASSWORD(String USER_PASSWORD) {
        this.USER_PASSWORD = USER_PASSWORD;
    }

    public String getUSER_CODE() {
        return USER_CODE;
    }

    public void setUSER_CODE(String USER_CODE) {
        this.USER_CODE = USER_CODE;
    }

    public String getPK_PSNDOC() {
        return PK_PSNDOC;
    }

    public void setPK_PSNDOC(String PK_PSNDOC) {
        this.PK_PSNDOC = PK_PSNDOC;
    }

    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String EMAIL) {
        this.EMAIL = EMAIL;
    }

    public String getDISABLEDATE() {
        return DISABLEDATE;
    }

    public void setDISABLEDATE(String DISABLEDATE) {
        this.DISABLEDATE = DISABLEDATE;
    }

    public String getCREATOR() {
        return CREATOR;
    }

    public void setCREATOR(String CREATOR) {
        this.CREATOR = CREATOR;
    }

    public String getCUSERID() {
        return CUSERID;
    }

    public void setCUSERID(String CUSERID) {
        this.CUSERID = CUSERID;
    }

    @Override
    public String getTable() {
        return "SM_USER";
    }

}
