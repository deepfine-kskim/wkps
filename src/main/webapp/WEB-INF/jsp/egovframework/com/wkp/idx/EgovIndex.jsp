<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<div id="contents" class="main_contents">
    <div class="total_srch_area">
        <div class="container-fluid">
            <form name="totalSrchFrm" action="/search.do" class="form">
				<input type="hidden" name="OC" value="regina1102">
				<input type="hidden" name="target" value="law">
				<input type="hidden" name="type" value="HTML">
				<input type="hidden" name="org" value="6410000">
                <!-- 2020-11-20 변경 시작 -->
                <div class="srch_box">
                    <fieldset>
                        <legend class="sr-only">통합검색</legend>
                        <div class="input-group input-group-lg">
                            <div class="dropdown srch_select">
                                <button type="button" class="btn dropdown-toggle" id="schSortOpt" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                    <span class="selection">통합검색</span> <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="schSortOpt">
                                    <li id="total" class="active"><a href="#">통합검색</a></li>
                                    <li id="law"><a href="#">법령정보</a></li>
                                    <li id="ordin"><a href="#">자치법규</a></li>
                                </ul>
                            </div>
                            <label for="totalSrchStr" class="sr-only">검색어 입력</label>
                            <input type="text" id="srchText" name="kwd" class="form-control" placeholder="통합검색, 법령정보, 자치법규 선택 후 검색어를 입력하세요." required/>
                            <span class="input-group-btn">
                                <button type="button" id="srchBtn" class="btn btn-warning"><i class="ti-search"></i><span class="sr-only">검색</span></button>
                            </span>
                        </div>
                    </fieldset>
                </div>
                <!-- 2020-11-20 변경 종료 -->
                <ul class="keyword_list">
                	<c:forEach var="keyword" items="${ppkList }">
                    <li><a href="javascript:;" class="kwdSrch" data-keyword="${keyword.ppk}">#${keyword.ppk}</a></li>
                    </c:forEach>
                </ul>
            </form>
        </div>
    </div>
    <div class="container main_grid_area">
        <div class="row">
            <div class="col-sm-12 col-md-6">
                <div class="frame">
                    <h2>공지사항${menuList }</h2>
                    <ul class="latest_list">
                    	<c:forEach var="notice" items="${noticeList }">
                        <li>
                            <p class="subject">
                            	<a href="/bbs/noticeDetail.do?noticeNo=${notice.noticeNo }">${notice.title }
                            	<c:if test="${notice.isNew }"><span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span></c:if>
                            	</a>
                            </p>
                            <span class="date">${notice.registDtm }</span>
                        </li>
                        </c:forEach>
                    </ul>
                    <a href="/bbs/noticeList.do" class="btn_more" title="더보기"><i class="ti-plus" aria-hidden="true"></i><span class="sr-only">더보기</span></a>
                </div>
            </div>
            <c:choose>
                <c:when test="${not empty excellenceUserList || not empty excellenceOrgList}">
                    <div class="col-sm-6 col-md-3">
                        <div class="frame main_ranking1">
                            <h2>지식 챔피언 (1주일)</h2>
                            <div class="ranking__wrap">
                                <ol class="ranking_list">
                                    <c:forEach var="user" items="${excellenceUserList }" varStatus="status">
                                        <c:if test="${status.index < 5}">
                                            <li><em class="num">${user.rki }</em>${user.displayName }<span class="small">(${user.ou })</span></li>
                                        </c:if>
                                    </c:forEach>
                                </ol>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-3">
                        <div class="frame main_ranking2">
                            <h2>지식 부서 (1주일)</h2>
                            <div class="ranking__wrap">
                                <ol class="ranking_list">
                                    <c:forEach var="org" items="${excellenceOrgList }" varStatus="status">
                                        <c:if test="${status.index < 5}">
                                            <li><em class="num">${org.rki }</em> ${org.ou }</li>
                                        </c:if>
                                    </c:forEach>
                                </ol>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </div>
    </div>
    <div class="main_tabs_area">
        <div class="container">
            <div class="row_tab">
                <div class="col_btn">
                    <ul class="nav nav-pills" role="tablist">
                        <li role="presentation" class="active"><a href="#mainTab1" aria-controls="mainTab1" role="tab" data-toggle="tab">최신 지식</a></li>
                        <li role="presentation"><a href="#mainTab2" aria-controls="mainTab2" role="tab" data-toggle="tab">추천 지식</a></li>
                        <c:if test="${loginVO.ou ne '행정1부지사' and loginVO.ou ne '행정2부지사' and loginVO.ou ne '평화부지사' and loginVO.ou ne '경기도위원회'}">
                            <li role="presentation"><a href="#mainTab3" aria-controls="mainTab3" role="tab" data-toggle="tab">맞춤 지식</a></li>
                        </c:if>
                    </ul>
                </div>
                <div class="col_cont">
                    <div class="tab-content">
                        <div id="mainTab1" class="tab-pane active" role="tabpanel">
                            <div class="card_slider_area">
                                <div class="card_item_list owl-carousel owl-theme refresh">
                                    <c:forEach var="newKnowledge" items="${newKnowledgeList}">
                                        <div class="card_item">
                                            <a href="/kno/knowledgeDetail.do?knowlgNo=<c:out value="${newKnowledge.knowlgNo}"/>">
                                                <c:choose>
                                                    <c:when test="${newKnowledge.knowlgMapType eq 'REPORT'}">
                                                        <span class="label label-warning">행정자료</span>
                                                    </c:when>
                                                    <c:when test="${newKnowledge.knowlgMapType eq 'REFERENCE'}">
                                                        <span class="label label-primary">업무참고자료</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="label label-success">개인행정지식</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="caption_box">
                                                    <strong class="subject">${newKnowledge.title}</strong>
                                                    <p class="txt">${newKnowledge.summry}</p>
                                                </div>
                                                <span class="date">${newKnowledge.registDtm}</span>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div id="mainTab2" class="tab-pane" role="tabpanel">
                            <div class="card_slider_area">
                                <div class="card_item_list owl-carousel owl-theme">
                                	<c:forEach var="recommendKnowledge" items="${recommendKnowledgeList}">
                                        <div class="card_item">
                                            <a href="/kno/knowledgeDetail.do?knowlgNo=<c:out value="${recommendKnowledge.knowlgNo}"/>">
                                                <c:choose>
                                                    <c:when test="${recommendKnowledge.knowlgMapType eq 'REPORT'}">
                                                        <span class="label label-warning">행정자료</span>
                                                    </c:when>
                                                    <c:when test="${recommendKnowledge.knowlgMapType eq 'REFERENCE'}">
                                                        <span class="label label-primary">업무참고자료</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="label label-success">개인행정지식</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="caption_box">
                                                    <strong class="subject">${recommendKnowledge.title}</strong>
                                                    <p class="txt">${recommendKnowledge.summry}</p>
                                                </div>
                                                <span class="date">${recommendKnowledge.registDtm}</span>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div id="mainTab3" class="tab-pane" role="tabpanel">
                            <div class="card_slider_area">
                                <div class="card_item_list owl-carousel owl-theme">
                                	<c:forEach var="personalizeKnowledge" items="${personalizeKnowledgeList}">
                                        <div class="card_item">
                                            <a href="/kno/knowledgeDetail.do?knowlgNo=<c:out value="${personalizeKnowledge.knowlgNo}"/>">
                                                <c:choose>
                                                    <c:when test="${personalizeKnowledge.knowlgMapType eq 'REPORT'}">
                                                        <span class="label label-warning">행정자료</span>
                                                    </c:when>
                                                    <c:when test="${personalizeKnowledge.knowlgMapType eq 'REFERENCE'}">
                                                        <span class="label label-primary">업무참고자료</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="label label-success">개인행정지식</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="caption_box">
                                                    <strong class="subject">${personalizeKnowledge.title}</strong>
                                                    <p class="txt">${personalizeKnowledge.summry}</p>
                                                </div>
                                                <span class="date">${personalizeKnowledge.registDtm}</span>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //CONTNETS -->
<script>
	$(function(){
        let errMsg = '${errMsg}';
        if (errMsg != '') {
            alert(errMsg);
        }

	    $('.srch_select .dropdown-menu li a').click(function(){
	        var selText = $(this).text();
	        $('.srch_select .dropdown-menu li').removeClass('active');
	        $(this).parents('li').addClass('active');
	        $(this).parents('.srch_select').find('.dropdown-toggle .selection').html(selText);
	    });
	    
	    $('#total').click(function(){
        	$('#srchText').attr('name', 'kwd');
	    	var form = $("form[name=totalSrchFrm]");
            form.attr("action", "/search.do");
        	form.attr("target","_self");
	    });
	    
	    $('#law').click(function(){
        	// $('#srchText').attr('name', 'query');
            $('#srchText').attr('name', 'kwd');
	    	var form = $("form[name=totalSrchFrm]");
            form.find("input[name=target]").val('law');
            form.find("input[name=org]").val('');
            // form.attr("action", "http://www.law.go.kr/DRF/lawSearch.do");
            form.attr("action", "/searchLaw.do");
        	form.attr("target","_blank");
	    });
	    
	    $('#ordin').click(function(){
        	// $('#srchText').attr('name', 'query');
            $('#srchText').attr('name', 'kwd');
	    	var form = $("form[name=totalSrchFrm]");
            form.find("input[name=target]").val('ordin');
            form.find("input[name=org]").val('6410000');
            // form.attr("action", "http://www.law.go.kr/DRF/lawSearch.do");
            form.attr("action", "/searchLaw.do");
        	form.attr("target","_blank");
	    });
	    
	    $('#srchBtn').click(function(){
	    	if($('#srchText').val() == ''){
	    		alert('검색어를 입력하세요.');
	    		return false;
	    	}
	    	
	    	var form = $("form[name=totalSrchFrm]");
	    	form.submit();
	    });
	    
	    $('.kwdSrch').click(function(){
	    	var keyword = $(this).data('keyword');
	    	$('#srchText').attr('name', 'kwd');
	    	var form = $("form[name=totalSrchFrm]");
	    	form.find("input[name=kwd]").val(keyword);
	        form.attr("action", "/search.do");
	    	form.attr("target","_self");
	        form.submit();
	    });
	    
	});
</script>