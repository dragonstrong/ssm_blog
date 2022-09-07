package com.blog.service.impl;


import com.blog.entity.Blog;
import com.blog.entity.BlogType;
import com.blog.entity.Blogger;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.service.BloggerService;
import com.blog.util.Const;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;

/**修改：实现项目启动就将博客类型列表放入内存中,使用ServletContext*/
@Component
public class InitComponent implements ServletContextListener, ApplicationContextAware
{

    private static ApplicationContext applicationContext;


    /**从系统缓存中获取*/
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext application=servletContextEvent.getServletContext();

        /**博客类别*/
        BlogTypeService blogTypeService=(BlogTypeService)applicationContext.getBean("blogTypeService");
        List<BlogType> blogTypeList=blogTypeService.countList();
        application.setAttribute(Const.BLOG_TYPE_COUNT_LIST,blogTypeList);

        /**博主信息*/
        BloggerService bloggerService=(BloggerService)applicationContext.getBean("bloggerService");
        Blogger blogger=bloggerService.find();
        blogger.setPassword(null); //不往数据库存，只存在ServletContext中，设置为null,
        application.setAttribute(Const.BLOGGER,blogger);

        /**按年月分类的博客数量*/
        BlogService blogService=(BlogService)applicationContext.getBean("blogService");
        List<Blog> blogCountList=blogService.countList();
        application.setAttribute(Const.BLOG_COUNT_LIST,blogCountList);


    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext= applicationContext;

    }
}
