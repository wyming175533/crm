package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranService {
    Boolean save(Tran t,String customerName);

    Tran detail(String id);

    List<TranHistory> showHistoryByTranId(String tranId);

    Boolean changeStage(Tran t);
}
