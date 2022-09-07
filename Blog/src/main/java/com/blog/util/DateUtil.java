package com.blog.util;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.SimpleFormatter;

/**日期工具类*/
public class DateUtil
{
    /**得到当前到秒的时间字符串*/
    public static String getCurrentDateStr()
    {
        Date date=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
        return sdf.format(date);
    }

    public static String formatDate(Date date,String format)
    {
        String result="";
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat(format);
        if(date!=null)
            result=simpleDateFormat.format(date);

        return result;

    }

}
