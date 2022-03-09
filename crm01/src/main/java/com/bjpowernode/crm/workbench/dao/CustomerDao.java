package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Customer;

public interface CustomerDao {

    Customer getCustomerByCompany(String name);

    int createCustomer(Customer customer);
}
