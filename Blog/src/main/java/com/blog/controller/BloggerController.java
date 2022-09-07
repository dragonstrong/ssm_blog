//博主登录相关
package com.blog.controller;

import com.blog.entity.Blog;
import com.blog.entity.Blogger;
import com.blog.service.BloggerService;
import com.blog.util.Const;
import com.blog.util.CryptoraphyUtil;
import com.blog.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/blogger")  //总的/blogger目录
public class BloggerController
{
    @Resource
    private BloggerService bloggerService;


    @RequestMapping("/login")
    public String login(Blogger blogger,HttpServletRequest request)
    {
        /**用户民*/
        String userName=blogger.getUserName();
        /**密码*/
        String password=blogger.getPassword();
        /**经密钥加密后的密码*/
        String pw_enp= CryptoraphyUtil.md5(password, Const.SALT);

        //从shiro里获取subject
        Subject subject= SecurityUtils.getSubject();

        //根据用户名和密码生成token
        UsernamePasswordToken token=new UsernamePasswordToken(userName,pw_enp);

        try
        {
            //登录
            //传递token给shiro的realm  需要修改自定义的MyRealm类以完成正常功能
            subject.login(token);
            return "redirect:/admin/main.jsp"; //验证成功(没报异常)，重定位回博主主页

        }catch (Exception e)
        {

            e.printStackTrace();  //登录失败在后台打印错误信息
            request.setAttribute("blogger",blogger); //把用户名密码传回前台jsp页面，jsp页面再接收，让用户修改，修改正确后再提交，不用每次重新提交
            request.setAttribute("erroInfo","用户名或密码错误");
        }
        return "login";  //登录失败返回登录页面
    }

    /**用户注册*/
    @RequestMapping("/register")
    public String register(Blogger blogger, HttpServletResponse response) throws Exception
    {

        JSONObject result=new JSONObject();
        if(bloggerService.is_exist(blogger.getUserName())!=null)  //用户已存在
        {
            result.put("success",Boolean.valueOf(false));
        }
        else
        {
            blogger.setPassword(CryptoraphyUtil.md5(blogger.getPassword(), Const.SALT));
            int resultTotal=bloggerService.add(blogger);
            result.put("success",Boolean.valueOf(true));
        }
        ResponseUtil.write(response,result); //将result写入response
        return null;
    }



    /**关于博主*/
    @RequestMapping("/aboutMe")
    public ModelAndView aboUtMe()
    {
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("blogger",bloggerService.find());
        modelAndView.addObject("mainPage","foreground/blogger/Info.jsp");
        modelAndView.addObject("pageTitle","关于博主_个人博客系统");
        modelAndView.setViewName("index");  //返回index页面
        return modelAndView;

    }

}
