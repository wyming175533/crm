package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;
import com.bjpowernode.crm.workbench.domain.Tran;

import java.util.List;

public interface ClueService {
    Boolean save(Clue c);

    Clue detail(String id);

    Boolean removeRelationById(String id);

    Boolean relation(List<ClueActivityRelation> list);

    Boolean convert(String clueId, Tran t, String createBy);
}
