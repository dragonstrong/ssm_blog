package com.blog.entity;

import java.io.Serializable;
import java.util.Date;

public class Blog implements Serializable
{
    //数据库中的属性
    /**主键*/
    private Integer id;
    /**标题*/
    private String title;
    /**摘要*/
    private String summary;
    /**发表时间*/
    private Date releaseDate;
    /**点击数*/
    private Integer clickHit;
    /**评论数*/
    private Integer replyHit;
    /**内容*/
    private String content;
    /**所属博客类型:数据库里是TypeId,这里做一个查询*/
    private BlogType blogType;
    /**关键字*/
    private String keyWord;
    /**博客类型id*/
    private String typeId;

    //新加属性

    /**纯文本格式的内容,方便用lucene查(不能查副文本,比如图片地址)*/
    private String ContentNoTag;
    /**发表时间的字符串形式*/
    private String  releaseDateStr;
    /**相同发表日期下博客的数量*/
    private Integer blogCount;

    public void setId(Integer id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public void setClickHit(Integer clickHit) {
        this.clickHit = clickHit;
    }

    public void setReplyHit(Integer replyHit) {
        this.replyHit = replyHit;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setBlogType(BlogType blogType) {
        this.blogType = blogType;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public void setContentNoTag(String contentNoTag) {
        ContentNoTag = contentNoTag;
    }

    public void setReleaseDateStr(String releaseDateStr) {
        this.releaseDateStr = releaseDateStr;
    }

    public void setBlogCount(Integer blogCount) {
        this.blogCount = blogCount;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public Integer getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getSummary() {
        return summary;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public Integer getClickHit() {
        return clickHit;
    }

    public Integer getReplyHit() {
        return replyHit;
    }

    public String getContent() {
        return content;
    }

    public BlogType getBlogType() {
        return blogType;
    }

    public String getKeyWord() {
        return keyWord;
    }

    public String getContentNoTag() {
        return ContentNoTag;
    }

    public String getReleaseDateStr() {
        return releaseDateStr;
    }

    public Integer getBlogCount() {
        return blogCount;
    }

    public String getTypeId() {
        return typeId;
    }
}
