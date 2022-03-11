package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranDao {

    int createTran(Tran t);

    Tran detail(String id);

    List<TranHistory> showHistoryByTranId(String tranId);

    int changeStage(Tran t);
}
