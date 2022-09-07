package com.blog.service.impl;

import com.blog.dao.BlogDao;
import com.blog.entity.Blog;
import com.blog.service.BlogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("blogService")
public class BlogServiceImpl implements BlogService
{
    @Resource
    private BlogDao blogDao;

    @Override
    public List<Blog> countList() {
        return blogDao.countList();
    }

    @Override
    public List<Blog> list(Map<String, Object> paramMap) {
        return blogDao.list(paramMap);
    }

    @Override
    public Long getTotal(Map<String, Object> paramMap) {
        return blogDao.getTotal(paramMap);
    }

    @Override
    public Blog findById(Integer id) {
        return blogDao.findById(id);
    }

    @Override
    public Integer add(Blog blog) {
        return blogDao.add(blog);
    }

    @Override
    public Integer update(Blog blog) {
        return blogDao.update(blog);
    }

    @Override
    public Integer delete(Integer id) {
        return blogDao.delete(id);
    }

    @Override
    public Integer getBlogByTypeId(Integer typeId) {
        return blogDao.getBlogByTypeId(typeId);
    }
}
