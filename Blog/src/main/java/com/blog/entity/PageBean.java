package com.blog.entity;

public class PageBean
{

    /**当前第几页，从1开始*/
    private int page;
    /**页面大小*/
    private int pageSzie;

    /**从第几条数据开始查询*/
    private int start;

    public PageBean(int page, int pageSzie) {
        this.page = page;
        this.pageSzie = pageSzie;
    }

    public int getPage() {
        return page;
    }

    public int getPageSzie() {
        return pageSzie;
    }

    public int getStart() {
        return (this.page-1)*this.pageSzie;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public void setPageSzie(int pageSzie) {
        this.pageSzie = pageSzie;
    }


}
