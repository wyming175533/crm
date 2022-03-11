package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

public interface TranService {
    Boolean save(Tran t,String customerName);

    Tran detail(String id);

    List<TranHistory> showHistoryByTranId(String tranId);

    Boolean changeStage(Tran t);

    Map<String, Object> getCharts();
}
