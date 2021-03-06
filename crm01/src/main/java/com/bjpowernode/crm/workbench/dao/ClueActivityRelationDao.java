package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;
import com.bjpowernode.crm.workbench.domain.ContactsActivityRelation;

import java.util.List;

public interface ClueActivityRelationDao {


    int removeRelationById(String id);

    int relation(List<ClueActivityRelation> list);

    List<String> getActivityIds(String clueId);

    int deleteCAR(String clueId);


}
