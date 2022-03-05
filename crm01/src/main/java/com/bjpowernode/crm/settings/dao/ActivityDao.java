package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityDao {
    Integer save(Activity activity);

    List<Activity> getActivityListByCondition(Map<String, Object> map);

    Integer getTotalByendition(Map<String, Object> map);

    int getDeleteActivityCount(String[] ids);

    int DeleteActivityCount(String[] ids);
}
