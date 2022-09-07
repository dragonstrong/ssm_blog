<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--引入jsp c标签，用于遍历-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title}</title>  <!--捕获-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/blog.css">
<link href="${pageContext.request.contextPath}/favicon.ico" rel="SHORTCUT ICON">
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap.min.js"></script>







<style type="text/css">
	  body {
        padding-top: 10px;
        padding-bottom: 40px;
		  background: #95B8E7;
      }
</style>
</head>
<body>
<div class="container">
	<jsp:include page="foreground/common/head.jsp"/>
	
	<jsp:include page="foreground/common/menu.jsp"/>
	
	<div class="row">
		<div class="col-md-9">
			<jsp:include page="${mainPage}"></jsp:include>
		</div>
		
		<div class="col-md-3">

			<div class="data_list">
				<div class="data_list_title">
					<img src="${pageContext.request.contextPath}/static/images/byType_icon.png"/>
					按日志类别
				</div>
				<div class="datas">
					<ul>
                        <!--遍历博客类别和对应的博客数量，从ServletContext里取出来，见InitComponent-->
                        <c:forEach var="blogTypeCount" items="${blogTypeCountList}" >
							<!--index.html会调用IndexController里的list方法查询对用的博客-->
                            <li><span><a href="${pageContext.request.contextPath}/index.html?typeId=${blogTypeCount.id}">${blogTypeCount.typename}(${blogTypeCount.blogCount})</a></span></li>
                        </c:forEach>
					</ul>
				</div>
			</div>

			<div class="data_list">
				<div class="data_list_title">
					<img src="${pageContext.request.contextPath}/static/images/byDate_icon.png"/>
					按日志日期
				</div>
				<div class="datas">
					<ul>
                        <!--按日期遍历博客类别和数量-->
                        <c:forEach var="blogCount" items="${blogCountList}" >
						<li><span><a href="${pageContext.request.contextPath}/index.html?releaseDateStr=${blogCount.releaseDateStr}">${blogCount.releaseDateStr}(${blogCount.blogCount})</a></span></li>
                        </c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>

</div>
</body>
</html>