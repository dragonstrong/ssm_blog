<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人博客系统后台管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

	var url;
	
	function openTab(text,url,iconCls){
		if($("#tabs").tabs("exists",text)){
			$("#tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/admin/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}

	/**刷新系统缓存*/
	function refreshSystem()
	{
		$.post("${pageContext.request.contextPath}/admin/system/refreshSystem.do",function (result)
		{
			if(result.success)
				$.messager.alert("系统提示","已成功刷新系统缓存");
			else
				$.messager.alert("系统提示","系统缓存刷新失败");


		},"json");

	}

	/**打开修改密码对话框*/
	function openPasswordModifyDialog()
	{
		$("#modify_password_dlg").dialog("open").dialog("setTitle","修改密码");
		url="${pageContext.request.contextPath}/admin/blogger/modifyPassword.do?id=${currentUser.id}";//不传id可以直接从Session里取
	 }

	/**修改密码*/
	function PasswordModify()
	{
		//取到提交的表格
		$("#fm").form("submit",{
			url:url,
			onSubmit:function ()  //回调函数:校验
			{
				var newPassword=$("#new_password").val();
				var password_ver=$("#password_ver").val();
				if(!$(this).form("validate")) //没有校验通过，再看原理?
				return false;
				else
				{
					if(newPassword!=password_ver)
					{
						$.messager.alert("系统提示","两次密码校验不一致");
						return true;
					}
					else
						return true;
				}
			},
			success:function (result)
			{
				var result=eval('('+result+')'); //转化为json格式
				if(result.success)
				{
					$.messager.alert("系统提示","密码修改成功,下一次登录生效！");
					closePassMoDialog();
				}
				else
				{
					$.messager.alert("系统提示","密码修改失败！");
					return;
				}
			}
		});
		url="${pageContext.request.contextPath}/admin/blogger/save.do?id=${currentUser.id}";//不传id可以直接从Session里取
	}

	/**清空新密码*/
	function resetValue()
	{
		$("#newPassword").val("");
		$("#password_ver").val("");
	}

	/**关闭修改密码窗口*/
	function closePassMoDialog()
	{
		resetValue();
		$("#modify_password_dlg").dialog("close");

	}

	/**安全退出*/
    function logout()
	{

		$.messager.confirm("系统提示","您确定要退出系统吗？",
		function (r)
		{
			if(r) //用户选择是
			{
				window.location.href="${pageContext.request.contextPath}/admin/blogger/logout.do";
			}
		});

		/*
		不知道为什么下面这种写法不行

		url="${pageContext.request.contextPath}/admin/blogger/logout.do";
		*/

	}

</script>
</head>
<body class="easyui-layout">
<div region="north" style="height: 60px;background-color: #E0ECFF;overflow:hidden">
	<table style="padding: 5px" width="100%">
		<tr>
			<td style="padding-top: 16px" valign="middle" align="left" width="50%">
				<font size="3">&nbsp;&nbsp;<strong>个人博客系统</strong></font>
				<a href="${pageContext.request.contextPath}/index.html"><font size =3 color="#8a2be2"><strong>[首页]</strong></font></a>
			</td>
		</tr>
	</table>
</div>


<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
		</div>
	</div>
</div>

<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">		
		<div title="博客管理"  data-options="iconCls:'icon-bkgl'" style="padding:10px;">
			<a href="javascript:openTab('写博客','writeBlog.jsp','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">写博客</a>
			<a href="javascript:openTab('博客信息管理','blogManage.jsp','icon-bkgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bkgl'" style="width: 150px;">博客信息管理</a>
		</div>
		<div title="博客类别管理" data-options="iconCls:'icon-bklb'" style="padding:10px">
			<a href="javascript:openTab('博客类别信息管理','blogTypeManage.jsp','icon-bklb')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;">博客类别信息管理</a>
		</div>
		<div title="评论管理"  data-options="iconCls:'icon-plgl'" style="padding:10px">
			<a href="javascript:openTab('评论审核','commentReview.jsp','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">评论审核</a>
			<a href="javascript:openTab('评论信息管理','commentManage.jsp','icon-plgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-plgl'" style="width: 150px;">评论信息管理</a>
		</div>
		<div title="个人信息管理"  data-options="iconCls:'icon-grxx'" style="padding:10px">
			<a href="javascript:openTab('个人信息','PersonalInfo.jsp','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">个人信息</a>
			<a href="javascript:openTab('修改个人信息','modifyInfo.jsp','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">修改个人信息</a>
		</div>
		<div title="系统管理"  data-options="iconCls:'icon-system'" style="padding:10px">
		    <a href="javascript:openTab('友情链接管理','linkManage.jsp','icon-link')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-link'" style="width: 150px">友情链接管理</a>
			<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
			<a href="javascript:refreshSystem()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-refresh'" style="width: 150px;">刷新系统缓存</a>
			<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
		</div>
	</div>
</div>
<div region="south" style="height: 25px;padding: 5px" align="center">
	
</div>


<!--修改密码对话框-->
<div id="modify_password_dlg" class="easyui-dialog" style="width: 400px;height: 200px;padding: 10px 20px"
	 closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table cellspacing="8px">
			<tr>
				<td>用户名:</td>
				<td><input type="text" id="userName" name="userName" value="${currentUser.userName}" readonly="readonly" style="width: 200px"></td>
			</tr>
			<tr>
				<td>新密码:</td>
				<td><input type="text" id="new_password" name="new_password" class="easyui-validatebox" required="true" style="width: 200px"></td>
			</tr>
			<tr>
				<td>请确认密码:</td>
				<td><input type="text" id="password_ver" name="password_ver" class="easyui-validatebox" required="true" style="width: 200px"></td>
			</tr>
		</table>

	</form>
</div>

<!--保存、关闭按钮-->
<!--id不能随便取，要和modify_password_dlg里buttons属性一致-->
<div id="dlg-buttons">
	<a href="javascript:PasswordModify()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closePassMoDialog()" class="easyui-linkbutton" iconCls="icon-cancle">关闭</a>
</div>

</body>
</html>