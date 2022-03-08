package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.settings.service.impl.UserServiceImpl;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.PrintJson;
import com.bjpowernode.crm.utils.ServiceFactory;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.bjpowernode.crm.workbench.service.Impl.ActivityServiceImpl;
import com.bjpowernode.crm.workbench.service.Impl.ClueServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.DataInput;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClueController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path=request.getServletPath();
        if("/workbench/clue/getUserList.do".equals(path)){
            getUserList(request,response);
        }
        else if("/workbench/clue/save.do".equals(path)){
            save(request,response);
        }else if("/workbench/clue/detail.do".equals(path)){
            detail(request,response);
        }
        else if("/workbench/clue/ShowActivitysByClueId.do".equals(path)){
            ShowActivitysByClueId(request,response);
        }  else if("/workbench/clue/removeRelationById.do".equals(path)){
            removeRelationById(request,response);
        }else if("/workbench/clue/searchaNoRealtionById.do".equals(path)){
            System.out.println(path);
            searchaNoRealtionById(request,response);
        }

    }

    private void searchaNoRealtionById(HttpServletRequest request, HttpServletResponse response) {
        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        String clueId=request.getParameter("id");
        String name=request.getParameter("name");

        Map<String,String> map=new HashMap<>();
        map.put("id",clueId);
        map.put("name",name);

        List<Activity> activities=as.searchaNoRealtionById(map);
        PrintJson.printJsonObj(response,activities);
    }

    private void removeRelationById(HttpServletRequest request, HttpServletResponse response) {
        String id=request.getParameter("id");
        ClueService cs= (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Boolean flag=cs.removeRelationById(id);
        PrintJson.printJsonFlag(response,flag);

    }

    private void ShowActivitysByClueId(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("展现市场活动中....");
        String id=request.getParameter("clueid");
        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> a= as.ShowActivitysByClueId(id);
        PrintJson.printJsonObj(response,a);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String id=request.getParameter("id");
        ClueService cs= (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Clue c=cs.detail(id);
        request.setAttribute("c",c);
        System.out.println("111");
        System.out.println(c);
        request.getRequestDispatcher("/workbench/clue/detail.jsp").forward(request,response);


    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        String id= UUIDUtil.getUUID();
        String fullname=request.getParameter("fullname");
        String appellation=request.getParameter("appellation");
        String owner=request.getParameter("owner");
        String company=request.getParameter("company");
        String job=request.getParameter("job");
        String email=request.getParameter("email");
        String phone=request.getParameter("phone");
        String website=request.getParameter("website");
        String mphone=request.getParameter("mphone");
        String state=request.getParameter("state");
        String source=request.getParameter("source");

        User user= (User) request.getSession().getAttribute("user");
        String createBy=user.getName();
        String createTime= DateTimeUtil.getSysTime();
        String description =request.getParameter("description");
        String contactSummary=request.getParameter("contactSummary");
        String nextContactTime=request.getParameter("nextContactTime");
        String address=request.getParameter("address");

        Clue c=new Clue();
        c.setAddress(address);
        c.setAppellation(appellation);
        c.setCompany(company);
        c.setContactSummary(contactSummary);
        c.setWebsite(website);
        c.setState(state);
        c.setSource(source);
        c.setPhone(phone);
        c.setOwner(owner);
        c.setNextContactTime(nextContactTime);
        c.setMphone(mphone);
        c.setJob(job);
        c.setId(id);
        c.setFullname(fullname);
        c.setEmail(email);
        c.setDescription(description);
        c.setCreateTime(createTime);
        c.setCreateBy(createBy);

        ClueService cs= (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Boolean flag=cs.save(c);
        PrintJson.printJsonFlag(response,flag);


    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        List<User> users=new ArrayList<>();
        UserService userService= (UserService) ServiceFactory.getService(new UserServiceImpl());
        users=userService.getUsers();
        PrintJson.printJsonObj(response,users);
    }
}
