package com.bjpowernode.crm.workbench.service.Impl;

import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.workbench.dao.ClueDao;
import com.bjpowernode.crm.workbench.service.ClueService;

public class ClueServiceImpl implements ClueService {
    ClueDao clueDao= SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);
}
