package com.blog.controller.admin;


import com.blog.entity.Blog;
import com.blog.entity.BlogType;
import com.blog.entity.Blogger;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.service.BloggerService;
import com.blog.util.Const;
import com.blog.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


/**系统管理*/

@RequestMapping("/admin/system")
@Controller
public class SystemAdminController
{
    @Resource
    private BlogTypeService blogTypeService;
    @Resource
    private BloggerService bloggerService;
    @Resource
    private BlogService blogService;


    /**刷新系统缓存*/
    @RequestMapping("/refreshSystem")
    public String refresh(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        /**往ServletContext写信息*/
        ServletContext application= RequestContextUtils.getWebApplicationContext(request).getServletContext();

        /**博客类别*/
        List<BlogType> list=blogTypeService.countList();
        application.setAttribute(Const.BLOG_TYPE_COUNT_LIST,list); //名字要和InitComponent类里的一样 新建一个Const管理公共参数

        /**博主信息*/
        Blogger blogger=bloggerService.find();
        blogger.setPassword(null); //不往数据库存，只存在ServletContext中，设置为null,
        application.setAttribute(Const.BLOGGER,blogger);

        /**按年月分类的博客数量*/
        List<Blog> blogCountList=blogService.countList();
        application.setAttribute(Const.BLOG_COUNT_LIST,blogCountList);


        JSONObject result=new JSONObject();
        result.put("success",Boolean.valueOf(true));
        ResponseUtil.write(response,result);
        return null;

    }


}
