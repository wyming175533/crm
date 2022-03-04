package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.domain.Activity;
import com.bjpowernode.crm.vo.pagInActionVo;

import java.util.Map;

public interface ActivityService {
    Boolean save(Activity activity);

    pagInActionVo<Activity> pageList(Map<String, Object> map);
}
