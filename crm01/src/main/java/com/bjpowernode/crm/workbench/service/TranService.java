package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Tran;

public interface TranService {
    Boolean save(Tran t,String customerName);
}
