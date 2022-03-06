package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.ActivityRemark;
import com.bjpowernode.crm.workbench.vo.pagInActionVo;

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

    Boolean updateRemark(ActivityRemark activityRemark);
}
