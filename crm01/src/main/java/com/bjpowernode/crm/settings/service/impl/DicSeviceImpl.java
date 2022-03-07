package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.dao.DicTypeDao;
import com.bjpowernode.crm.settings.dao.DicVlueDao;
import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import com.bjpowernode.crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DicSeviceImpl implements DicService {
    DicTypeDao dicTypeDao= SqlSessionUtil.getSqlSession().getMapper(DicTypeDao.class);
    DicVlueDao dicVlueDao= SqlSessionUtil.getSqlSession().getMapper(DicVlueDao.class);

    @Override
    public Map<String, List<DicValue>> getAll() {
        Map<String, List<DicValue>> map =new HashMap<>();
        List<String> dicType=dicTypeDao.getTypes();
        for(String type:dicType){
            List<DicValue> list=dicVlueDao.getDicValueByTypeCode(type);
            map.put(type+"List",list);
        }

        return map;
    }
}
