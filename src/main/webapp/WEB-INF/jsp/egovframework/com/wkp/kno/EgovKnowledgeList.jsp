<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
       <div class="container sub_cont">
           <div class="page-header">
       		    <h2>지식백과</h2>
        		<div>${menuDesc }${path }</div>
       	   </div>
		   <!-- //page-header -->
		   <div class="row layout_side_row">
                <div id="aside" class="col-md-3">
					<ul class="nav nav-tabs nav-justified side_tabs">
                        <li <c:if test="${knowlgMapType eq 'REPORT' }">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="REPORT">행정자료</a></li>
                        <li <c:if test="${knowlgMapType eq 'REFERENCE' }">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="REFERENCE">업무참고자료</a></li>
                        <li <c:if test="${knowlgMapType eq 'PERSONAL' }">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="PERSONAL">개인별지식</a></li>
                    </ul>
                    <div class="side_card_box mside_tog">
                        <div class="side_top hidden-sm hidden-lg hidden-md">
                            <strong class="name">지식분류</strong>
                            <span class="m_btn hidden-sm hidden-md hidden-lg"><i class="fa fa-chevron-down"></i></span>
                        </div>
                        <div class="mside_tog_cont">
                            <ul id="metismenu" class="tree_list tree_line list-group">
                            	<c:forEach var="main" items="${knowledgeMapList }" varStatus="status">
									<c:if test="${main.upNo eq 0}">
										<c:if test="${main.showYn eq 'Y'}">
											<c:if test="${empty main.link}">
												<li class="list-group-item<c:if test="${knowlgMap.upNo eq main.knowlgMapNo}"> active</c:if>">
													<a href="#" class="ico"><span class="sr-only">버튼</span></a>
													<a href="#">${main.knowlgMapNm }</a>
													<ul class="list-group sub_list" style="display: none;">
													<c:forEach var="sub" items="${knowledgeMapList }">
														<c:if test="${sub.upNo eq main.knowlgMapNo }">
															<li>
																<a href="javascript:;" class="lnk<c:if test="${knowlgMap.knowlgMapNo eq sub.knowlgMapNo }"> on</c:if>" data-no="${sub.knowlgMapNo }">${sub.knowlgMapNm }</a>
															</li>
														</c:if>
													</c:forEach>
													</ul>
												</li>
											</c:if>
											<c:if test="${not empty main.link}">
												<li class="list-group-item<c:if test="${knowlgMap.upNo eq main.knowlgMapNo}"> active</c:if>">
													<a href="#" class="ico"><span class="sr-only">버튼</span></a>
													<a href="${main.link}">${main.knowlgMapNm}</a>
												</li>
											</c:if>
										</c:if>
									</c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <!-- side_card_box -->
                    <div class="row type5">
                        <div class="col-sm-6 col-md-12">
                            <div class="side_card_box ranking_area box1 mside_tog">
                                <div class="side_top">
                                    <strong class="name text-black">지식 챔피언</strong>
                                    <span class="m_btn hidden-sm hidden-md hidden-lg"><i class="fa fa-chevron-down"></i></span>
                                </div>
                                <div class="mside_tog_cont">
                                    <div class="side_cont_wrap">
                                        <ol class="ranking_list">
                                        	<c:forEach var="excellenceUser" items="${excellenceUserList }">
                                            <li>
                                                <strong class="text-primary">${excellenceUser.rki }위</strong> ${excellenceUser.displayName } <span class="text-muted">(${excellenceUser.ou })</span>
                                            </li>
                                            </c:forEach>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <!-- side_card_box -->
                        </div>
                        <div class="col-sm-6 col-md-12">
                            <div class="side_card_box ranking_area box2 mside_tog">
                                <div class="side_top">
                                    <strong class="name text-black">지식 부서</strong>
                                    <span class="m_btn hidden-sm hidden-md hidden-lg"><i class="fa fa-chevron-down"></i></span>
                                </div>
                                <div class="mside_tog_cont">
                                    <div class="side_cont_wrap">
                                        <ol class="ranking_list">
                                        	<c:forEach var="excellenceOrg" items="${excellenceOrgList }">
                                            <li>
                                                <strong class="text-primary">${excellenceOrg.rki }위</strong> ${excellenceOrg.ou }
                                            </li>
                                            </c:forEach>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <!-- side_card_box -->
                        </div>
                    </div>                
                </div>
                <!-- //ASIDE -->
                <div id="contents" class="col-md-9">
                    <div class="page-body">
                            <div class="wiki_breadcrumb">
                                <div class="row type0">
                                    <div class="col-sm-6">
                                        <ol class="breadcrumb">
                                            <li>
                                            	<a href="javascript:;" class="dev-type" data-type="${knowlgMapType }">
                                            	<i class="fa fa-file-text-o ico"></i>
                                            	<c:choose>
													<c:when test="${knowlgMapType eq 'REPORT' }">행정자료</c:when>
													<c:when test="${knowlgMapType eq 'REFERENCE' }">업무참고자료</c:when>
													<c:otherwise>개인별지식</c:otherwise>
												</c:choose>
												</a>
											</li>
											<c:if test="${not empty knowlgMap.upNm }">
												<li>${knowlgMap.upNm }</li>
											</c:if>
											<c:if test="${not empty knowlgMap.knowlgMapNm }">
												<li class="active"><a href="javascript:;" class="lnk" data-no="${knowlgMap.knowlgMapNo }">${knowlgMap.knowlgMapNm }</a></li>
											</c:if>
                                        </ol>
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <button type="button" class="btn btn-default btn-sm outline ico_btn tooltip_btn" data-toggle="tooltip" data-placement="bottom" title="관심분야 버튼 클릭 시 현재 지식맵을 관심 분야로 등록합니다.">
                                            <i class="fa fa-question" aria-hidden="true"></i> <span class="sr-only">관심분야</span>
                                        </button>
                                        <button type="button" class="btn btn-sm btn-warning outline bk_btn tog_on_btn<c:if test="${isInterests }"> on</c:if>" id="interestBtn">관심분야</button>
                                    </div>
                                </div>
                            </div>
                            <div class="row type5 top_opt_row">
                                <form:form class="form-inline bbs_srch_frm" name="knowledgeFrm" modelAttribute="knowledgeVO">
                                <div class="col-xs-12 col-sm-12 text-right">
                                	<input type="hidden" name="sid" value="${loginVO.sid }">
									<input type="hidden" name="page" value="${knowledgeList.pageNavigation.pageIndex }">
                                   	<input type="hidden" name="knowlgNo" value="0">
                                   	<input type="hidden" name="title" value="">
									<input type="hidden" name="knowlgMapNo" value="${knowlgMap.knowlgMapNo }">
									<input type="hidden" name="knowlgMapType" value="${knowlgMapType }">
                                    <div class="form-inline bbs_srch_frm">
                                        <fieldset>
                                            <legend class="sr-only">게시글 검색</legend>
                                            <div class="form-group">
                                                <label for="wikiSrchSel" class="sr-only">검색대상</label>
	                                            <form:select id="brdSrchSel" path="searchType" class="form-control">
	                                                <option value="TITLE" <c:if test="${searchType eq 'TITLE' }">selected="selected"</c:if>>제목</option>
	                                                <option value="REGISTER_ID" <c:if test="${searchType eq 'REGISTER_ID' }">selected="selected"</c:if>>작성자</option>
	                                            </form:select>
                                            </div>
                                            <div class="input-group">
                                                <label for="wikiSrchStr" class="sr-only">검색어 입력</label>
                                                <input type="text" id="wikiSrchStr" name="searchText" value="${searchText }" class="form-control" placeholder="검색어" />
                                                <span class="input-group-btn"><button type="submit" class="btn btn-default">검색</button></span>
                                            </div>
                                            <a href="#wikiSearch" class="btn btn-black opt_btn" data-toggle="collapse" aria-expanded="false" aria-controls="wikiSearch"><i class="ti-zoom-in"></i>상세검색</a>
                                        </fieldset>
                                    </div>
                                </div>
                                <div class="col-xs-12">
                                    <div class="collapse" id="wikiSearch">
                                        <div class="form-horizontal">
                                            <div class="well frm_well mt_5">
                                                <div class="form-group inp_set_area">
                                                    <strong class="col-sm-2 control-label">기간</strong>
                                                    <div class="col-sm-10">
                                                        <label for="schDate1" class="radio-inline">
                                                            <input type="radio" id="schDate1" name="searchDate" value="WEEK" <c:if test="${searchDate eq 'WEEK' }">checked="checked"</c:if>> 1주일
                                                        </label>
                                                        <label for="schDate2" class="radio-inline">
                                                            <input type="radio" id="schDate2" name="searchDate" value="MONTH" <c:if test="${searchDate eq 'MONTH' }">checked="checked"</c:if>> 1개월
                                                        </label>
                                                        <label for="schDate3" class="radio-inline">
                                                            <input type="radio" id="schDate3" name="searchDate" value="YEAR" <c:if test="${searchDate eq 'YEAR' }">checked="checked"</c:if>> 1년
                                                        </label>
                                                        <label for="schDate4" class="radio-inline">
                                                            <input type="radio" id="schDate4" name="searchDate" class="inp_tog" value="SELECT" <c:if test="${searchDate eq 'SELECT' }">checked="checked"</c:if>> 기간선택
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-8 col-sm-push-2 col-lg-7 mt_5 inp_tog_cont">
                                                        <div class="row type1">
                                                            <div class="col-xs-6">
                                                                <lable for="inpStartDate" class="sr-only">시작날짜</lable>
                                                                <input type="text" class="form-control inp_date datetime" id="inpStartDate" name="startDate" placeholder="시작날짜" value="${startDate }"/>
                                                            </div>
                                                            <div class="col-xs-6">
                                                                <lable for="inpEndDate" class="sr-only">종료날짜</lable>
                                                                <input type="text" class="form-control inp_date datetime" id="inpEndDate" name="endDate" placeholder="종료날짜" value="${endDate }"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group inp_set_area">
                                                    <strong class="col-sm-4 control-label"><span class="req">*</span> 작성자</strong>
                                                    <div class="col-sm-8 tree_chk_area">
                                                        <label for="selWriter1" class="radio-inline">
                                                            <input type="radio" id="selWriter1" name="searchWriter" value="ALL" <c:if test="${searchWriter eq 'ALL' }">checked="checked"</c:if>/> 전체
                                                        </label>
                                                        <label for="selWriter2" class="radio-inline">
                                                            <input type="radio" id="selWriter2" name="searchWriter" value="MINE" <c:if test="${searchWriter eq 'MINE' }">checked="checked"</c:if>/> 본인
                                                        </label>
                                                        <label for="selWriter3" class="radio-inline">
                                                            <input type="radio" id="selWriter3" name="searchWriter" class="inp_tog" value="SELECT" <c:if test="${searchWriter eq 'SELECT' }">checked="checked"</c:if>/> 지정
                                                        </label>
                                                        <a href="#selectGrpPopup" class="btn btn-xs btn-primary inp_tog_cont" data-toggle="modal" data-target="#selectGrpPopup">개인 선택</a>
                                                        <div id="rlsList" class="tag_grp_area">
                                                        </div>
                                                    </div>
                                                </div>
                                                <hr />
                                                <div class="text-center">
                                                    <button type="submit" class="btn btn-warning btn-sm"><i class="ti-search" aria-hidden="true"></i> 검색</button>
                                                    <button type="button" class="btn btn-black btn-sm" data-toggle="collapse" data-target="#wikiSearch" aria-expanded="false" aria-controls="wikiSearch">닫기</button>
                                                </div>
                                            </div>
                                            <!-- well -->
                                        </div>
                                    </div>
                                </div>
				                <!-- 조직그룹 선택 팝업 -->
				                <!-- <div class="modal fade" id="selectGrpPopup" tabindex="-1" role="dialog" aria-labelledby="selectGrpPopupLabel">
				                    <div class="modal-dialog" role="document">
					                    <div class="modal-content">
					                        <div class="modal-header">
					                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					                            <h4 class="modal-title" id="selectGrpPopupLabel">부서/개인 선택</h4>
					                        </div>
					                        <div class="modal-body">
					                            <ul class="nav nav-tabs" role="tablist">
					                                <li role="presentation" class="active"><a href="#selectGrpTab1" aria-controls="selectGrpTab1" role="tab" data-toggle="tab">부서</a></li>
					                                <li role="presentation"><a href="#selectGrpTab2" aria-controls="selectGrpTab2" role="tab" data-toggle="tab">개인</a></li>
					                            </ul>
					                            <div class="tab-content">
					                                <div id="selectGrpTab1" class="tab-pane active" role="tabpanel">
					                                    <div class="srch_area">
					                                        <fieldset>
					                                            <legend class="sr-only">이름 검색영역</legend>
					                                            <div class="input-group">
					                                                <label for="orgText" class="sr-only">이름 입력</label>
					                                                <input type="text" id="orgText" name="orgText" class="form-control" placeholder="부서 검색(2글자 이상)">
					                                                <span class="input-group-btn"><a href="javascript:;" id="orgBtn" class="btn btn-default">검색</a></span>
					                                            </div>
					                                        </fieldset>
					                                    </div>
					                                    <div class="hummingbird-treeview well chk_tree_area">
					                                        <div class="checkbox">
					                                            <label for="allChk1"><input type="checkbox" id="allChk1" class="all_chk" /> 전체선택</label>
					                                        </div>
					                                        트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기
					                                        <ul id="orgList" class="chk_tree_list hummingbird-base treeview">
					                                        </ul>
					                                    </div>
					                                </div>
					                                <div id="selectGrpTab2" class="tab-pane" role="tabpanel">
					                                    <div class="srch_area">
					                                        <fieldset>
					                                            <legend class="sr-only">이름 검색영역</legend>
					                                            <div class="input-group">
					                                                <label for="userText" class="sr-only">이름 입력</label>
					                                                <input type="text" id="userText" name="userText" class="form-control" placeholder="이름 검색(2글자 이상)">
					                                                <span class="input-group-btn"><a href="javascript:;" id="userBtn" class="btn btn-default">검색</a></span>
					                                            </div>
					                                        </fieldset>
					                                    </div>
					                                    <div class="hummingbird-treeview well chk_tree_area">
					                                        <div class="checkbox">
					                                            <label for="allSrchChk"><input type="checkbox" id="allSrchChk" class="all_chk" /> 전체선택</label>
					                                        </div>
					                                        <ul id="userList" class="chk_tree_list hummingbird-base treeview">
					                                        </ul>
					                                    </div>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="modal-footer">
					                            <button type="button" id="rlsChk" class="btn btn-blue" data-dismiss="modal">확인</button>
					                        </div>
					                    </div>
				                    </div>
				                </div> -->
				                <div class="modal fade" id="selectGrpPopup" tabindex="-1" role="dialog" aria-labelledby="selectGrpPopupLabel">
				                    <div class="modal-dialog" role="document">
					                    <div class="modal-content">
					                        <div class="modal-header">
					                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					                            <h4 class="modal-title" id="selectGrpPopupLabel">개인 선택</h4>
					                        </div>
					                        <div class="modal-body">
					                            <ul class="nav nav-tabs" role="tablist">
					                                <li role="presentation" class="active"><a href="#selectGrpTab1" aria-controls="selectGrpTab1" role="tab" data-toggle="tab">개인</a></li>
					                            </ul>
					                            <div class="tab-content">
					                                <div id="selectGrpTab1" class="tab-pane active" role="tabpanel">
					                                    <div class="srch_area">
					                                        <fieldset>
					                                            <legend class="sr-only">이름 검색영역</legend>
					                                            <div class="input-group">
					                                                <label for="userText" class="sr-only">이름 입력</label>
					                                                <input type="text" id="userText" name="userText" class="form-control" placeholder="이름 검색(2글자 이상)">
					                                                <span class="input-group-btn"><a href="javascript:;" id="userBtn" class="btn btn-default">검색</a></span>
					                                            </div>
					                                        </fieldset>
					                                    </div>
					                                    <div class="hummingbird-treeview well chk_tree_area">
					                                        <div class="checkbox">
					                                            <label for="allSrchChk"><input type="checkbox" id="allSrchChk" class="all_chk" /> 전체선택</label>
					                                        </div>
					                                        <ul id="userList" class="chk_tree_list hummingbird-base treeview">
					                                        	<c:forEach var="top" items="${topList }" varStatus="topStatus">
				                                                <li>
				                                                	<i class="fa fa-plus" data-code="${top.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }" />${top.ou }</label>
				                                                    <ul>
				                                                    	<c:forEach var="parent" items="${parentList }" varStatus="parentStatus">
				                                                    	<c:if test="${parent.parentOuCode eq top.ouCode }">
				                                                        <li>
				                                                            <i class="fa fa-plus" data-code="${parent.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }" />${parent.ou }</label>
				                                                            <ul class="not_depth_list">
				                                                            	<c:forEach var="child" items="${childList }" varStatus="childStatus">
				                                                            	<c:if test="${child.parentOuCode eq parent.ouCode }">
				                                                                <li>
				                                                                	<i class="fa fa-plus" data-code="${child.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" />${child.ou }</label>
				                                                                	<ul>
				                                                                	</ul>
				                                                                </li>
				                                                                </c:if>
				                                                                </c:forEach>
				                                                            </ul>
				                                                        </li>
				                                                        </c:if>
				                                                        </c:forEach>
				                                                    </ul>
				                                                </li>
				                                                </c:forEach>
					                                        </ul>
					                                    </div>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="modal-footer">
					                            <button type="button" id="rlsChk" class="btn btn-blue" data-dismiss="modal">확인</button>
					                        </div>
					                    </div>
				                    </div>
				                </div>
				                <!-- //조직그룹 선택 팝업 -->
                                </form:form>
                            </div>
                            <!-- //row -->
                            <!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table text-center table-bordered table-hover brd_list">
                                    <caption class="sr-only">게시판 목록</caption>
                                    <colgroup>
                                        <col style="width:6%;">
                                        <col style="width:13%;">
                                        <col>
                                        <col style="width:12%;">
                                        <col style="width:12%;">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">번호</th>
                                            <th scope="col">유형</th>
                                            <th scope="col">제목</th>
                                            <th scope="col">등록일</th>
                                            <th scope="col">${knowlgMapType eq 'PERSONAL' ? '게시자' : '부서'}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                    	<c:when test="${not empty knowledgeList.list && fn:length(knowledgeList.list) > 0 }">
											<c:forEach var="knowledge" items="${knowledgeList.list }" varStatus="status">
												<tr>
													<td>${knowledgeList.pageNavigation.totalItemCount - ((knowledgeList.pageNavigation.pageIndex - 1) * knowledgeList.pageNavigation.itemCountPerPage + status.index) }</td>
													<td class="text-primary"><c:out value="${knowledge.knowlgMapNm}"/></td>
													<td class="text-left">
														<p class="subject">
															<a href="javascript:;" class="dev-detail" data-knowlgno="${knowledge.knowlgNo }" data-title="${knowledge.title }">${knowledge.title }</a>
															<c:if test="${knowledge.isNew }"><span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span></c:if>
														</p>
													</td>
													<td>${knowledge.registDtm }</td>
													<td>${knowlgMapType eq 'PERSONAL' ? knowledge.displayName : knowledge.ou}</td>
												</tr>
											</c:forEach>
                                    	</c:when>
                                        <c:otherwise>
											<!-- 데이터 없을시 -->
											<tr>
												<td colspan="5" class="empty">등록된 게시글이 없습니다.</td>
											</tr>
											<!-- //데이터 없을시 -->
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <!-- //게시판 목록 -->
                    		<!-- 페이지 네비 -->
		                    <nav class="text-center">
		                        <ul class="pagination pagination-sm">
		                        <c:if test="${knowledgeList.pageNavigation.totalItemCount > 0 }">
		                            <c:if test="${knowledgeList.pageNavigation.canPreviousSection == true }">
		                            <li>
		                                <a href="javascript:;" aria-label="Previous" title="처음" class="dev-page" data-page="1">
		                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            <li>
		                                <a href="javascript:;" aria-label="Previous" title="이전" onclick="return false;" class="dev-page" data-page="${knowledgeList.pageNavigation.numberStart-1 }">
		                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            </c:if>
		                            
		                            <c:forEach var="i" begin="${knowledgeList.pageNavigation.numberStart }" end="${knowledgeList.pageNavigation.numberEnd }" step="1">
		                            <li <c:if test="${i == knowledgeList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" class="dev-page" data-page="${i}">${i}</a></li>
		                            </c:forEach>
		
		                            <c:if test="${knowledgeList.pageNavigation.canNextSection == true}">
		                            <li>
		                                <a href="javascript:;" aria-label="Next" title="다음" class="dev-page" data-page="${knowledgeList.pageNavigation.numberEnd+1 }">
		                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            <li>
		                                <a href="javascript:;" aria-label="Next" title="마지막" class="dev-page" data-page="${knowledgeList.pageNavigation.maxNumber }">
		                                    <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            </c:if>
		                        </c:if>
		                        </ul>
		                    </nav>
                    		<!-- //페이지 네비 -->
                    		<form name="insertData">
	                    		<input type="hidden" name="knowlgMapType" value="${knowlgMapType}" />
	                    		<input type="hidden" name="upNo" value="${knowlgMap.upNo}"/>
	                    		<input type="hidden" name="knowlgMapNo" value="${knowlgMap.knowlgMapNo}"/>
	                    		<div class="btn_area text-right">
	                            	<!-- <a href="/kno/insertKnowledgeView.do?knowlgMapType=REPORT&upNo=1&knowlgMapNo=19" class="btn btn-blue"><i class="ti-pencil-alt"></i> 등록하기</a> -->
	                            	<a href="javascript:postData('${knowlgMapType}', '${knowlgMap.upNo}', '${knowlgMap.knowlgMapNo}');" class="btn btn-blue"><i class="ti-pencil-alt"></i> 등록하기</a>
	                        	</div>
                        	</form>
                    </div>
                    <!-- //page-body -->
                </div>
                <!-- CONTENTS -->
            </div>
            <!-- //row -->
        </div>
<script>
    $(function () {
		let errMsg = '${errMsg}';
		if (errMsg != '') {
			alert(errMsg);
		}
    			
    	var searchDate = "${searchDate}";
    	if(searchDate == 'SELECT'){
    		$('#schDate4').trigger('change');
    	}
    	
    	var searchWriter = "${searchWriter}";
    	if(searchWriter =='SELECT'){
    		$('#selWriter3').trigger('change');
    	}
 		
    	<c:forEach var="user" items="${userList }">
   			$.ajax({
    			url : '/usr/userList.do',
    			data : {
    				sid : "${user}"
    			},
    			dataType: "json",
    			success : function(data) {
    				$('#userList').prepend('<li>---------------------------------------------------------------------------</li>');
    				if(data.userList.length > 0){
                  		//$('#userList li').remove(); 
                      	for(var i=0; i < data.userList.length; i++){
                      		$('#userList').prepend('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" data-ou="'+data.userList[i].ou+'" checked>'+data.userList[i].ou+' '+data.userList[i].displayName+'</label></li>');
                      	}	
    				}
    			},
    			error : function(){
    				alert("에러가 발생하였습니다.");
    			}
    		});
	    </c:forEach>

    	var searchInfo = "${searchInfo}";
    	document.getElementById('wikiSrchStr').value = searchInfo;
    	
        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
            var page = $(this).data('page');
            var form = $("form[name=knowledgeFrm]");
            form.find("input[name=page]").val(page);
            
            form.submit();
        });
        
        $('.dev-detail').on('click', function (e) {
        	e.preventDefault();
            var knowlgNo = $(this).data('knowlgno');
            var title = $(this).data('title');            
            var form = $("form[name=knowledgeFrm]");
            form.find("input[name=knowlgNo]").val(knowlgNo);
            form.find("input[name=title]").val(title);
            form.attr("action", "/kno/knowledgeDetail.do");
            form.submit();
        });
        
     	$('.dev-type').on('click', function(e) {
        	e.preventDefault();
     		var type = $(this).data('type');
            var form = $("form[name=knowledgeFrm]");
            form.find("input[name=knowlgMapType]").val(type);
            form.find("input[name=knowlgMapNo]").val(0);
            form.attr("action", "/kno/knowledgeList.do");
            form.submit();
     	});
        
     	$('.lnk').on('click', function(e) {
        	e.preventDefault();
     		var no = $(this).data('no');
            var form = $("form[name=knowledgeFrm]");
            form.find("input[name=knowlgMapNo]").val(no);
            form.find("input[name=page]").val(1);
            document.getElementById('wikiSrchStr').value = '';
            form.submit();
     	});
     	
        $("#interestBtn").click(function(e) {
        	var knowlgMapNo = '${knowlgMap.knowlgMapNo }';
        	if(knowlgMapNo != 0){
                $.ajax({
                    url: "/kno/updateInterests.do",
                    data: {
                    	knowlgMapNo : knowlgMapNo
                    },
                    dataType: 'json',
                    type: "POST",
                    global: false,
                    success: function (data) {
                    	if(data.isInterest) {
                    		$("#interestBtn").addClass("on");
                    	} else {
                    		$("#interestBtn").removeClass("on");
                    	}
                    },
                    error: function (error) {
                        alert("추천 중 에러가 발생하였습니다.");
                    }
                });
        	} else{
        		alert("지식맵을 선택해주세요.");
        	}
        });
        
		$("#orgBtn").click(function(e){
			var ou = $("input[name=orgText]").val();
			
			if(ou == ''){
				alert("부서를 입력해주세요.");
				return false;
			}
			
     		$.ajax({
     			url : '/org/orgList.do',
     			data : {
     				ou : ou 
     			},
     			dataType: "json",
     			success : function(data) {
               		$('#orgList').prepend('<li>---------------------------------------------------------------------------------</li>');
                   	if(data.orgList.length > 0){
                   		//$('#orgList li').remove();
                   		for(var i=0; i < data.orgList.length; i++){
                       		$('#orgList').prepend('<li><label for="chk-'+i+'"><input id="chk-'+i+'" name="orgList" data-id="customChk-'+i+'" type="checkbox" value="'+data.orgList[i].ouCode+'" data-name="'+data.orgList[i].ou+'">'+data.orgList[i].ou+'</label></li>');
                       	}
                   	} else{
                   		$('#orgList').prepend('<li>검색 결과가 없습니다.</li>');
                   	}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});
		
		$("#userBtn").click(function(e){
			var displayName = $("input[name=userText]").val();
			
			if(displayName == ''){
				alert("이름을 입력해주세요.");
				return false;
			}
			
     		$.ajax({
     			url : '/usr/userList.do',
     			data : {
     				displayName : displayName
     			},
     			dataType: "json",
     			success : function(data) {
     				$('#userList').prepend('<li>---------------------------------------------------------------------------</li>');
     				if(data.userList.length > 0){
                   		//$('#userList li').remove(); 
                       	for(var i=0; i < data.userList.length; i++){
                       		$('#userList').prepend('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" data-ou="'+data.userList[i].ou+'">'+data.userList[i].ou+' '+data.userList[i].displayName+'</label></li>');
                       	}	
     				} else{
                   		$('#userList').prepend('<li>검색 결과가 없습니다.</li>');
                   	}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});
		
		var orgLi = [];
		$("#rlsChk").click(function(e){
			$('input:checkbox[name="orgList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#orgName').text();
					var data = $(this).data('name');
					
					//console.log("orgLi.indexOf(data) - " + orgLi.indexOf(data));
					if(orgLi.indexOf(data) < 0) {
						orgLi.push(data);
					}
					
					//console.log("orgLi - " + orgLi);
					//console.log("orgLi - " + orgLi);
					//console.log("list.indexOf(data) - " + list.indexOf(data));
					//console.log("data - " + data);

					if(list.indexOf(data) < 0) {
						$('#rlsList').append('<span id="orgName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
					}
				}
			});
			
			$('input:checkbox[name="userList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#usersName').text();
					var data = $(this).data('name');
					
					//console.log("orgLi.indexOf(data) - " + orgLi.indexOf(data));
					if(orgLi.indexOf(data) < 0) {
						orgLi.push(data);
					}
					
					//console.log("orgLi - " + orgLi);
					//console.log("orgLi - " + orgLi);
					//console.log("list.indexOf(data) - " + list.indexOf(data));
					//console.log("data - " + data);

					if(list.indexOf(data) < 0) {
						$('#rlsList').append('<span id="usersName" class="tag_btn label label-default">'+$(this).data('ou')+' '+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
					}
				}
			});
			
			$( 'input[name="allChk1"]' ).attr( 'checked', false );
			//$( 'input[name="orgList"]' ).attr( 'checked', false );
			$( 'input[name="allSrchChk"]' ).attr( 'checked', false );
			//$( 'input[name="userList"]' ).attr( 'checked', false );
		});
		
		$("#userList .fa").click(function(e){
			var tmp = $(this);
			var ouCode = $(this).data('code');
     		$.ajax({
     			url : '/usr/userList.do',
     			data : {
     				ouCode : ouCode
     			},
     			dataType: "json",
     			success : function(data) {
     				for(var i=data.userList.length-1; i >= 0; i--){
     					tmp.next().next().prepend('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" data-ou="'+data.userList[i].ou+'">'+data.userList[i].ou+' '+data.userList[i].displayName+'</label></li>');
     				}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});			
    });
		
    function postData(knowlgMapType, upNo, knowlgMapNo){
    	var f=document.insertData;  //폼 name
    	if(upNo == '') {
    		upNo = 0;
    	}
    	if(knowlgMapNo == '') {
    		knowlgMapNo = 0;
    	}
    	
    	f.knowlgMapType.value = knowlgMapType;  //POST방식으로 넘기고 싶은 값
    	f.upNo.value = upNo;  //POST방식으로 넘기고 싶은 값
    	f.knowlgMapNo.value = knowlgMapNo;  //POST방식으로 넘기고 싶은 값
    	f.action="/kno/insertKnowledgeView.do";  //이동할 페이지
    	f.method="post";  //POST방식
    	f.submit();
    }
</script>