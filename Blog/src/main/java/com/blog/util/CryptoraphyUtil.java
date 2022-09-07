package com.blog.util;

import org.apache.shiro.crypto.hash.Md5Hash;

//自定义md5加密类
public class CryptoraphyUtil
{
    //md5加密函数
    public static void mian(String[] args)
    {
        System.out.print(md5("1",Const.SALT));

    }

    public static String md5(String str,String salt)  //传入一个待加密的字符串str，以及密钥salt
    {
        return new Md5Hash(str,salt).toString(); //借用Md5Hash类

    }

}
