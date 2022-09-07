package com.blog.controller;

import com.blog.entity.Blog;
import com.blog.entity.PageBean;
import com.blog.service.BlogService;
import com.blog.util.PageUtil;
import com.blog.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**首页*/
@Controller
public class IndexController
{
    @Resource
    private BlogService blogService;

    /**Springmvc返回一个ModelAndView
     * page:当前页
     *
     * */
    @RequestMapping("/index")
    public ModelAndView index(@RequestParam(value = "page",required = false)String page, @RequestParam(value = "typeId",required = false)String typeId,
                              @RequestParam(value = "releaseDateStr",required = false)String releaseDateStr,HttpServletRequest request)
    {
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("title","个人博客系统");  //前端可以直接捕获到，index.jsp第7行

        if(StringUtil.isEmpty(page))
            page="1";// 如果page为空，默认显示第一页
        PageBean pageBean=new PageBean(Integer.parseInt(page),10);
        Map<String ,Object> map= new HashMap<>();
        map.put("start",pageBean.getStart());
        map.put("size",pageBean.getPageSzie());
        map.put("typeId",typeId);
        map.put("releaseDateStr",releaseDateStr);

        List<Blog> list=blogService.list(map);  //调用list方法查询
        StringBuffer param=new StringBuffer();
        if(!StringUtil.isEmpty(typeId))  //加入typeId过滤条件
            param.append("typeId="+typeId+"&");
        if(!StringUtil.isEmpty(releaseDateStr))  //加入releaseDateStr过滤条件
            param.append("releaseDateStr="+releaseDateStr+"&");

        modelAndView.addObject("mainPage","foreground/blog/list.jsp");


        String pageCode= PageUtil.genPagination(request.getContextPath()+"/index.html",blogService.getTotal(map),
                10,Integer.parseInt(page),param.toString());
        modelAndView.addObject("pageCode",pageCode);
        modelAndView.addObject("blogList",list);

        return modelAndView;
    }



}
