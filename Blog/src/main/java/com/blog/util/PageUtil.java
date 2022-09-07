package com.blog.util;

/**翻页工具类*/
public class PageUtil
{
   // <li><a href='/index.html?page=1&'>首页</a></li>
    // <li class='disabled'><a href='#'>上一页</a></li>
    // <li class='active'><a href='/index.html?page=1&'>1</a></li>
    // <li class='disabled'><a href='#'>下一页</a></li>
    // <li><a href='/index.html?page=1&'>尾页</a></li>

    /**翻页方法:
     * targetUrl:链接地址
     * totalNum:博客总数
     * pageSize：每页大小
     * currentPage:当前页
     * param:查询条件(比如某一类型下面的博客不止一页就要翻页，所以要加上过滤条件)
     * */
    public static String genPagination(String targetUrl,long totalNum,int pageSize,int currentPage,String param)
    {
        //总共页数
        if(totalNum==0)
            return "未查询到数据";
        long totalPage=totalNum/pageSize+1L; //总页数
        StringBuffer pageCode=new StringBuffer();
        /**首页*/
        pageCode.append(" <li><a href='"+targetUrl+"?page=1&"+param+"'>首页</a></li>");
        /**上一页*/
        if(currentPage>1)  //当前页大于1才有上一页
            pageCode.append(" <li><a href='"+targetUrl+"?page=&"+(currentPage-1)+"&"+param+"'>上一页</a></li>");
        else   //当前页是1 显示上一页但不能点击
            pageCode.append("<li class='disabled'><a href='#'>上一页</a></li>");

        /**显示页数*/
        for(int i=1;i<=totalPage;i++)
        {
            if(i==currentPage)  //当前页高亮
                pageCode.append("<li class='active'><a href='"+targetUrl+"?page="+i+"&"+param+"'>"+i+"</a></li>");
            else
                pageCode.append("<li><a href='"+targetUrl+"?page="+i+"&"+param+"'>"+i+"</a></li>");
        }
        /**下一页*/
        if(currentPage<totalPage)   //当前页不是尾页点击下一页才有效
            pageCode.append(" <li><a href='"+targetUrl+"?page=&"+(currentPage+1)+"&"+param+"'>下一页</a></li>");
        else
            pageCode.append("<li class='disabled'><a href='#'>下一页</a></li>");

        /**尾页*/
        pageCode.append(" <li><a href='"+targetUrl+"?page="+totalPage+"&"+param+"'>尾页</a></li>");


        return pageCode.toString();


    }
}
