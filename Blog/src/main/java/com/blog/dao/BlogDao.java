package com.blog.dao;

import com.blog.entity.Blog;
import com.blog.entity.BlogType;

import java.util.List;
import java.util.Map;

public interface BlogDao
{
    /**无参数查询博客列表(供首页使用),返回日期和数量即可*/
    public List<Blog> countList();

    /**不固定参数查询博客列表*/
    public List<Blog> list(Map<String,Object> paramMap);

    /**不固定参数查询博客数量*/
    public Long getTotal(Map<String,Object> paramMap);

    /**根据id查询博客*/
    public Blog findById(Integer id);

    /**添加一条博客*/
    public Integer add(Blog blog);

    /**修改一条博客*/
    public Integer update(Blog blog);

    /**删除一条博客*/
    public Integer delete(Integer id);

    /**根据类型查询博客数量:删除博客类型时要用到，作为判断条件*/
    public Integer getBlogByTypeId(Integer typeId);

}
