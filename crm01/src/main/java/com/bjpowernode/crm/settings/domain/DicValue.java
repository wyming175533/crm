package com.bjpowernode.crm.settings.domain;

public class DicValue {
    private String id ;

    private String value;

    private String text;

    private String orderNo;

    private String typeCode;

    public void setId(String id) {
        this.id = id;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getId() {
        return id;
    }

    public String getValue() {
        return value;
    }

    public String getText() {
        return text;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public String getTypeCode() {
        return typeCode;
    }
}
