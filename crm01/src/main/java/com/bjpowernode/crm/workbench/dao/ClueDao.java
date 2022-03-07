package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Clue;

public interface ClueDao {


    Boolean save(Clue c);

    Clue getClue(String id);
}
