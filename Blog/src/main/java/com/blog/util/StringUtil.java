package com.blog.util;
/**字符串操作工具类*/
public class StringUtil
{

    /**格式化*/
    public static String formatLike(String str)
    {
        if(!isEmpty(str))
            return "%"+str+"%";
        else
            return null;

    }

    /**字符串是否为空*/
    public static boolean isEmpty(String str)
    {
        return str==null||"".equals(str.trim()); //trim()函数忽略首尾空白

    }

}
