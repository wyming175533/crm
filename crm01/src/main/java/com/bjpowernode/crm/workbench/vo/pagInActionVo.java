package com.bjpowernode.crm.workbench.vo;

import java.util.List;

/**
 *
 * @param <T>传入什么类型， 就是什么类型，泛型的一种应用
 * 本类主要用于后端向前端返回数据所用
 */
public class pagInActionVo<T> {
    private  int total;
    private List<T> datalist;

    public void setTotal(int total) {
        this.total = total;
    }

    public void setDatalist(List<T> datalist) {
        this.datalist = datalist;
    }

    public int getTotal() {
        return total;
    }

    public List<T> getDatalist() {
        return datalist;
    }
}
