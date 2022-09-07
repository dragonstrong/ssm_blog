<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客类别管理页面</title>

<!--引入css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">   <!--jquery easyui-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">   <!--引入icons-->

<!--引入js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

    var url;

    /**弹出添加博客类型对话框*/
    function openBlogTypeAddDialog()
    {
        $("#dlg").dialog("open").dialog("setTitle","添加博客类型信息");//打开Dialog
        url="${pageContext.request.contextPath}/admin/blogType/save.do"; //spring扫描url执行对应函数：BlogTypeAdminController里的save()   前端和后台数据交互
    }

    /**弹出修改对话框*/
    function openBlogTypeModifyDialog()
    {
        var selectedRows=$("#dg").datagrid("getSelections");
        if(selectedRows.length!=1)  //没有选中数据
        {
            $.messager.alert("系统提示","请选择一条要编辑的数据!");
            return;
        }
        var row=selectedRows[0]; //取到选择的这条数据
        $("#dlg").dialog("open").dialog("setTitle","修改博客类别信息");
        $("#fm").form("load",row);
        url="${pageContext.request.contextPath}/admin/blogType/save.do?id="+row.id;   // 前端和后台数据交互
    }

    /**删除博客类型*/
    function DeleteBlogType()
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
                $.post("${pageContext.request.contextPath}/admin/blogType/delete.do",{ids:ids},function (result)   //前端和后台交互
                {
                    if(result.exist)  //该类型下存在博客
                        $.messager.alert("系统提示",result.exist);
                    else
                    {
                        if(result.success)
                            $.messager.alert("系统提示","数据已成功删除");
                        else
                            $.messager.alert("系统提示","数据删除失败");
                    }
                    $("#dg").datagrid("reload"); //刷新查询结果

                },"json");

            }
        });

    }



    /**添加:保存*/
    function saveBlogType()
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
    function closeBlogTypeDialog()
    {
        $("#dlg").dialog("close");
        resetValue();
    }

    /**重置弹出的对话框*/
    function resetValue()
    {
        $("#typaname").val("");
        $("#orderNo").val("");


    }

</script>



</head>
<body style="margin: 1px">
<!--获取BlogTypeAdminController里的内容-->
<!--博客类型查询：用jquery建一个table-->
<!--
class:展示方式
fitcolumns：true不会出现水平滚动条
pagination：是否翻页
rownumbers：是否带行号
-->
<table id="dg" title="博客类别管理" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="false"
       url="${pageContext.request.contextPath}/admin/blogType/list.do" fit="true" toolbar="#tb">   <!--spring会自动找到url指向的函数并执行,：BlogTypeAdminController里的list函数()-->
    <thead>  <!--表头-->
        <tr>
            <th field="cb" checkbox="true" align="center"></th>   <!--选择框-->
            <th field="id" width="20" align="center">编号</th>
            <th field="typename" width="100" align="center">博客类型名称</th>
            <th field="orderNo" width="100" align="center">排序序号</th>
        </tr>
    </thead>
</table>


<!--博客类型添加、修改、删除-->
<!--按钮-->
<!--
href:点击事件
iconCls：图标，在icon.css里命名
plain：是否带边框，true不带
-->

<div id="tb">
    <a href="javascript:openBlogTypeAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
    <a href="javascript:openBlogTypeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
    <a href="javascript:DeleteBlogType()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
</div>





<!--添加博客类型对话框-->
<!--
padding:
     四个参数：
 	padding:10px  20px  30px  40px     分别代表：上、右、下、左四个边框的边距值（顺时针方向记就好啦）
 	三个参数：
 	padding:10px  20px  30px   分别代表：上：10px、    左右各20px、 下：30px
 	两个参数：
 	padding:10px  20px   分别代表：上下各10px、  左右各20px
 	一个参数：
 	padding:10px   代表上下左右边距值都是10px

closed:对话框是否可关闭
新建一个form post方式提交
required:必填

-->
<div id="dlg" class="easyui-dialog" style="width: 500px;height: 180px;padding: 10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>博客类型名称:</td>
                <td><input type="text" id="typename" name="typename" class="easyui-validatebox" required="true"></td>
            </tr>
            <tr>
                <td>博客类型排序:</td>
                <td><input type="text" id="orderNo" name="orderNo" class="easyui-validatebox" required="true" style="width: 60px">(类别根据排序序号从小到大排序)</td>
            </tr>

        </table>

    </form>
</div>

<!--保存、关闭按钮-->
<!--id不能随便取，要和dlg里buttons属性一致-->
<div id="dlg-buttons">
    <a href="javascript:saveBlogType()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
    <a href="javascript:closeBlogTypeDialog()" class="easyui-linkbutton" iconCls="icon-cancle">关闭</a>
</div>

博客类别管理
</body>
</html>