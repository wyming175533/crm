package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.dao.ActivityDao;
import com.bjpowernode.crm.settings.domain.Activity;
import com.bjpowernode.crm.settings.service.ActivityService;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.vo.pagInActionVo;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {
    ActivityDao activityDao=SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);
    @Override
    public Boolean save(Activity activity) {
        Boolean flag=false;
        int num=activityDao.save(activity);
        if(num!=-1){flag=true;}
        return flag;

    }

    @Override
    public pagInActionVo<Activity> pageList(Map<String, Object> map) {
        int total=activityDao.getTotalByendition(map);
        List<Activity> activities=activityDao.getActivityListByCondition(map);
        pagInActionVo<Activity> vo=new pagInActionVo<>();
        vo.setTotal(total);
        vo.setDatalist(activities);
        return vo;
    }
}
