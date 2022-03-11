package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

public interface TranDao {

    int createTran(Tran t);

    Tran detail(String id);

    List<TranHistory> showHistoryByTranId(String tranId);

    int changeStage(Tran t);

    int getTotal();

    List<Map<String, Object>> getChars();
}
