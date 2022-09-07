<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--引入标签,用于遍历-->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>博主注册页面</title>

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
    /**注册*/
    function submitData()
    {
      var userName=$("#userName").val();//获取用户名值
      var password=$("#password").val();//获取密码
      var password_ver=$("#password_ver").val();//获取确认密码


      if(userName==null||userName=='')
        $.messager.alert("系统提示","请输入用户名!");
      else if (password==null||password=='')
        $.messager.alert("系统提示","请输入密码!");
      else if(password_ver!=password)
        $.messager.alert("系统提示","前后密码不一致，请再次输入!");
      else
      {
        $.post("${pageContext.request.contextPath}/blogger/register.do",
                {'userName':userName,'password':password},
                function (result)
                {
                  if(result.success)
                    $.messager.alert("系统提示","注册成功!");
                  else
                    $.messager.alert("系统提示",",用户已存在，注册失败!");

                },"json");
      }
    }
  </script>


</head>
<body style="text-align: center" >

<div id="p" class="easyui-panel" title="用户注册" style="padding: 10px ">
  <table cellspacing="20px">
    <tr>
      <td width="80px">用户名</td>
      <td ><input type="text" id="userName" name="userName" style="width: 400px"></td>
    </tr>

    <tr>
      <td width="80px">密码</td>
      <td ><input type="text" id="password" name="password" style="width: 400px"></td>
    </tr>

    <tr>
      <td width="80px">请再次确认密码</td>
      <td ><input type="text" id="password_ver" name="password_ver" style="width: 400px"></td>
    </tr>


    <tr>
      <td></td>
      <!--发布按钮-->
      <td ><a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">注册</a></td>
    </tr>

  </table>
</div>

</body>
</html>