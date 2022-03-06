package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityRemarkDao {
   int getDeleteRemarkCount(String[] ids);

    int DeleteRemarkCount(String[] ids);

    List<ActivityRemark> getRemarkListById(String id);

    int deleteRemarkById(String id);

    int saveRemark(ActivityRemark activityRemark);

    int updateRemark(ActivityRemark activityRemark);
}
