package com.bjpowernode.crm.settings.web.controller;

import com.bjpowernode.crm.settings.domain.Activity;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.ActivityService;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.settings.service.impl.ActivityServiceImpl;
import com.bjpowernode.crm.settings.service.impl.UserServiceImpl;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.PrintJson;
import com.bjpowernode.crm.utils.ServiceFactory;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.vo.pagInActionVo;
import org.apache.ibatis.session.SqlSessionFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityController extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path=request.getServletPath();
        System.out.println("????????????????????");
        if("/workbench/activity/getUserList.do".equals(path)){
            getUserList(request,response);
        }
         else if ("/workbench/activity/save.do".equals(path)){
             save(request,response);
        }else if("/workbench/activity/pageList.do".equals(path)){
            System.out.println("查询市场活动");
             pageList(request,response);

        }
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("查询市场活动");

        String name=request.getParameter("name");
        String owner=request.getParameter("owner");
        String pageSizestr=request.getParameter("pageSize");
        String pageNostr=request.getParameter("pageNo");
        String startDate=request.getParameter("startDate");
        String endDate=request.getParameter("endDate");

        Integer pageSize=Integer.parseInt(pageSizestr);
        Integer pageNo=Integer.parseInt(pageNostr);
        int skipCount=(pageNo-1)*pageSize;

        Map<String,Object> map=new HashMap<>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        map.put("pageSize",pageSize);
        map.put("skipCount",skipCount);

        //封装到map中向提交到servie进行处理

        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        pagInActionVo<Activity> vo=as.pageList(map);
        PrintJson.printJsonObj(response,vo);


    }


    private void save(HttpServletRequest request, HttpServletResponse response) {

        Boolean flag=false;
        String id= UUIDUtil.getUUID();
        String owner=request.getParameter("owner");
        String name=request.getParameter("name");
        String startDate=request.getParameter("startDate");
        String endDate=request.getParameter("endDate");
        String cost=request.getParameter("cost");
        String description=request.getParameter("description");
        User user= (User) request.getSession().getAttribute("user");
        String createBy=user.getName();

        Activity activity=new Activity();
        activity.setCost(cost);
        activity.setCreateBy(createBy);
        activity.setCreateTime(DateTimeUtil.getSysTime());
        activity.setDescription(description);
        activity.setStartDate(startDate);
        activity.setEndDate(endDate);
        activity.setId(id);
        activity.setName(name);
        activity.setOwner(owner);

        ActivityService activityService= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        flag=activityService.save(activity);
        PrintJson.printJsonFlag(response,flag);
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        List<User> users=new ArrayList<>();
        UserService userService= (UserService) ServiceFactory.getService(new UserServiceImpl());
        users=userService.getUsers();
        PrintJson.printJsonObj(response,users);
    }
}
