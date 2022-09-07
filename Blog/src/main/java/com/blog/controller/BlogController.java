package com.blog.controller;


import com.blog.entity.Blog;
import com.blog.lucene.BlogIndex;
import com.blog.service.BlogService;
import com.blog.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

/**博客详情管理*/
@Controller
@RequestMapping("/blog")
public class BlogController
{
    private BlogIndex blogIndex=new BlogIndex();

    @Resource
    private BlogService blogService;
    /**博客详情
     * 需要传id过来
     */
    @RequestMapping("/articles/{id}")
    public ModelAndView details(@PathVariable("id")Integer id, HttpServletRequest request)
    {

        ModelAndView modelAndView=new ModelAndView();
        /**根据主键查询博客信息*/
        Blog blog=blogService.findById(id);
        modelAndView.addObject("blog",blog);//将blog放入ModelAndView
        blog.setClickHit(blog.getClickHit()+1);  //点击数+1
        blogService.update(blog); //数据库更新该博客信息
        //新建一个view.jsp页面展示博客详细信息
        modelAndView.addObject("mainPage","foreground/blog/view.jsp");
        //把名字改掉
        modelAndView.addObject("pageTitle",blog.getTitle()+"_个人博客系统");
        //设置转向:到index.jsp页面
        modelAndView.setViewName("index");
        return modelAndView;
    }

    /**LUCENE根据关键字查询*/
    @RequestMapping("/q")
    public ModelAndView q(@RequestParam(value ="q",required = false)String q,
                          @RequestParam(value ="page",required = false)String page,
                          HttpServletRequest request) throws Exception
    {
        if(StringUtil.isEmpty(page))
            page="1";

        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("mainPage","foreground/blog/result.jsp");
        //在lucene中查询
        List<Blog> blogList=blogIndex.searchBlog(q.trim()); //trim删除空格
        modelAndView.addObject("blogList",blogList);
        modelAndView.addObject("q",q);
        modelAndView.addObject("resultTotal",blogList.size()); //总共搜到了多少条
        modelAndView.addObject("pageTitle","搜索关键字"+q+"结果页面_个人博客");
        modelAndView.setViewName("index");
        return modelAndView;

    }




}
