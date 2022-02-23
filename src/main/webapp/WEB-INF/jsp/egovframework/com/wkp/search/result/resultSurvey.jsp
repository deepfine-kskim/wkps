<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${srvTotal > 0}">
<div class="section_sch_result">
	<div class="result_head">
	<!-- 09-16 리뷰용 수정 -->
		<strong>설문조사</strong> <span class="text-primary">(총 <fmt:formatNumber value="${srvTotal}" groupingUsed="true"/>건)</span>
	</div>
	<ul class="sch_result_list">
		<c:forEach var="result" items="${srvList}" varStatus="status">
		<li>
			<div class="tit"><a href="${result.url}"><c:out value="${result.title}"  escapeXml="false"/></a>
			<span class="info"><fmt:parseDate var="date" value="${result.regist_dtm}"  pattern="yyyyMMddHHmmss"/>
			<fmt:formatDate value="${date}"  pattern="yyyy-MM-dd"/><span>등록자:<c:out value="${result.register_name}"  escapeXml="false"/></span></span>
			</div>
			<div class="data_box">
				<div class="txt">
					<c:out value="${result.survey_desc}"  escapeXml="false"/>
				</div>
			</div>
		</li>
		</c:forEach>
	</ul>
                                        
	<!-- //09-16 리뷰용 수정 -->
	<c:if test="${srvTotal > params.pageSize}">
	  <c:choose>
	  	<c:when test="${params.category ne 'srv'}">
	<div class="more_btn_area">
		<a href="javascript:goCategory('srv');" class="btn btn-warning outline">검색 결과 더보기</a>
	</div>

	    </c:when>
	    <c:otherwise>
	    	<div class="text-center"><ul class="pagination" id="pagination"></ul></div>
	  	</c:otherwise>
	  </c:choose>
	</c:if>
</div>

<script> 
	if(${params.category eq 'srv'}){
		document.write(pageNav('gotopage','${params.pageNum}','10','${srvTotal}','1'));
	}
</script>
</c:if>                                          