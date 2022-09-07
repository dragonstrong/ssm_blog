package com.blog.controller.admin;


import com.blog.entity.Blogger;
import com.blog.service.BloggerService;
import com.blog.util.Const;
import com.blog.util.CryptoraphyUtil;
import com.blog.util.DateUtil;
import com.blog.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

@Controller
@RequestMapping("/admin/blogger")
public class BloggerAdminController
{
    @Resource
    private BloggerService bloggerService;

    @RequestMapping("/save")
    public String save(@RequestParam("imageFile")MultipartFile imageFile, Blogger blogger,
                       HttpServletRequest request,HttpServletResponse response) throws Exception
    {

        if(!imageFile.isEmpty()) //头像不为空
        {
            String filePath=request.getServletContext().getRealPath("/"); //获取当前项目的路径
            //得到文件名:当前时间+扩展名
            String imageName= DateUtil.getCurrentDateStr()+"."+imageFile.getOriginalFilename().split("\\.")[1];
            imageFile.transferTo(new File(filePath+"static/userImages/"+imageName));//把文件存到对应的路径
            blogger.setImageName(imageName);
        }

        int resultTotal=bloggerService.update(blogger);
        StringBuffer result=new StringBuffer();
        if(resultTotal>0) //更新成功
            result.append("<script language='javascript'>alert('修改成功');</script>");
        else
            result.append("<script language='javascript'>alert('修改失败');</script>");

        ResponseUtil.write(response,result);

        return null;
    }

    /**获取博主的JSON格式*/

    @RequestMapping("/find")
    public String find(HttpServletResponse response) throws Exception
    {
        //直接从Session里获取  和MyRealm对应
        Blogger blogger=(Blogger)SecurityUtils.getSubject().getSession().getAttribute(Const.CURRENT_USER);
        //写入JSON
        JSONObject jsonObject=JSONObject.fromObject(blogger);
        ResponseUtil.write(response,jsonObject);
        return null;
    }

    /**修改密码*/
    @RequestMapping("/modifyPassword")
    //传入id和新密码
    public String modifyPassword(@RequestParam("id")String id,@RequestParam("new_password")String new_password,HttpServletResponse response) throws Exception
    {
        Blogger blogger=new Blogger();
        blogger.setId(Integer.parseInt(id));
        blogger.setPassword(CryptoraphyUtil.md5(new_password,Const.SALT)); //密钥加密
        int ResultTotal=bloggerService.update(blogger);

        //写入JSON
        JSONObject result=new JSONObject();
        if(ResultTotal>0)
            result.put("success",Boolean.valueOf(true));
        else
            result.put("success",Boolean.valueOf(false));

        ResponseUtil.write(response,result);
        return null;
    }


    /**安全退出*/   //RequestMapping和函数之间不能有任何别的字符（比如加注释），否则spring扫描不到
    @RequestMapping("/logout")
    public String logout()
    {
        SecurityUtils.getSubject().logout();
        return "redirect:/login.jsp"; //退出后回到登录页面
    }




}
