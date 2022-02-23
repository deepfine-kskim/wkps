<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${not empty suggestions}">
  <dl class="suggestions dl-horizontal">
    <dt><span>연관어</span></dt>
    <dd>
      <ul class="list-inline">
      <c:forEach var="suggestion" items="${suggestions}">
        <li><a href="#"><c:out value="${suggestion}"/></a></li>
      </c:forEach>
      </ul>
    </dd>
  </dl>
</c:if> 

 
<c:if test="${not empty error}">
	<jsp:include page="error.jsp"/>
</c:if>

<!-- 게시판검색 -->
<%-- <jsp:include page="resultDb.jsp"/>
<jsp:include page="resultCn.jsp"/>
<jsp:include page="resultJp.jsp"/>
<jsp:include page="resultEn.jsp"/> --%>
<!-- // 게시판검색 -->				
