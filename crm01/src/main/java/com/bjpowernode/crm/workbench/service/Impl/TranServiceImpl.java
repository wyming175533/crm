package com.bjpowernode.crm.workbench.service.Impl;

import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.dao.CustomerDao;
import com.bjpowernode.crm.workbench.dao.TranDao;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.service.TranService;

public class TranServiceImpl  implements TranService {
    private  TranDao tranDao=SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private CustomerDao customerDao=SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);

    @Override
    public Boolean save(Tran t,String customerName) {
        Boolean flag=true;
        if(t.getCustomerId()==null){
            Customer customer=new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(t.getOwner());
            customer.setName(customerName);
            customer.setCreateBy(t.getCreateBy());
            customer.setCreateTime(t.getCreateTime());
            customer.setDescription(t.getDescription());
            customer.setContactSummary(t.getContactSummary());
            customer.setNextContactTime(t.getNextContactTime());
            int count2=customerDao.createCustomer(customer);
            if(count2<0){flag=false;
                System.out.println("创建客户失败");}
        }

        int count=tranDao.createTran(t);
        if(count<0){
            flag=false;
        }
        return flag;
    }
}
