package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.ActivityRemark;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.workbench.service.Impl.ActivityServiceImpl;
import com.bjpowernode.crm.settings.service.impl.UserServiceImpl;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.PrintJson;
import com.bjpowernode.crm.utils.ServiceFactory;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.vo.lodInActionVo;
import com.bjpowernode.crm.workbench.vo.pagInActionVo;



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

        if("/workbench/activity/getUserList.do".equals(path)){//获取所有者清单
            getUserList(request,response);
        }
         else if ("/workbench/activity/save.do".equals(path)){//保存活动创建
             save(request,response);
        }else if("/workbench/activity/pageList.do".equals(path)){//查询局部刷新
             pageList(request,response);

        }else if("/workbench/activity/delete.do".equals(path)){//删除市场活动项
             delete(request,response);
        }else if("/workbench/activity/getUserListAndActivity.do".equals(path)){//获取用户列表和活动信息
             getUserListAndActivity(request,response);
        }else if("/workbench/activity/update.do".equals(path)){
             update(request,response);
        }else if ("/workbench/activity/detail.do".equals(path)){
             detail(request,response);
        }else if ("/workbench/activity/getRemarkListById.do".equals(path)){
            getRemarkListById(request,response);
        }
         else if("/workbench/activity/deleteRemark.do".equals(path)){
             deleteRemark(request,response);
        }else if("/workbench/activity/saveRemark.do".equals(path)){
            System.out.println("save------------------------=============");
            saveRemark(request,response);
        }
        else if("/workbench/activity/updateRemark.do".equals(path)){
            System.out.println("update------------------------=============");
            updateRemark(request,response);
        }
    }

    private void updateRemark(HttpServletRequest request, HttpServletResponse response) {
        String id=request.getParameter("id");
        String noteContent=request.getParameter("noteContent");
        String editTime=DateTimeUtil.getSysTime();
        User user= (User) request.getSession().getAttribute("user");
        String editBy=user.getName();
        String editFlag ="1";

        ActivityRemark activityRemark=new ActivityRemark();
        activityRemark.setEditFlag(editFlag);
        activityRemark.setEditBy(editBy);
        activityRemark.setEditTime(editTime);
        activityRemark.setId(id);
        activityRemark.setNoteContent(noteContent);

        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Boolean flag=as.updateRemark(activityRemark);
        Map<String,Object> map=new HashMap<>();

        map.put("success",flag);
        map.put("ar",activityRemark);

        PrintJson.printJsonObj(response,map);
    }

    private void saveRemark(HttpServletRequest request, HttpServletResponse response) {
        String activityId=request.getParameter("id");
        String noteContent=request.getParameter("noteContent");
        User user= (User) request.getSession().getAttribute("user");
        String createBy=user.getName();
        String createTime=DateTimeUtil.getSysTime();
        String editFlag ="0";
        String id=UUIDUtil.getUUID();

        ActivityRemark activityRemark=new ActivityRemark();
        activityRemark.setActivityId(activityId);
        activityRemark.setCreateBy(createBy);
        activityRemark.setCreateTime(createTime);
        activityRemark.setId(id);
        activityRemark.setEditFlag(editFlag);
        activityRemark.setNoteContent(noteContent);

        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Boolean flag=as.saveRemark(activityRemark);
        Map<String,Object> map=new HashMap<>();

        map.put("success",flag);
        map.put("ar",activityRemark);

        PrintJson.printJsonObj(response,map);

    }

    private void deleteRemark(HttpServletRequest request, HttpServletResponse response) {
        String id=request.getParameter("id");
        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Boolean flag=as.deleteRemark(id);
        PrintJson.printJsonFlag(response,flag);


    }

    private void getRemarkListById(HttpServletRequest request, HttpServletResponse response) {
        String id=request.getParameter("id");
        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<ActivityRemark> a=as.getRemarkListById(id);
        PrintJson.printJsonObj(response,a);

    }

    private void detail(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String id=request.getParameter("id");
        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Activity a=as.detail(id);
        request.setAttribute("a",a);
        request.getRequestDispatcher("/workbench/activity/detail.jsp").forward(request,response);//转发是内部路径，不用写项目名


    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        String uname=request.getParameter("username");
        String id=request.getParameter("id");
        String owner=request.getParameter("owner");
        String name=request.getParameter("name");
        String startDate=request.getParameter("startDate");
        String endDate=request.getParameter("endDate");
        String cost=request.getParameter("cost");
        String description=request.getParameter("description");
        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Activity activity=new Activity();

        activity.setCost(cost);
        activity.setDescription(description);
        activity.setEditBy(uname);
        activity.setEditTime(DateTimeUtil.getSysTime());
        activity.setId(id);
        activity.setEndDate(endDate);
        activity.setStartDate(startDate);
        activity.setName(name);
        activity.setOwner(owner);

        Boolean flag=as.update(activity);
        PrintJson.printJsonFlag(response,flag);


    }

    private void getUserListAndActivity(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("获取用户信息列表和市场活动信息中....");

        String id=request.getParameter("id");

        List<User> users=new ArrayList<>();
        UserService userService= (UserService) ServiceFactory.getService(new UserServiceImpl());
        users=userService.getUsers();

        lodInActionVo<User> vo=new lodInActionVo();
        vo.setUserList(users);

        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Activity activity=as.getActivity(id);
        vo.setActivity(activity);
        PrintJson.printJsonObj(response,vo);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("删除中，，，，，，，，，，");
        Boolean flag=false;
        String[] ids=request.getParameterValues("id");
        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        flag=as.delete(ids);
        PrintJson.printJsonFlag(response,flag);

    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("进入查询市场活动");

        String name=request.getParameter("name");
        String owner=request.getParameter("owner");
        String pageSizestr=request.getParameter("pageSize");
        String pageNostr=request.getParameter("pageNo");
        String startDate=request.getParameter("startDate");
        String endDate=request.getParameter("endDate");

        Integer pageSize=Integer.valueOf(pageSizestr);
        Integer pageNo=Integer.valueOf(pageNostr);
        System.out.println(pageSize);
        System.out.println(pageNo+"====================================================---------------------------");
        Integer skipCount=(pageNo-1)*pageSize;

        Map<String,Object> map=new HashMap<>();

        map.put("name",name);
        map.put("owner",owner);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        map.put("pageSize",pageSize);
        map.put("skipCount",skipCount);

        //封装到map中向提交到servie进行处理

        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        System.out.println(map);
        //通过自定义vo类获取返回json
        pagInActionVo<Activity> vo=as.pageList(map);

        PrintJson.printJsonObj(response,vo);


    }

    //市场活动后创建活动保存
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
