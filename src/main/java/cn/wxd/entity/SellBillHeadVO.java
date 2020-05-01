package cn.wxd.entity;

public class SellBillHeadVO extends BussinessVO {
    String PK_SALE_HEAD;
    String CUSTOMER;
    String CUSTOMER_PHONE;
    String MONEY;
    String CREATIONTIME;
    String BILL_MAKER;
    String BILL_CHECKER;
    String BILL_CHECK_DATE;
    String PK_AFTER;
    String AFTER_BILL_TYPE;
    String ADDRESS;

    public String getADDRESS() {
        return ADDRESS;
    }

    public void setADDRESS(String ADDRESS) {
        this.ADDRESS = ADDRESS;
    }

    public String getPK_SALE_HEAD() {
        return PK_SALE_HEAD;
    }

    public void setPK_SALE_HEAD(String PK_SALE_HEAD) {
        this.PK_SALE_HEAD = PK_SALE_HEAD;
    }

    public String getCUSTOMER() {
        return CUSTOMER;
    }

    public void setCUSTOMER(String CUSTOMER) {
        this.CUSTOMER = CUSTOMER;
    }

    public String getCUSTOMER_PHONE() {
        return CUSTOMER_PHONE;
    }

    public void setCUSTOMER_PHONE(String CUSTOMER_PHONE) {
        this.CUSTOMER_PHONE = CUSTOMER_PHONE;
    }

    public String getMONEY() {
        return MONEY;
    }

    public void setMONEY(String MONEY) {
        this.MONEY = MONEY;
    }

    @Override
    public String getCREATIONTIME() {
        return CREATIONTIME;
    }

    @Override
    public void setCREATIONTIME(String CREATIONTIME) {
        this.CREATIONTIME = CREATIONTIME;
    }

    public String getBILL_MAKER() {
        return BILL_MAKER;
    }

    public void setBILL_MAKER(String BILL_MAKER) {
        this.BILL_MAKER = BILL_MAKER;
    }

    public String getBILL_CHECKER() {
        return BILL_CHECKER;
    }

    public void setBILL_CHECKER(String BILL_CHECKER) {
        this.BILL_CHECKER = BILL_CHECKER;
    }

    public String getBILL_CHECK_DATE() {
        return BILL_CHECK_DATE;
    }

    public void setBILL_CHECK_DATE(String BILL_CHECK_DATE) {
        this.BILL_CHECK_DATE = BILL_CHECK_DATE;
    }

    public String getPK_AFTER() {
        return PK_AFTER;
    }

    public void setPK_AFTER(String PK_AFTER) {
        this.PK_AFTER = PK_AFTER;
    }

    public String getAFTER_BILL_TYPE() {
        return AFTER_BILL_TYPE;
    }

    public void setAFTER_BILL_TYPE(String AFTER_BILL_TYPE) {
        this.AFTER_BILL_TYPE = AFTER_BILL_TYPE;
    }

    @Override
    public String getTable() {
        return "SALE_BILL_HEAD";
    }

}
