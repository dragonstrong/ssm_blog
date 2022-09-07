<!--最新博客展示页-->

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!--引入jsp c标签，用于遍历-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--引入时间转换标签，用于日期转换-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style type="text/css">
	body {
		padding-top: 10px;
		padding-bottom: 40px;

	}
</style>
<div class="data_list">
		<div class="data_list_title">
		<img src="${pageContext.request.contextPath}/static/images/list_icon.png"/>
		最新博客</div>
		<div class="datas">
			<ul>
				<c:forEach var="blog" items="${blogList}"> <!--遍历blogList(IndexController index方法里的，ModelAndView能被前端捕获)-->
				  <li style="margin-bottom: 30px">
					<span class="title" style="color: #00ee00" ><a href="${pageContext.request.contextPath}/blog/articles/${blog.id}.html">${blog.title}</a></span>
					<span class="summary">${blog.summary}...</span>
					<span class="info">发表于 <fmt:formatDate value="${blog.releaseDate}" type="date" pattern="yyyy-MM-dd HH:mm"/> &nbsp; 阅读(${blog.clickHit})  </span>
				  </li>
				  <hr style="height:5px;border:none;border-top:1px dashed gray;padding-bottom:  10px;" />
				</c:forEach>
			</ul>
		</div>
   </div>

<div>
	<nav>
	  <ul class="pagination pagination-sm">
		  <!--翻页功能:接收ModelAndView的pageCode-->
		  ${pageCode}
	  </ul>
	</nav>
 </div>
