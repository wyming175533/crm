package com.bjpowernode.crm.workbench.service.Impl;

import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.dao.CustomerDao;
import com.bjpowernode.crm.workbench.dao.TranDao;
import com.bjpowernode.crm.workbench.dao.TranHistoryDao;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;
import com.bjpowernode.crm.workbench.service.TranService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TranServiceImpl  implements TranService {
    private  TranDao tranDao=SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private CustomerDao customerDao=SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    private TranHistoryDao tranHistoryDao=SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);

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


        TranHistory tranHistory=new TranHistory();
        tranHistory.setCreateBy(t.getCreateBy());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(t.getExpectedDate());
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setMoney(t.getMoney());
        tranHistory.setStage(t.getStage());
        tranHistory.setTranId(t.getId());

        int createTHNum=tranHistoryDao.createTranHistory(tranHistory);
        if(createTHNum<0){
            flag=false;
            System.out.println("创建交易历史失败");
        }

        return flag;
    }

    @Override
    public Tran detail(String id) {
        Tran t=tranDao.detail(id);

        return t;
    }

    @Override
    public List<TranHistory> showHistoryByTranId(String tranId) {
        List<TranHistory> trans=tranDao.showHistoryByTranId(tranId);
        return trans;
    }

    @Override
    public Boolean changeStage(Tran t) {
        //根据id对交易进行更新操作
        Boolean flag=true;
        int count=tranDao.changeStage(t);
        if(count<0){
            flag=false;
            System.out.println("修改交易失败");
        }

        TranHistory tranHistory=new TranHistory();
        tranHistory.setCreateBy(t.getCreateBy());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(t.getExpectedDate());
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setMoney(t.getMoney());
        tranHistory.setStage(t.getStage());
        tranHistory.setTranId(t.getId());
        tranHistory.setPossibility(t.getPossibility());
        int createTHNum=tranHistoryDao.createTranHistory(tranHistory);
        if(createTHNum<0){
            flag=false;
            System.out.println("创建交易历史失败");
        }
        return flag;
    }

    @Override
    public Map<String, Object> getCharts() {
        int total=tranDao.getTotal();
        List<Map<String,Object>> datalist=tranDao.getChars();
        Map<String,Object> map=new HashMap<>();
         map.put("total",total);
         map.put("datalist",datalist);

        return map;
    }
}
