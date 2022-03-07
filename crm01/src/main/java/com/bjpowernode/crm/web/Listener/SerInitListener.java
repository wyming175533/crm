package com.bjpowernode.crm.web.Listener;

import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import com.bjpowernode.crm.settings.service.impl.DicSeviceImpl;
import com.bjpowernode.crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
