package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Customer;

import java.util.List;

public interface CustomerDao {

    Customer getCustomerByCompany(String name);

    int createCustomer(Customer customer);

    List<String> getCustomerName(String name);

    String getCustomerIdByname(String customerName);
}
