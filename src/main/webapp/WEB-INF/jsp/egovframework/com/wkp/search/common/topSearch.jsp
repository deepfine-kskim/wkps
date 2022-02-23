<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="js/search.js"></script><!-- Events -->	

<form  id="searchForm" role="form">
<div class="row type5 sch_bar_area">     
     <div  class="col-md-10">
          <fieldset>
          <div class="input-group input-group-lg">
                <label for="schAllStr" class="sr-only">통합검색</label>
				<input type="text" id="topKwd" name="kwd" class="form-control" value="<c:out value='${params.kwd}'/>" placeholder="검색어를 입력해주세요." /><!-- 09.14 리뷰용 수정 -->
                <span class="input-group-btn">
                	<button type="button" class="btn btn-warning" onclick="javascript:srchKwd()"><i class="ti-search"></i> <span class="sr-only">검색</span></button>
                </span>
          </div>
          </fieldset>
     </div>
      
     <div class="col-md-2">
     	<div class="checkbox mb_0">
          <!-- <label for="reSearch" class="text-primary">
          	<input type="checkbox" id="resrchFlag" name="reSearch" /> 결과 내 재 검색
          </label> -->
          <input type="hidden" id="topPreKwds" name="preKwds" value="${params.preKwds}">
     	</div>
     </div>
    
</div>

<div class="row type5 top_opt_row">
	
	<!-- 연관어 검색 -->
	<c:if test="${not empty suggestions}">
    <div class="col-xs-12 col-sm-8">
        <div class="relation_keyword_area">
            <strong class="text-primary tit"><i class="fa fa-search-plus" aria-hidden="true"></i> 연관 검색어</strong>
            <ul class="list-inline">
				<c:forEach var="suggestion" items="${suggestions}">
					<li><a href="javascript:ppkSrch('${suggestion}');"><c:out value="${suggestion}"/></a></li>
				</c:forEach>
			</ul>
        </div>
    </div>
    </c:if>
    <!-- // 연관어 검색 -->
    <div class="col-xs-12 <c:if test="${not empty suggestions}">col-sm-4</c:if><c:if test="${empty suggestions}">col-sm-12</c:if> text-right">
        <div class="dropdown d-inline-block">
            <button class="btn btn-default dropdown-toggle outline" type="button" id="schSortOpt" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                정렬 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="schSortOpt">
                <li><a href="javascript:sortSrch('r')">정확도순</a></li>
                <li><a href="javascript:sortSrch('d')">최신순</a></li>
            </ul>
        </div>
        <a href="#advancedSearch" class="btn btn-black" data-toggle="collapse" aria-expanded="false" aria-controls="advancedSearch"><i class="ti-zoom-in"></i> 상세검색</a>
    </div>
    <div class="col-xs-12">
        <jsp:include page="detailed-search.jsp"/>
    </div>
</div>
</form>

<script>
        $(document).ready(function() {
            $("#topKwd").keydown(function(key) {
                if (key.keyCode == 13) {
                    srchKwd();
                }
            });
        });
</script>