<!--最新lucene搜索展示页-->

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!--引入jsp c标签，用于遍历-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--引入时间转换标签，用于日期转换-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="data_list">
    <div class="data_list_title">&nbsp;总共搜到&nbsp;<font color="red">${resultTotal}</font>&nbsp;条记录
    </div>
    <div class="datas">
        <ul>
            <c:choose>
                <c:when test="${blogList.size()==0}">
                    <div align="center" style="padding-top: 20px">未查询到数据，请换个关键字！</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="blog" items="${blogList}">
                        <li style="margin-bottom: 20px">
                            <span class="title">
                                <a href="${pageContext.request.contextPath}/blog/articles/${blog.id}.html" target="_blank">${blog.title}</a>
                            </span>
                            <span class="summary">摘要:${bolg.content}...</span>

							<a href="${pageContext.request.contextPath}/blog/articles/${blog.id}.html" target="_blank">
                                &nbsp;&nbsp;&nbsp;&nbsp;发布日期：${blog.releaseDateStr}
                            </a>


                        </li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </ul>
    </div>
    ${pageCode}
</div>
