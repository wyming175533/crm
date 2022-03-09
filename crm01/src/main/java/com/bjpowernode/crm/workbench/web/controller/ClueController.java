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
import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.bjpowernode.crm.workbench.service.Impl.ActivityServiceImpl;
import com.bjpowernode.crm.workbench.service.Impl.ClueServiceImpl;
import com.bjpowernode.crm.workbench.vo.pagInActionVo;

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
        }else if("/workbench/clue/relation.do".equals(path)){
            relation(request,response);
        }else if("/workbench/clue/searchActivityByName.do".equals(path)) {
            searchActivityByName(request,response);
        }
        else if("/workbench/clue/convert.do".equals(path)){
            convert(request,response);
        }else if("/workbench/clue/pageList.do".equals(path)){
            pagelist(request,response);
        }

    }

    private void pagelist(HttpServletRequest request, HttpServletResponse response) {
        String fullname =request.getParameter("fullname");
        String phone =request.getParameter("phone");
        String mphone =request.getParameter("mphone");
        String company =request.getParameter("company");
        String owner =request.getParameter("owner");
        String state=request.getParameter("state");
        String source =request.getParameter("source");
        String pageSizestr=request.getParameter("pageSize");
        String pageNostr=request.getParameter("pageNo");

        Integer pageSize=Integer.valueOf(pageSizestr);//每页数量
        Integer pageNo=Integer.valueOf(pageNostr);//第几页
        Integer skipCount=(pageNo-1)*pageSize;//略过条数
        Map<String,Object> map=new HashMap<>();
        map.put("pageSize",pageSize);
        map.put("skipCount",skipCount);
        map.put("fullname",fullname);
        map.put("phone",phone);
        map.put("mohone",mphone);
        map.put("company",company);
        map.put("owner",owner);
        map.put("state",state);
        map.put("source",source);

        ClueService cs= (ClueService) ServiceFactory.getService(new ClueServiceImpl());

        pagInActionVo<Clue> vo =cs.pagelist(map);
        PrintJson.printJsonObj(response,vo);
    }

    private void convert(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        String clueId=request.getParameter("clueId");

        String flag=request.getParameter("flag");
        Tran t=null;
        User user=  (User) request.getSession().getAttribute("user");
        String createBy=user.getName();
        if("true".equals(flag)){//需要创建交易
            String money =request.getParameter("money");
            String name  =request.getParameter("name");
            String expectedDate =request.getParameter("expectedDate");
            String stage =request.getParameter("stage");
            String activityId =request.getParameter("stage");
            String id=UUIDUtil.getUUID();
            String createTime=DateTimeUtil.getSysTime();
            System.out.println("需要交易。。。。。。。。。。。。");
            t=new Tran();

            t.setActivityId(activityId);
            t.setCreateBy(createBy);
            t.setCreateTime(createTime);
            t.setExpectedDate(expectedDate);
            t.setStage(stage);
            t.setId(id);
            t.setMoney(money);
            t.setName(name);
        }
        ClueService cs= (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Boolean f=cs.convert(clueId,t,createBy);
        response.sendRedirect(request.getContextPath()+"/workbench/clue/index.jsp");

    }

    private void searchActivityByName(HttpServletRequest request, HttpServletResponse response) {

        ActivityService as= (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        String name=request.getParameter("name");

        List<Activity> activities=as.searchActivityByName(name);
        PrintJson.printJsonObj(response,activities);

    }

    private void relation(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("关联中...");
        String[] ids=request.getParameterValues("id");
        ClueService cs= (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        String clueId=request.getParameter("clueId");
        List<ClueActivityRelation> list=new ArrayList<>();
        for(String activityId:ids){
            ClueActivityRelation cl=new ClueActivityRelation();
            cl.setActivityId(activityId);
            cl.setClueId(clueId);
            cl.setId(UUIDUtil.getUUID());
            list.add(cl);
        }
        Boolean flag=cs.relation(list);
        PrintJson.printJsonFlag(response,flag);


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
