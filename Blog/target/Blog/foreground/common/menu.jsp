<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
	/**检验输入的搜索内容合法性*/
	function checkData()
	{
		var q=document.getElementsById("q").value.trim();
		if(q==null||q=="")
		{
			alert("请输入要搜索的关键字！");
			return false;
		}
		else
			return true;
	}

</script>
<div class="row">
	<div class="col-md-12" style="padding-top: 10px">
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		      <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html"><font color="#8a2be2"><strong>首页</strong></font></a>
		    </div>

		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
		      <ul class="nav navbar-nav">
		        <li><a href="${pageContext.request.contextPath}/login.jsp"><font color="#8a2be2"><strong>登录后台</strong></font></a></li>
		      </ul>
				<!--onsubmit:提交前校验-->
		      <form class="navbar-form navbar-right" action="${pageContext.request.contextPath}/blog/q.html" method="post" onsubmit="return checkData()">
				  <br/>

				  <div class="form-group" >
		          <input type="text" id="q" name="q" class="form-control" placeholder="请输入要查询的关键字..." style="color: grey">
		        </div>
		        <button type="submit" class="btn btn-default" style="color: #99cdff">搜索</button>
		      </form>
		    </div>
		  </div>
		</nav>
	</div>
</div>















