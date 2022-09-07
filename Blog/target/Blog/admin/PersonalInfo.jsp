
<!--个人信息展示页-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人信息页面</title>

    <!--类似修改博客-->
    <!--引入css-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">   <!--jquery easyui-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">   <!--引入icons-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/blog.css">

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


</head>
<body>

    <!--用post上传图像
    enctype:支持图片-->

<div class="col-md-3">
<div class="data_list">
    <div class="data_list_title">
        <img src="${pageContext.request.contextPath}/static/images/user_icon.png"/>
        博主信息
    </div>
    <div class="user_image">
        <img src="${pageContext.request.contextPath}/static/userImages/${currentUser.imageName}"/>
    </div>
    <div style="text-align: center">${currentUser.userName}</div>
    <div style="text-align: left">昵称：${currentUser.nickName}</div>
    <div style="text-align: left">个性签名：${currentUser.sign}</div>
    <div style="text-align: left">个人简介：${currentUser.profile}</div>
</div>
</div>



</body>
</html>