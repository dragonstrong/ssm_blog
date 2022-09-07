package com.blog.service.impl;

import com.blog.dao.BloggerDAO;
import com.blog.entity.Blogger;
import com.blog.service.BloggerService;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**接口BloggerService的实现类*/
/**声明该类为Service，名bloggerService，以供Spring扫描*/
@Service("bloggerService")
public class BloggerServiceImpl implements BloggerService
{
    /**引入BloggerDAO*/
    @Resource
    private BloggerDAO bloggerDAO;

    @Override
    public Blogger getByUserName(String userName) {
        return bloggerDAO.getByUserName(userName);
    }

    @Override
    public List<Blogger> countList() {
        return null;
    }

    @Override
    public Blogger find() {
        return bloggerDAO.find();
    }

    @Override
    public Blogger findById(Integer id) {
        return null;
    }

    @Override
    public List<Blogger> list(Map<String, Object> paramMap) {
        return null;
    }

    @Override
    public Long getTotal(Map<String, Object> paramMap) {
        return null;
    }

    @Override
    public Integer add(Blogger blogger) {
        return bloggerDAO.add(blogger);
    }

    @Override
    public Integer update(Blogger blogger) {
        //把blogger放到Session里，供修改后刷新
        SecurityUtils.getSubject().getSession().setAttribute("currentUser",blogger);
        return bloggerDAO.update(blogger);
    }

    @Override
    public Integer delete(Integer id) {
        return null;
    }

    @Override
    public Blogger is_exist(String userName) {
        return bloggerDAO.is_exist(userName);
    }
}
