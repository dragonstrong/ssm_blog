
<!--博客详情展示-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!--引入jsp c标签，用于遍历-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--引入时间转换标签，用于日期转换-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="data_list">
		<div class="data_list_title"><img src="${pageContext.request.contextPath}/static/images/blog_show_icon.png"/>博客信息</div>
		<div class="blog_title"><h3><strong>${blog.title}</strong></h3></div>
		<div class="blog_info"><fmt:formatDate value="${blog.releaseDate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;${blog.keyWord}</div>

		<div style="padding-left: 380px;padding-bottom: 20px;padding-top: 10px">
			<div class="bshare-custom">
				<!--利用第三方插件定制分享功能-->
				<script type="text/javascript" charset="UTF-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=1&amp;Lang=zh"></script>
				<script type="text/javascript" charset="UTF-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
				<a title="分享到QQ空间" class="bshare-qzone"></a>
				<a title="分享到新浪微博" class="bshare-sinaminiblog"></a>
				<a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a>
			</div>
		</div>

		<!--内容,class在blog.css找-->
		<div class="blog_content">${blog.content}</div>

</div>


