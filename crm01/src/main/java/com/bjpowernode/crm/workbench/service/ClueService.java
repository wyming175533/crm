package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.vo.pagInActionVo;

import java.util.List;
import java.util.Map;

public interface ClueService {
    Boolean save(Clue c);

    Clue detail(String id);

    Boolean removeRelationById(String id);

    Boolean relation(List<ClueActivityRelation> list);

    Boolean convert(String clueId, Tran t, String createBy);

    pagInActionVo<Clue> pagelist(Map<String, Object> map);
}
