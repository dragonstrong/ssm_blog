<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--引入标签,用于遍历-->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改博客页面</title>

<!--引入css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">   <!--jquery easyui-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">   <!--引入icons-->

<!--引入js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<!--引入写博客的编辑器ueditor gbk:中文支持（否则会乱码）-->
<script type="text/javascript" charset="gbk" src="${pageContext.request.contextPath}/static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="${pageContext.request.contextPath}/static/ueditor/ueditor.all.min.js"></script>
<!--
中文：手动加载语言，避免 在IE下有时因为加载语言导致编译器加载失败
在这里加载的语言会覆盖在配置项目里添加的语言类型，比如配置项目里配置的是英文，这里加载的是中文，最后按中文
-->
<script type="text/javascript" charset="gbk" src="${pageContext.request.contextPath}/static/ueditor/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript">
    /**发布博客*/
    function submitData()
    {
        var title=$("#title").val();//获取title值
        var blogTypeId=$("#blogTypeId").combobox("getValue");//获取blogTypeId值
        var content=UE.getEditor('editor').getContent();//获取博客内容
        var keyWord=$("#keyWord").val();//获取keyWord值

        if(title==null||title=='')
            $.messager.alert("系统提示","请输入标题!");
        else if (blogTypeId==null||blogTypeId=='')
            $.messager.alert("系统提示","请输入博客类型编号!");
        else if(content==null||content=='')
            $.messager.alert("系统提示","请输入博客内容!");
        else if (keyWord==null||keyWord=='')
            $.messager.alert("系统提示","请输入关键字!");
        else
        {
            $.post("${pageContext.request.contextPath}/admin/blog/save.do",
                //传输的时候要比写博客多传一个id，代表要修改的博客,用${param.id}获取从blogManage.jsp里传过来的参数
                {'id':'${param.id}','title':title,'blogType.id':blogTypeId,'content':content,'summary':UE.getEditor('editor').getContentTxt().substr(0,20),'keyWord':keyWord},
                function (result)
                {
                    if(result.success)
                        $.messager.alert("系统提示","博客发布成功!");
                    else
                        $.messager.alert("系统提示","博客发布失败!");

                },"json");
        }
    }
</script>


</head>
<body style="margin: 10px">
<div id="p" class="easyui-panel" title="修改博客" style="padding: 10px">
    <table cellspacing="20px">
        <tr>
            <td width="80px">博客标题</td>
            <td ><input type="text" id="title" name="title" style="width: 400px"></td>
        </tr>

        <!--所属类别用下拉菜单-->
        <tr>
            <td width="80px">所属类别</td>
            <td >
                <select class="easyui-combobox" id="blogTypeId" name="blogType.id"
                        style="width: 150px" editable="false" panelHeight="auto">
                    <option value="">请选择博客类别</option>
                    <!--用标签遍历-->
                    <c:forEach var="blogType" items="${blogTypeCountList}">
                        <option value="${blogType.id}">${blogType.typename}</option>
                    </c:forEach>

                </select>

            </td>
        </tr>

        <tr>
            <td width="80px">博客内容</td>
            <td>
                <!--副文本,用script-->
                <script id="editor" type="text/plain" style="width: 100%;height: 500px"></script>
            </td>
        </tr>

        <tr>
            <td width="80px">关键字</td>
            <td ><input type="text" id="keyWord" name="keyWord" style="width: 400px">&nbsp;&nbsp;(多个关键字中间用空格隔开)</td>
        </tr>

        <tr>
            <td></td>
            <!--发布按钮-->
            <td ><a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">发布博客</a></td>
        </tr>

    </table>
</div>

<!--副文本script：加载修改的博客内容,用ajax-->
<script type="text/javascript">
    //实例化文本编辑器
    var ue=UE.getEditor("editor");
    //当ue准备好才进行加载
    ue.addListener("ready",function ()
    {
        //通过ajax请求数据,调用BlogAdminController里的findById方法找到id对应的博客
        UE.ajax.request("${pageContext.request.contextPath}/admin/blog/findById.do",
            {
                method:"post",  //用post方式访问
                asyc:"false", //不异步
                data:{"id":"${param.id}"},  //把id传过去
                onsuccess:function (result) //获取数据成功之后返回result
                {
                    result=eval("("+result.responseText+")"); //result就是findById()方法中封装到json里的blog
                    //赋值
                    $("#title").val(result.title);
                    $("#keyWord").val(result.keyWord);
                    $("#blogTypeId").combobox("setValue",result.blogType.id);
                    UE.getEditor("editor").setContent(result.content);

                }
            }
        )

    });

</script>

</body>
</html>