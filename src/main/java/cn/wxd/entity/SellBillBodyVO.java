package cn.wxd.entity;

public class SellBillBodyVO extends BussinessVO {
    String PK_SALE_BODY;
    String PK_SALE_HEAD;
    String MATERIAL_NAME;
    String UNIT;
    String DETAIL_NUM;
    String PRICE;
    String NOTE;
    String MONEY;
    String DEF1;

    public String getDETAIL_NUM() {
        return DETAIL_NUM;
    }

    public void setDETAIL_NUM(String DETAIL_NUM) {
        this.DETAIL_NUM = DETAIL_NUM;
    }

    public String getUNIT() {
        return UNIT;
    }

    public void setUNIT(String UNIT) {
        this.UNIT = UNIT;
    }

    public String getPK_SALE_BODY() {
        return PK_SALE_BODY;
    }

    public void setPK_SALE_BODY(String PK_SALE_BODY) {
        this.PK_SALE_BODY = PK_SALE_BODY;
    }

    public String getPK_SALE_HEAD() {
        return PK_SALE_HEAD;
    }

    public void setPK_SALE_HEAD(String PK_SALE_HEAD) {
        this.PK_SALE_HEAD = PK_SALE_HEAD;
    }

    public String getMATERIAL_NAME() {
        return MATERIAL_NAME;
    }

    public void setMATERIAL_NAME(String MATERIAL_NAME) {
        this.MATERIAL_NAME = MATERIAL_NAME;
    }

    public String getPRICE() {
        return PRICE;
    }

    public void setPRICE(String PRICE) {
        this.PRICE = PRICE;
    }

    public String getNOTE() {
        return NOTE;
    }

    public void setNOTE(String NOTE) {
        this.NOTE = NOTE;
    }

    public String getMONEY() {
        return MONEY;
    }

    public void setMONEY(String MONEY) {
        this.MONEY = MONEY;
    }

    public String getDEF1() {
        return DEF1;
    }

    public void setDEF1(String DEF1) {
        this.DEF1 = DEF1;
    }

    @Override
    public String getTable() {
        return "SALE_BILL_BODY";
    }


}
