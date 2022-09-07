<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改个人信息页面</title>

<!--类似修改博客-->
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
    /**提交博主信息*/
    function submitData()
    {

        //获取内容
        var nickName=$("#nickName").val();
        var sign=$("#sign").val();
        var profile=UE.getEditor("editor").getContent();


        if(nickName==null||nickName=="")
            $.messager.alert("系统提示","请输入昵称");
        else if(sign==null||sign=="")
            $.messager.alert("系统提示","请输入个性签名");
        else if(profile==null||profile=="")
            $.messager.alert("系统提示","请输入个人简介");
        else
        {
            $("#profile").val(profile); //赋值
            $("#form1").submit(); //提交
        }



    }
</script>


</head>
<body style="margin: 10px">
<div id="p" class="easyui-panel" title="修改个人信息" style="padding: 10px">
    <!--用post上传图像
    enctype:支持图片-->
    <form id="form1" action="${pageContext.request.contextPath}/admin/blogger/save.do" method="post" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${currentUser.id}"/>   <!--自动更新id-->
        <input type="hidden" id="profile" name="profile"/>   <!--自动更新个人简介-->
    <table cellspacing="20px">
        <tr>
            <td width="80px">用户名</td>
            <!--currentUser和MyRealm里的相同,信息直接从currentUser获取   readonly不让修改-->
            <td ><input type="text" id="userName" name="userName" style="width: 200px" value="${currentUser.userName}" readonly="readonly"/></td>
        </tr>

        <tr>
            <td width="80px">昵称</td>
            <td ><input type="text" id="nickName" name="nickName" style="width: 200px" value="${currentUser.nickName}"/></td>
        </tr>

        <tr>
            <td width="80px">个性签名</td>
            <td ><input type="text" id="sign" name="sign" style="width: 400px" value="${currentUser.sign}"/></td>
        </tr>


        <tr>
            <td width="80px">个人头像</td>   <!--头像类型为file,存的地址，要转换，不用iamgeName-->
            <td ><input type="file" id="imageFile" name="imageFile" style="width: 400px"/></td>
        </tr>

        <tr>
            <td width="80px">个人简介</td>
            <td>
                <!--副文本,用script-->
                <script id="editor" type="text/plain" style="width: 100%;height: 500px"></script>
            </td>
        </tr>

        <tr>
            <td></td>
            <!--发布按钮-->
            <td ><a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">提交</a></td>
        </tr>

    </table>
    </form>
</div>

<!--得到包含富文本的个人简介，不能从Session里直接拿，用ajax-->
<script type="text/javascript">
    //实例化文本编辑器
    var ue=UE.getEditor("editor");
    ue.addListener("ready",function ()
    {
        //通过ajax获取数据
        UE.ajax.request("${pageContext.request.contextPath}/admin/blogger/find.do",
            {
                method:"post", //用post方式访问
                asyn:false,  //不异步
                onsuccess:function (result)
                {
                    result=eval("("+result.responseText+")");  //result就是Blogger对象
                    UE.getEditor("editor").setContent(result.profile);
                }

            });
    });

</script>

</body>
</html>