<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--引入标签,用于遍历-->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客管理页面</title>
<!--引入css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">   <!--jquery easyui-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">   <!--引入icons-->

<!--引入js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

    var url;
    /**返回该行博客类型名称*/
    function formatBlogType(val,row)
    {
        return val.typename;  //获取val的typename属性，传入的val为BlogType类型
    }
    /**根据标题查询*/
    function searchBlog()
    {
        $("#dg").datagrid("load",{"title":$("#s_title").val()});

    }


    /**博客修改*/
    function openBlogModifyTab()
    {
        var selectedRows=$("#dg").datagrid("getSelections");
        if(selectedRows.length!=1)  //没有选中数据
        {
            $.messager.alert("系统提示","请选择一条要编辑的数据!");
            return;
        }
        var row=selectedRows[0]; //取到选择的这条数据
        window.parent.openTab("修改博客","modifyBlog.jsp?id="+row.id,"icon-writeBlog");   //打开一个新的Tab以供修改,Tab地址为：modifyBlog.jsp,传入选中的id, icon-writeBlog供图片展示
    }

    /**博客删除*/
    function DeleteBlog()
    {
        var selectedRows=$("#dg").datagrid("getSelections");
        if(selectedRows.length<1)  //没有选中数据
        {
            $.messager.alert("系统提示","请至少选择一条要删除的数据!");
            return;
        }
        var row=[]; //声明一个数组装所选的数据，再遍历
        for(var i=0;i<selectedRows.length;i++)
            row.push(selectedRows[i].id); //把选中的第i条数据id放入数组row

        var ids=row.join(",");  //用逗号分隔开
        $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗?",function (r)
        {
            if(r)
            {
                $.post("${pageContext.request.contextPath}/admin/blog/delete.do",{ids:ids},function (result)   //前端和后台交互
                {

                    if(result.success)
                    {
                        $.messager.alert("系统提示","数据已成功删除");
                        $("#dg").datagrid("reload"); //刷新查询结果
                    }
                    else
                    {
                        $.messager.alert("系统提示","数据删除失败");
                    }
                },"json");

            }
        });

    }



    /**添加:保存*/
    function saveBlog()
    {
        //点击保存按钮之后执行submit事件
        $("#fm").form("submit",{
            url:url,
            onSubmit:function () //严格性验证
            {
                return $(this).form("validate");
            },
            success:function (result)
            {
                var result=eval('('+result+')');
                if(result.success)  //此处的success属性与BlogTypeAdminController里写入result的相呼应
                {
                    $.messager.alert("系统提示","保存成功!");
                    resetValue();
                    $("#dlg").dialog("close");
                    //刷新查询结果
                    $("#dg").datagrid("reload");
                }
                else
                {
                    $.messager.alert("系统提示","保存失败!");
                    return;
                }
            }
        });
    }


    /**关闭对话框*/
    function closeBlogDialog()
    {
        $("#dlg").dialog("close");
        resetValue();
    }

    /**重置弹出的对话框*/
    function resetValue()
    {
        $("#id").val("");
        $("#title").val("");
        $("#blogTypeId").combobox("setValue","");
    }


</script>




</head>
<body style="margin: 10px">


<!--创建一个查询表格供展示-->
<table id="dg" title="博客管理" class="easyui-datagrid" fitcolumns="true"
pagination="true" rownumbers="true" fit="true" toolbar="#tb"
url="${pageContext.request.contextPath}/admin/blog/list.do">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="title" width="200" align="center">标题</th>
        <th field="releaseDate" width="50" align="center">发布日期</th>

        <!--调用formatBlogType脚本实现博客类型名称转换-->
        <th field="blogType" width="50" align="center" formatter="formatBlogType">博客类型</th>


    </tr>
    </thead>
</table>
<!--增加条件查询框、博客修改、删除按钮
回车即可查询：onkeydown 13表示回车键
-->
<div id="tb">
    &nbsp;标题:&nbsp;<input type="text" id="s_title" size="20" onkeydown="if(event.keyCode=13) searchBlog()" />
    <a href="javascript:searchBlog()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
    <a href="javascript:openBlogModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
    <a href="javascript:DeleteBlog()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
</div>




</body>
</html>