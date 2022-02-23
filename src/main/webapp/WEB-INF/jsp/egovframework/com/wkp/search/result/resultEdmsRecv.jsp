<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${edmsRecvTotal > 0}">
<div class="section_sch_result">
	<div class="result_head">
	<!-- 09-16 리뷰용 수정 -->
		<strong>전자결재 접수함</strong> <span class="text-primary">(총 <fmt:formatNumber value="${edmsRecvTotal}" groupingUsed="true"/>건)</span>
	</div>
	<ul class="sch_result_list">
		<c:forEach var="result" items="${edmsRecvList}" varStatus="status">
		<li>
			<div class="tit"><span>${result.open_flag}</span>&nbsp<span><a href="http://10.191.0.54/bms/dctenf/BmsDctEnfReceiptCardDetail.do?enfdocid=${result.doc_id}" target="_blank"><c:out value="${result.title}"  escapeXml="false"/></a></span>
			<span class="info"><fmt:parseDate var="date" value="${result.reg_dttm}"  pattern="yyyyMMddHHmmss"/>
			<fmt:formatDate value="${date}"  pattern="yyyy-MM-dd"/><span><c:out value="${result.dept_nm}"  escapeXml="false"/></span>
			<span><c:out value="${result.writer_nm}"  escapeXml="false"/></span>
			</span>
			</div>
			<!--
			<div class="data_box">
				<c:if test="${result.filename ne ''}">
				<div class="file_area">
					<c:forEach var="filename" items="${result.filename}" varStatus="status">
						<div class="file">
							<a><i class="ti-save ico" aria-hidden="true"></i><c:out value="${filename}"  escapeXml="false"/></a>
						</div>
					</c:forEach>
				</div>
				</c:if>
			</div>
			 -->
		</li>
		</c:forEach>
	</ul>
                                        
	<!-- //09-16 리뷰용 수정 -->
	<c:if test="${edmsRecvTotal > params.pageSize}">
	  <c:choose>
	  	<c:when test="${params.category ne 'edmsRecv'}">
	<div class="more_btn_area">
		<a href="javascript:goCategory('edmsRecv');" class="btn btn-warning outline">검색 결과 더보기</a>
	</div>

	    </c:when>
	    <c:otherwise>
	    	<div class="text-center"><ul class="pagination" id="pagination"></ul></div>
	  	</c:otherwise>
	  </c:choose>
	</c:if>
</div>
<script> 
	if(${params.category eq 'edmsRecv'}){
		document.write(pageNav('gotopage','${params.pageNum}','10','${edmsRecvTotal}','1'));
	}
</script>
</c:if>          

