package com.blog.controller.admin;

import com.blog.entity.BlogType;
import com.blog.entity.PageBean;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**博客类型管理*/


@Controller
@RequestMapping({"/admin/blogType"})  //RequestMapping地址方便前端(jsp页面)找到对应的执行函数 如blogTypeManage.jsp第24、142行
public class BlogTypeAdminController
{
    @Resource
    private BlogTypeService blogTypeService;
    @Resource
    private BlogService blogService; //供查询某种博客类型有多少条博客，删除博客类型判断用到


    /**博客类型列表*/
    @RequestMapping({"/list"})
    public String list(@RequestParam(value = "page",required = false) String page, @RequestParam(value = "rows",required = false) String rows, HttpServletResponse response) throws Exception   //jquery翻页  查询  写一个PageBean封装翻页
    {
        PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));

        Map<String ,Object> map=new HashMap<>();
        map.put("start",pageBean.getStart());
        map.put("size",pageBean.getPageSzie());


        //查询博客类型列表
        List<BlogType> blogTypeList=blogTypeService.list(map);
        //查询总共多少条数据(多少种博客类型)
        Long total=blogTypeService.getTotal(map);
        //将查到的数据写入response
        JSONObject result=new JSONObject();
        JSONArray jsonArray=JSONArray.fromObject(blogTypeList);//将List转换成JSONArray
        result.put("rows",jsonArray);
        result.put("total",total);

        ResponseUtil.write(response,result);

        return null;

    }

    /**保存博客类别:支持添加和修改*/
    @RequestMapping("/save")
    public String save(BlogType blogType,HttpServletResponse response) throws Exception
    {
        int resultTotal=0;
        if(blogType.getId()==null)   //添加
            resultTotal=blogTypeService.add(blogType).intValue();
        else                        //修改
            resultTotal=blogTypeService.update(blogType).intValue();

        JSONObject result=new JSONObject();
        if(resultTotal>0)
        {
            result.put("success",Boolean.valueOf(true));  //告诉前台 jsp页面里根据success属性判断是否保存成功,详见blogTypeManage.jsp第93行  （success可换成别的名字，只要和jsp页面保持一致即可）
        }
        else
        {
            result.put("success",Boolean.valueOf(false));

        }
        ResponseUtil.write(response,result);
        return null;

    }

    /**删除博客类别*/
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids") String ids,HttpServletResponse response) throws Exception
    {
        String[] idsStr=ids.split(",");
        JSONObject result=new JSONObject();

        for(int i=0;i<idsStr.length;i++)
        {
            if(blogService.getBlogByTypeId(Integer.valueOf(idsStr[i]))>0) //该博客类型下有博客，不能删
                result.put("exist","所选类别下有博客，不能删除");
            else
                blogTypeService.delete(Integer.valueOf(idsStr[i]));

        }
        result.put("success",Boolean.valueOf(true));
        ResponseUtil.write(response,result);
        return null;

    }

}
