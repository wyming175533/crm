package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.dao.UserDao;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.myexception.loginexception;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.SqlSessionUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public User login(String loginAct, String loginPwd, String ip) throws loginexception {
        Map<String,String> map=new HashMap<>();
        map.put("loginAct",loginAct);
        map.put("loginPwd",loginPwd);
        User user=userDao.login(map);

        if (user == null) {
           throw new loginexception("用户信息错误");
        }

        if(DateTimeUtil.getSysTime().compareTo(user.getExpireTime())>0){
            throw new loginexception("用户信息已过期");

        }
        if(!user.getAllowIps().contains(ip)){
            throw new loginexception("该ip禁止访问");
        }
        if("0".equals(user.getLockState())){
            throw new loginexception("用户已锁定");
        }

        return user;
    }

    @Override
    public List<User> getUsers() {
        List<User> users=new ArrayList<>();
        users=userDao.getUsers();
        return  users;
    }
}
