package cn.wxd.entity;

public class PsndocVO extends MainVO {
    String PK_PSNDOC;
    String ADDR;
    String BIRTHDATE;
    String BLOODTYPE;
    String CODE;
    String CREATOR;
    String EDU;
    String IDTYPE;
    String ID;
    String PHONE;
    String NAME;
    String SEX;
    String JOB_CODE;
    String SCHOOL;
    String PSNTYPE;

    public String getPSNTYPE() {
        return PSNTYPE;
    }

    public void setPSNTYPE(String PSNTYPE) {
        this.PSNTYPE = PSNTYPE;
    }

    public String getPK_PSNDOC() {
        return PK_PSNDOC;
    }

    public void setPK_PSNDOC(String PK_PSNDOC) {
        this.PK_PSNDOC = PK_PSNDOC;
    }

    public String getBIRTHDATE() {
        return BIRTHDATE;
    }

    public void setBIRTHDATE(String BIRTHDATE) {
        this.BIRTHDATE = BIRTHDATE;
    }

    public String getBLOODTYPE() {
        return BLOODTYPE;
    }

    public void setBLOODTYPE(String BLOODTYPE) {
        this.BLOODTYPE = BLOODTYPE;
    }

    public String getCODE() {
        return CODE;
    }

    public void setCODE(String CODE) {
        this.CODE = CODE;
    }

    public String getCREATOR() {
        return CREATOR;
    }

    public void setCREATOR(String CREATOR) {
        this.CREATOR = CREATOR;
    }

    public String getEDU() {
        return EDU;
    }

    public void setEDU(String EDU) {
        this.EDU = EDU;
    }

    public String getIDTYPE() {
        return IDTYPE;
    }

    public void setIDTYPE(String IDTYPE) {
        this.IDTYPE = IDTYPE;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getPHONE() {
        return PHONE;
    }

    public void setPHONE(String PHONE) {
        this.PHONE = PHONE;
    }

    public String getNAME() {
        return NAME;
    }

    public void setNAME(String NAME) {
        this.NAME = NAME;
    }

    public String getSEX() {
        return SEX;
    }

    public void setSEX(String SEX) {
        this.SEX = SEX;
    }

    @Override
    public String getDR() {
        return DR;
    }

    @Override
    public void setDR(String DR) {
        this.DR = DR;
    }

    public String getJOB_CODE() {
        return JOB_CODE;
    }

    public void setJOB_CODE(String JOB_CODE) {
        this.JOB_CODE = JOB_CODE;
    }

    public String getSCHOOL() {
        return SCHOOL;
    }

    public void setSCHOOL(String SCHOOL) {
        this.SCHOOL = SCHOOL;
    }

    @Override
    public String getTable() {
        return "BD_PSNDOC";
    }

    @Override
    public String getClassName() {
        return "cn.wxd.entity.PsndocVO";
    }
}
