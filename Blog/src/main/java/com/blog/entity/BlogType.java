package com.blog.entity;

import java.io.Serializable;

/**博客类型*/
public class BlogType implements Serializable  //实现序列化 方便传递对象
{

    private static final long serialVersionUDI=1L;
    /**主键*/
    private Integer id;
    /**类型名称*/
    private String typename;
    /**序号*/
    private Integer orderNo;
    /**该类型下博客数量*/
    private Integer blogCount;

    public void setId(Integer id) {
        this.id = id;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public void setBlogCount(Integer blogCount) {
        this.blogCount = blogCount;
    }

    public Integer getId() {
        return id;
    }

    public String getTypename() {
        return typename;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public Integer getBlogCount() {
        return blogCount;
    }
}
