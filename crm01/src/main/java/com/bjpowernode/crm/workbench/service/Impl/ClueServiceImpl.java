package com.bjpowernode.crm.workbench.service.Impl;

import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.workbench.dao.ClueDao;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.service.ClueService;

public class ClueServiceImpl implements ClueService {
    ClueDao clueDao= SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);

    @Override
    public Boolean save(Clue c) {
        Boolean flag=false;
        flag=clueDao.save(c);
        return flag;
    }

    @Override
    public Clue detail(String id) {
        Clue c=clueDao.getClue(id);
        System.out.println("Service Impl===================");
        System.out.println(c);
        return c;
    }
}
