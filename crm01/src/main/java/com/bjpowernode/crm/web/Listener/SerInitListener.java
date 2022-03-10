package com.bjpowernode.crm.web.Listener;

import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import com.bjpowernode.crm.settings.service.impl.DicSeviceImpl;
import com.bjpowernode.crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

public class SerInitListener  implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("进入了监听器模块..............");
        ServletContext application=servletContextEvent.getServletContext();
        DicService dic= (DicService) ServiceFactory.getService(new DicSeviceImpl());
        /**
         * map:    {"appellationList":appellationList,....}
         */
        Map<String, List<DicValue>> map=dic.getAll();
        Set<String> set=map.keySet();

        for(String key:set){
            System.out.println(key);
            System.out.println(map.get(key));
            application.setAttribute(key,map.get(key));
        }
        //解析Stage2Possibility.properties文件
        Map<String,String> map2=new HashMap<>();
        ResourceBundle rb=ResourceBundle.getBundle("Stage2Possibility");
        Enumeration<String> e=rb.getKeys();//获取属性配置文件的key,返回字符串枚举
        while(e.hasMoreElements()){//采用迭代器的方式，比其它循环效率都更高
            String key=e.nextElement();
            String value=rb.getString(key);//由key获取value
            map2.put(key,value);
        }
        application.setAttribute("map2",map2);



    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
