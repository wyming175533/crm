package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.domain.Activity;
import com.bjpowernode.crm.settings.domain.ActivityRemark;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.vo.lodInActionVo;
import com.bjpowernode.crm.vo.pagInActionVo;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    Boolean save(Activity activity);

    pagInActionVo<Activity> pageList(Map<String, Object> map);

    Boolean delete(String[] ids);


    Activity getActivity(String id);

    Boolean update(Activity activity);

    Activity detail(String id);

    List<ActivityRemark> getRemarkListById(String id);

    Boolean deleteRemark(String id);

    Boolean saveRemark(ActivityRemark activityRemark);
}
