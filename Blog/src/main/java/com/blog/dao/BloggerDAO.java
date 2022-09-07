package com.blog.dao;

import com.blog.entity.BlogType;
import com.blog.entity.Blogger;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 博主dao*/
public interface BloggerDAO
{

    /**根据登录名查询博主对象*/
    public Blogger getByUserName(@Param("userName")String userName);  //用@Param("userName"是为了使参数名和BloggerMapper.xml第24行的userName一致



    /**无参查询所有博客类型列表*/
    public List<Blogger> countList();

    /**查询博主：默认只有1个*/
    public Blogger find();

    /**根据id查询博主*/
    public Blogger findById(Integer id);
    /**不固定参数查询博主*/
    public List<Blogger> list(Map<String,Object> paramMap);

    /**不固定参数查询博主数量*/
    public Long getTotal(Map<String,Object> paramMap);

    /**添加一个博主*/
    public Integer add(Blogger blogger);

    /**修改一个博主*/
    public Integer update(Blogger blogger);

    /**删除一个博主*/
    public Integer delete(Integer id);
    /**根据用户名查询博主是否存在，注册用*/
    public Blogger is_exist(String userName);

}
