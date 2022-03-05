package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.dao.ActivityDao;
import com.bjpowernode.crm.settings.dao.ActivityRemarkDao;
import com.bjpowernode.crm.settings.domain.Activity;
import com.bjpowernode.crm.settings.service.ActivityService;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.vo.pagInActionVo;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {
    ActivityDao activityDao=SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);
    ActivityRemarkDao activityRemarkDao=SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkDao.class);
    @Override
    public Boolean save(Activity activity) {
        Boolean flag=false;
        Integer num=activityDao.save(activity);
        if(num!=-1){flag=true;}
        return flag;

    }

    @Override
    public pagInActionVo<Activity> pageList(Map<String, Object> map) {
        int total=activityDao.getTotalByendition(map);//获取total总条数
        List<Activity> activities=activityDao.getActivityListByCondition(map);//获取活动详情信息
        pagInActionVo<Activity> vo=new pagInActionVo<>();
        vo.setTotal(total);
        vo.setDatalist(activities);
        return vo;
    }

    @Override
    public Boolean delete(String[] ids) {
        Boolean flag=true;
        //判断备注数据库删除的条数
        int count=activityRemarkDao.getDeleteRemarkCount(ids);
        //判断实际删除的条数
        int num=activityRemarkDao.DeleteRemarkCount(ids);
        //判断是否相等
        if(num!=count)
            flag=false;
        //删除市场活动表
        int count2=activityDao.getDeleteActivityCount(ids);
        //实际删除市场活动的条数
        int num2=activityDao.DeleteActivityCount(ids);
        if(num2!=count2)
            flag=false;

        return flag;
    }
}
