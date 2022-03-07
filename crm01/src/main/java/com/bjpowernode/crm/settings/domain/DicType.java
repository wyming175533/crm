package com.bjpowernode.crm.settings.domain;

public class DicType {
    private String appellation ;
    private String  clueState;
    private String returnPriority;
    private String returnState;
    private String source;
    private String  stage;
    private String transactionType;

    public void setAppellation(String appellation) {
        this.appellation = appellation;
    }

    public void setClueState(String clueState) {
        this.clueState = clueState;
    }

    public void setReturnPriority(String returnPriority) {
        this.returnPriority = returnPriority;
    }

    public void setReturnState(String returnState) {
        this.returnState = returnState;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getAppellation() {
        return appellation;
    }

    public String getClueState() {
        return clueState;
    }

    public String getReturnPriority() {
        return returnPriority;
    }

    public String getReturnState() {
        return returnState;
    }

    public String getSource() {
        return source;
    }

    public String getStage() {
        return stage;
    }

    public String getTransactionType() {
        return transactionType;
    }
}
