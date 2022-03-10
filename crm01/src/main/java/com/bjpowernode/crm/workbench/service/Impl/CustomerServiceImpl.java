package com.bjpowernode.crm.workbench.service.Impl;

import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.workbench.dao.CustomerDao;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.service.CustomerService;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CustomerServiceImpl implements CustomerService {
private CustomerDao customerDao= SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    @Override
    public List<String> getCustomerName(String name) {
        List<String> names=customerDao.getCustomerName(name);

        return names;
    }

    @Override
    public String getCustomerIdByname(String customerName) {
        String id=customerDao.getCustomerIdByname(customerName);
        return id;
    }
}
