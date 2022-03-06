package com.bjpowernode.crm.workbench.vo;

import com.bjpowernode.crm.workbench.domain.Activity;

import java.util.List;

public class lodInActionVo<T> {
    private Activity activity;
    private List<T> userList;

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public void setUserList(List<T> userList) {
        this.userList = userList;
    }

    public Activity getActivity() {
        return activity;
    }

    public List<T> getUserList() {
        return userList;
    }
}
