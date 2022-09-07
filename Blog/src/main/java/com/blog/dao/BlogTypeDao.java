package com.blog.dao;

import com.blog.entity.BlogType;

import java.util.List;
import java.util.Map;

public interface BlogTypeDao
{
    /**无参查询所有博客类型列表
     * 获取博客类型和每种类型对应下的博客数量，可用于分类展示
     * */
    public List<BlogType> countList();

    /**根据id查询博客类型*/
    public BlogType findById(Integer id);
    /**不固定参数查询博客类型列表*/
    public List<BlogType> list(Map<String,Object> paramMap);

    /**不固定参数查询博客类型数量*/
    public Long getTotal(Map<String,Object> paramMap);

    /**添加一条博客类型*/
    public Integer add(BlogType blogType);

    /**修改一条博客类型*/
    public Integer update(BlogType blogType);

    /**删除一条博客类型*/
    public Integer delete(Integer id);


}
