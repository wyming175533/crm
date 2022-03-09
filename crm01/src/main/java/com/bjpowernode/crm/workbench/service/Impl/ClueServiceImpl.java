package com.bjpowernode.crm.workbench.service.Impl;

import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.dao.*;
import com.bjpowernode.crm.workbench.domain.*;
import com.bjpowernode.crm.workbench.service.ClueService;


import java.util.List;

public class ClueServiceImpl implements ClueService {
    //线索相关
    private ClueDao clueDao= SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);
    private ClueActivityRelationDao clueActivityRelationDao=SqlSessionUtil.getSqlSession().getMapper(ClueActivityRelationDao.class);
    private ClueRemarkDao  clueRemarkDao= SqlSessionUtil.getSqlSession().getMapper(ClueRemarkDao.class);
    //客户相关
    private CustomerDao customerDao=SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    private CustomerRemarkDao customerRemarkDao=SqlSessionUtil.getSqlSession().getMapper(CustomerRemarkDao.class);

    //联系人
    private ContactsDao contactsDao=SqlSessionUtil.getSqlSession().getMapper(ContactsDao.class);
    private ContactsRemarkDao contactsRemarkDao= SqlSessionUtil.getSqlSession().getMapper(ContactsRemarkDao.class);
    //交易相关
    private  TranDao tranDao=SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private  TranHistoryDao tranHistoryDao=SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);

    @Override
    public Boolean save(Clue c) {
        Boolean flag=false;
        flag=clueDao.save(c);
        return flag;
    }

    @Override
    public Clue detail(String id) {
        Clue c=clueDao.getClue(id);
        System.out.println("Service Impl===================");
        System.out.println(c);
        return c;
    }

    @Override
    public Boolean removeRelationById(String id) {
        Boolean flag=false;
        int i=clueActivityRelationDao.removeRelationById(id);
        if(i>0){
            flag=true;
        }

        return flag;
    }

    @Override
    public Boolean relation(List<ClueActivityRelation> list) {
        Boolean flag=true;
        int num=clueActivityRelationDao.relation(list);
        if(num<0)
            flag=false;
        return flag;
    }

    @Override
    public Boolean convert(String clueId, Tran t, String createBy) {
        Boolean flag=true;
        /**
         *          (1) 获取到线索id，通过线索id获取线索对象（线索对象当中封装了线索的信息）
         * 			(2) 通过线索对象提取客户信息，当该客户不存在的时候，新建客户（根据公司的名称精确匹配，判断该客户是否存在！）
         * 			(3) 通过线索对象提取联系人信息，保存联系人
         * 			(4) 线索备注转换到客户备注以及联系人备注
         * 			(5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
         * 			(6) 如果有创建交易需求，创建一条交易
         * 			(7) 如果创建了交易，则创建一条该交易下的交易历史
         * 			(8) 删除线索备注
         * 			(9) 删除线索和市场活动的关系
         * 			(10) 删除线索
         */
        //(1) 获取到线索id，通过线索id获取线索对象（线索对象当中封装了线索的信息）
        Clue clue=clueDao.getClueById(clueId);
        //(2) 通过线索对象提取客户信息，（根据公司的名称精确匹配，判断该客户是否存在！）
        String companyName=clue.getCompany();
        Customer customer=customerDao.getCustomerByCompany(companyName);
        if(customer==null){
            //当该客户不存在的时候，新建客户
            customer=new Customer();
            customer.setAddress(clue.getAddress());
            customer.setContactSummary(clue.getContactSummary());
            customer.setCreateBy(createBy);
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setDescription(clue.getDescription());
            customer.setId(UUIDUtil.getUUID());
            customer.setName(companyName);
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setOwner(clue.getOwner());
            customer.setPhone(clue.getPhone());
            customer.setWebsite(clue.getWebsite());
            int createCustomerNum=customerDao.createCustomer(customer);
            if(createCustomerNum<0) {flag=false;
                System.out.println("创建用户失败");}//创建失败

        }

        //(3) 通过线索对象提取联系人信息，保存联系人
        Contacts contacts=new Contacts();
        if(true){

        contacts.setAddress(clue.getAddress());
        contacts.setAppellation(clue.getAppellation());
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setCreateBy(createBy);
        contacts.setCreateTime(DateTimeUtil.getSysTime());
        contacts.setCustomerId(customer.getId());
        contacts.setDescription(customer.getDescription());
        contacts.setEmail(clue.getEmail());
        contacts.setFullname(clue.getFullname());
        contacts.setId(UUIDUtil.getUUID());
        contacts.setJob(clue.getJob());
        contacts.setMphone(clue.getMphone());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setOwner(clue.getOwner());
        contacts.setSource(clue.getSource());
        int createContactsNum=contactsDao.createContacts(contacts);
        if(createContactsNum<0){flag=false;
            System.out.println("联系人创建失败");}
        }
        //(4) 线索备注转换到客户备注以及联系人备注
        List<ClueRemark> clueRemarks=clueRemarkDao.selectClueRemarkById(clueId);
        for(ClueRemark clueRemark :clueRemarks){
            String noteContent=clueRemark.getNoteContent();//取出联系人备注信息

            //创建客户备注对象，添加客户备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateBy(createBy);
            customerRemark.setCreateTime(DateTimeUtil.getSysTime());
            customerRemark.setCustomerId(customer.getId());
            customerRemark.setEditFlag("0");
            customerRemark.setNoteContent(noteContent);
            int createCustomerRemarkNum = customerRemarkDao.createCustomerRemark(customerRemark);
            if(createCustomerRemarkNum<0){
                flag = false;
                System.out.println("创建顾客备注失败");
            }

            //创建联系人备注对象，添加联系人
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setCreateTime(DateTimeUtil.getSysTime());
            contactsRemark.setContactsId(contacts.getId());
            contactsRemark.setEditFlag("0");
            contactsRemark.setNoteContent(noteContent);
            int createContactsRemarkNum = contactsRemarkDao.createContactsRemark(contactsRemark);
            if(createContactsRemarkNum<0){
                flag = false;
                System.out.println("创建联系人备注失败");
            }

        }
      //  (5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
        List<String> activityIds=clueActivityRelationDao.getActivityIds(clueId);
        ContactsActivityRelation cARelation=new ContactsActivityRelation();
        for(String activityId:activityIds){
            cARelation.setId(UUIDUtil.getUUID());
            cARelation.setActivityId(activityId);
            cARelation.setContactsId(contacts.getId());
        }
        //(6) 如果有创建交易需求，创建一条交易
        if(t!=null){
          int createTranNum=tranDao.createTran(t);
          if(createTranNum<0){
              flag=false;
              System.out.println("创建交易失败");
          }

          //(7) 如果创建了交易，则创建一条该交易下的交易历史
            TranHistory tranHistory=new TranHistory();
            tranHistory.setCreateBy(createBy);
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


        }
        //(8) 删除线索备注
       int deleteClueR=clueRemarkDao.deleteClueRemark(clueId);
        if(deleteClueR<0){
            flag=false;
            System.out.println("删除线索备注失败");
        }

        //(9) 删除线索和市场活动的关系
        int deleteCARNum=clueActivityRelationDao.deleteCAR(clueId);
        if(deleteCARNum<0){
            flag=false;
            System.out.println("删除线索市场活动表失败");
        }
        //	(10) 删除线索
        int deleteClueNum=clueDao.deleteClue(clueId);
        if(deleteClueNum<0){
            flag=false;
            System.out.println("删除线索表失败");
        }
        return flag;
    }


}
