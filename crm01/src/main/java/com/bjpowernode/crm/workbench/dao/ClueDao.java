package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Clue;

import java.util.List;
import java.util.Map;

public interface ClueDao {


    Boolean save(Clue c);

    Clue getClue(String id);

    Clue getClueById(String clueId);

    int deleteClue(String id);

    int getTotalByendition(Map<String, Object> map);

    List<Clue> getActivityListByCondition(Map<String, Object> map);
}
