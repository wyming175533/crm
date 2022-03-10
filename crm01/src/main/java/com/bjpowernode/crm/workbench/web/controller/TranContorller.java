package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.settings.service.impl.UserServiceImpl;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.PrintJson;
import com.bjpowernode.crm.utils.ServiceFactory;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.bjpowernode.crm.workbench.service.Impl.CustomerServiceImpl;
import com.bjpowernode.crm.workbench.service.Impl.TranServiceImpl;
import com.bjpowernode.crm.workbench.service.TranService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class TranContorller extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String path=request.getServletPath();
        if("/workbench/transaction/create.do".equals(path)){
            create(request,response);
        }else if("/workbench/transaction/getCustomerName.do".equals(path)){
            getCustomerName(request,response);
        }
        else if("/workbench/transaction/save.do".equals(path)){
            save(request,response);
        }

    }

    private void save(HttpServletRequest request, HttpServletResponse response) throws IOException {
        CustomerService cs= (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        String customerName=request.getParameter("customerName");

        String customerId=cs.getCustomerIdByname(customerName);

        String id= UUIDUtil.getUUID();
        String owner=request.getParameter("owner");
        String money=request.getParameter("money");
        String name=request.getParameter("name");
        String expectedDate=request.getParameter("expectedDate");
        String stage =request.getParameter("stage");
        String type=request.getParameter("type");
        String source=request.getParameter("source");
        String activityId=request.getParameter("activityId");
        String contactsId =request.getParameter("contactsId");
        User user= (User) request.getSession().getAttribute("user");
        String createBy=user.getName();
        String createTime = DateTimeUtil.getSysTime();
        String description=request.getParameter("description");
        String contactSummary=request.getParameter("contactSummary");
        String nextContactTime=request.getParameter("nextContactTime");
        Tran t=new Tran();

        t.setActivityId(activityId);
        t.setCreateBy(createBy);
        t.setCreateTime(createTime);
        t.setExpectedDate(expectedDate);
        t.setStage(stage);
        t.setId(id);
        t.setMoney(money);
        t.setName(name);
        t.setSource(source);
        t.setOwner(owner);
        t.setNextContactTime(nextContactTime);
        t.setDescription(description);
        t.setCustomerId(customerId);
        t.setContactSummary(contactSummary);
        t.setType(type);
        t.setContactsId(contactsId);
        TranService ts= (TranService) ServiceFactory.getService(new TranServiceImpl());

        Boolean flag=ts.save(t,customerName);
        if(flag){
            response.sendRedirect(request.getContextPath()+"/workbench/transaction/index.jsp");
        }else{
            System.out.println("创建交易失败");
        }


    }

    private void getCustomerName(HttpServletRequest request, HttpServletResponse response) {
        CustomerService cs= (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        String name=request.getParameter("name");
        List<String> names=cs.getCustomerName(name);
        PrintJson.printJsonObj(response,names);

    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us= (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> list=us.getUsers();
        request.setAttribute("userList",list);
        request.getRequestDispatcher("/workbench/transaction/save.jsp").forward(request,response);

    }
}
