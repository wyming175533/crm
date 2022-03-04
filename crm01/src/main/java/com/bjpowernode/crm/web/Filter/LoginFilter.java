package com.bjpowernode.crm.web.Filter;

import com.bjpowernode.crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request= (HttpServletRequest) servletRequest;//转为httpServletrequest获取session对象
        HttpServletResponse response= (HttpServletResponse) servletResponse;

        String path=request.getServletPath();
        System.out.println(path+"-------------path-------------------");
        if("/login.jsp".equals(path) || "/Settings/user/login.do".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
        }else {
            User user= (User) request.getSession().getAttribute("user");
            if (user == null) {
                //重定向会使得网站地址栏发生变化，心的请求，而转发是停留在当前页，这里用重定向
                response.sendRedirect(request.getContextPath() +"/login.jsp");
            }else{
                filterChain.doFilter(servletRequest,servletResponse);
            }

        }

    }

    @Override
    public void destroy() {

    }
}
