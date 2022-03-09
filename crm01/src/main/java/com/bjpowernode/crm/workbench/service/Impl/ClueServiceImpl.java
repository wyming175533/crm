package com.bjpowernode.crm.workbench.service.Impl;

import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.workbench.dao.ClueActivityRelationDao;
import com.bjpowernode.crm.workbench.dao.ClueDao;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.service.ClueService;


import java.util.List;

public class ClueServiceImpl implements ClueService {
    ClueDao clueDao= SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);
    ClueActivityRelationDao clueActivityRelationDao=SqlSessionUtil.getSqlSession().getMapper(ClueActivityRelationDao.class);
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

    @Override
    public Boolean removeRelationById(String id) {
        Boolean flag=false;
        int i=clueActivityRelationDao.removeRelationById(id);
        if(i>0){
            flag=true;
        }

        return flag;
    }

    @Override
    public Boolean relation(List<ClueActivityRelation> list) {
        Boolean flag=true;
        int num=clueActivityRelationDao.relation(list);
        if(num<0)
            flag=false;
        return flag;
    }

    @Override
    public Boolean convert(String clueId, Tran t, String createBy) {
        /**
         *          (1) 获取到线索id，通过线索id获取线索对象（线索对象当中封装了线索的信息）
         * 			(2) 通过线索对象提取客户信息，当该客户不存在的时候，新建客户（根据公司的名称精确匹配，判断该客户是否存在！）
         * 			(3) 通过线索对象提取联系人信息，保存联系人
         * 			(4) 线索备注转换到客户备注以及联系人备注
         * 			(5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
         * 			(6) 如果有创建交易需求，创建一条交易
         * 			(7) 如果创建了交易，则创建一条该交易下的交易历史
         * 			(8) 删除线索备注
         * 			(9) 删除线索和市场活动的关系
         * 			(10) 删除线索
         */
        //(1) 获取到线索id，通过线索id获取线索对象（线索对象当中封装了线索的信息）
        Clue clue=clueDao.getClue(clueId);

        return null;
    }


}
