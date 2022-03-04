package com.bjpowernode.crm.settings.web.controller;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.settings.service.impl.UserServiceImpl;
import com.bjpowernode.crm.utils.MD5Util;
import com.bjpowernode.crm.utils.PrintJson;
import com.bjpowernode.crm.utils.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class UserController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path=request.getServletPath();

        if("/Settings/user/login.do".equals(path)){
        login(request,response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) {
        String loginAct=request.getParameter("loginAct");
        String loginPwd=request.getParameter("loginPwd");

        loginPwd= MD5Util.getMD5(loginPwd);//获取经过MD5加密后的密码
        String ip=request.getRemoteAddr();//获取访问ip

        //业务层开发统一要用代理类接口对象
        UserService us= (UserService) ServiceFactory.getService(new UserServiceImpl());
        try{
            User user= us.login(loginAct,loginPwd,ip);
            request.getSession().setAttribute("user",user);
            PrintJson.printJsonFlag(response,true);
            User users = (User)request.getSession().getAttribute("user");
            System.out.println(users.getName()+"---------------");
        }catch (Exception e){
            e.printStackTrace();
            String msg=e.getMessage();
            System.out.println(msg);
            Map<String,Object> map=new HashMap<>();
            map.put("success",false);
            map.put("msg",msg);
            PrintJson.printJsonObj(response,map);
        }
    }
}
