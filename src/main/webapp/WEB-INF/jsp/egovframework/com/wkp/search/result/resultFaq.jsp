<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${faqTotal > 0}">
<div class="section_sch_result">
	<div class="result_head">
	<!-- 09-16 리뷰용 수정 -->
		<strong>FAQ</strong> <span class="text-primary">(총 <fmt:formatNumber value="${faqTotal}" groupingUsed="true"/>건)</span>
	</div>
	<ul class="sch_result_list">
		<c:forEach var="result" items="${faqList}" varStatus="status">
		<li>
			<div class="tit"><a href="${result.url}"><c:out value="${result.title}"  escapeXml="false"/></a>
			<span class="info"><fmt:parseDate var="date" value="${result.regist_dtm}"  pattern="yyyyMMddHHmmss"/>
			<fmt:formatDate value="${date}"  pattern="yyyy-MM-dd"/><span>등록자:<c:out value="${result.register_name}"  escapeXml="false"/></span></span>
			</div>
			<div class="data_box">
				<div class="txt">
					<c:out value="${result.cont}"  escapeXml="false"/>
				</div>
				<c:if test="${result.orignl_file_nm ne ''}">
				<div class="file_area">
					<div class="file">
						<a href="/cmm/fms/FileDown.do?atchFileNo=${result.atch_file_no }&fileSn=${result.file_sn }" download><i class="ti-save ico" aria-hidden="true"></i><c:out value="${result.orignl_file_nm}"  escapeXml="false"/></a>
						<a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${result.file_stre_cours }${result.stre_file_nm }" data-fid="FAQ_${result.faq_no }">미리보기</a>
					</div>
				</div>
				</c:if>
			</div>
		</li>
		</c:forEach>
	</ul>
                                        
	<!-- //09-16 리뷰용 수정 -->
	<c:if test="${faqTotal > params.pageSize}">
	  <c:choose>
	  	<c:when test="${params.category ne 'faq'}">
	<div class="more_btn_area">
		<a href="javascript:goCategory('faq');" class="btn btn-warning outline">검색 결과 더보기</a>
	</div>

	    </c:when>
	    <c:otherwise>
	    	<div class="text-center"><ul class="pagination" id="pagination"></ul></div>
	  	</c:otherwise>
	  </c:choose>
	</c:if>
</div>

<script> 
	if(${params.category eq 'faq'}){
		document.write(pageNav('gotopage','${params.pageNum}','10','${faqTotal}','1'));
	}
</script>
</c:if>        