<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
			<div class="page-header">
				<h2>지식백과</h2>
        		<div>${menuDesc }</div>
            </div>
            <!-- //page-header -->
			<div class="row layout_side_row">
                <div id="aside" class="col-md-3">
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
				<form:form id="updFrm" class="form-horizontal" action="/kno/insertUpdateKnowledge.do" modelAttribute="knowledgeVO" enctype="multipart/form-data">
                <div id="contents" class="col-md-9">
                    <div class="page-body">
                        <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
                        <!-- 글작성 -->
                        	<input type="hidden" name="realNmYn" value="Y">
                        	<input type="hidden" name="cmmntyNo" value="${empty cmmntyNo?0:cmmntyNo}">
                        	<input type="hidden" name="aprvYn" value="Y"> <!-- 승인여부 -->
                            <fieldset>
                                <legend class="sr-only">게시판 글작성</legend>
                                <div class="brd_write_area wiki_frms">
                                    <div class="form-group">
                                        <label for="inpCate" class="col-sm-2 control-label"><span class="req">*</span> 유형</label>
                                        <div class="col-sm-3">
                                            <form:select id="typeSel" path="knowlgMapType" class="form-control">
                                                <option value="${knowlgMapType }" selected="selected">
                                                <c:choose>
                                                <c:when test="${knowlgMapType eq 'REPORT' }">행정자료</c:when>
                                                <c:when test="${knowlgMapType eq 'REFERENCE' }">업무참고자료</c:when>
                                                <c:otherwise>개인별지식</c:otherwise>
                                                </c:choose>
                                                </option>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <strong class="col-sm-2 control-label"><span class="req">*</span> 지식맵</strong>
                                        <div class="col-sm-10 col-md-10 col-lg-7">
                                            <div class="row type1">
                                                <div class="col-xs-6">
                                                    <label for="mainSel" class="sr-only">대주제 선택</label>
                                                    <form:select id="mainSel" path="knowlgMapMainNo" class="form-control">
                                                        <option value="${knowledgeDetail.upNo }" selected="selected">${knowledgeDetail.upNm }</option>
                                                    </form:select>
                                                </div>
                                                <div class="col-xs-6">
                                                    <label for="subSel" class="sr-only">소주제 선택</label>
                                                    <form:select id="subSel" path="knowlgMapNo" class="form-control">
                                                        <option value="${knowledgeDetail.knowlgMapNo }" selected="selected">${knowledgeDetail.knowlgMapNm }</option>
                                                    </form:select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-lg-push-0 col-md-10 col-md-push-2">
                                            <div class="checkbox-inline">
                                                <label for="chkOpt"><input type="checkbox" name="copertnWritngYn" id="chkOpt" value="Y" <c:if test="${knowlgMapType eq 'REPORT' || knowlgMapType eq 'REFERENCE'}">disabled="disabled"</c:if> />공동편집가능</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inpSubject" class="col-sm-2 control-label"><span class="req">*</span> 제목</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="inpSubject" name="title" value="${knowledgeDetail.title }" readonly="readonly" required="required" />
                                            <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 편집/수정 시 제목은 변경 불가합니다. 신중히 기재해 주시기 바랍니다.</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inpText" class="col-sm-2 control-label"><span class="req">*</span> 내용</label>
                                        <div class="col-sm-10">
                                            <div class="opt_btns">
                                                <button type="button" class="btn btn-default outline ico_btn file_add" data-toggle="collapse" data-target="#converterFrm" aria-expanded="false" aria-controls="converterFrm" title="파일변환"><i class="glyphicon glyphicon-paperclip" aria-hidden="true"></i><span class="sr-only">파일변환</span></button><span> 파일변환</span>
                                                <button type="button" class="btn btn-default outline ico_btn file_add" id="lnkAddPop" data-toggle="modal" data-target="#lnkRegPopup" title="지식연결"><i class="glyphicon glyphicon-link" aria-hidden="true"></i> <span class="sr-only">지식연결</span></button><span> 지식연결</span>
                                            </div>
                                            <div id="converterFrm" class="converter_area collapse">
                                                <div class="row type1 mb_5">
                                                    <div class="col-xs-9 col-sm-10">
                                                        <label for="convFile" class="sr-only">파일변환</label>
                                                        <input type="file" id="convFile" name="convFile" class="form-control" />
                                                    </div>
                                                    <div class="col-xs-3 col-sm-2">
                                                        <button type="button" id="convert" class="btn btn-black btn-block">변환</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <textarea class="form-control" id="inpText" name="cont" placeholder="내용을 입력하세요" required >
                                            <c:forEach var="contents" items="${knowledgeContentsList }">
                                            <p>[==${contents.subtitle }==]</p>
                                            ${contents.cont} 
                                            </c:forEach>
                                            </textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inpMemo" class="col-sm-2 control-label"><span class="req">*</span> 지식요약</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" rows="3" id="inpMemo" name="summry" placeholder="요약내용을 입력하세요" required>${knowledgeDetail.summry }</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <strong class="col-sm-2 control-label">관련지식</strong>
                                        <div class="col-sm-10">
                                            <button type="button" class="btn btn-xs btn-black outline" data-toggle="modal" data-target="#relatedSelPopup">관련지식 검색</button>
                                            <div id="rltList" class="tag_grp_area">
                                            	<c:if test="${not empty knowledgeDetail.relateKnowlgNo }">
		                                       		<c:forEach var="relateList" items="${relateKnowledgeList}">
			                                       		<span class="tag_btn label label-default">${relateList}<input type="hidden" name="relateKnowledgeList" value="${relateList}"><i class="remove">x</i><span class="sr-only">삭제</span></span>
		                                       		</c:forEach>
		                                        </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="atchFile" class="col-sm-2 control-label">첨부파일</label>
                                        <c:if test="${not empty knowledgeDetail.atchFileNo }">
                                        <div class="col-sm-8">
										<input type="hidden" name="atchFileNo" value="${knowledgeDetail.atchFileNo}">                                       
                                       		<c:forEach var="file" items="${fileList }"> 
	                                       		<a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger">${file.orignlFileNm }</a>
	                                       		<a href="/cmm/fms/deleteFileInfs.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }"><i class="remove">x</i></a><span class="sr-only">삭제</span>                           	
                                       		</c:forEach>
                                       	</div>
                                        </c:if>
                                        <div class="col-sm-8">
                                            <span class="file-input btn-file btn btn-xs btn-black outline">
                                               <i class="ti-save" aria-hidden="true"></i> 파일찾기 <input type="file" id="atchFile" name="atchFile" multiple />
                                            </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="keyword" class="col-md-2 control-label"><span class="req">*</span> 검색 키워드</label>
                                        <div class="col-md-10">
                                            <input type="text" id="keyword" name="keyword" data-role="tagsinput" class="form-control inp_keyword" value="${knowledgeDetail.keyword }" required="required" />
                                            <p class="help-block"><i class="fa fa-exclamation-circle text-danger"></i> 최대 10개까지 등록 가능합니다. 입력후 엔터키를 눌러주세요.</p>
                                        </div>
                                    </div>
                                    <div class="form-group inp_set_area">
                                        <label for="svTarget1" class="col-sm-2 control-label"><span class="req">*</span> 공개범위</label>
                                        <div class="col-sm-10 tree_chk_area">
                                            <label for="svTarget1" class="radio-inline">
                                                <form:radiobutton path="rlsYn" id="svTarget1" value="Y" checked="checked" /> 전체
                                            </label>
                                            <label for="svTarget2" class="radio-inline">
                                                <form:radiobutton path="rlsYn" id="svTarget2" value="N" class="inp_tog" /> 지정
                                            </label>
                                            <a href="#selectGrpPopup" class="btn btn-xs btn-primary inp_tog_cont" data-toggle="modal" data-target="#selectGrpPopup">부서/개인/그룹 선택</a>
                                            <div id="rlsList" class="tag_grp_area">
                                            </div>
                                        </div>
                                    </div>
                                    <!--
                                     <div class="form-group">
                                        <strong class="col-md-2 control-label"><span class="req">*</span> 승인자 선택</strong>
                                        <div class="col-md-10">
                                            <a href="#approvalSelPopup" class="btn btn-xs btn-black outline"  data-toggle="modal" data-target="#approvalSelPopup">승인자 검색</a>
                                            <div id="aprvList" class="tag_grp_area">
                                            </div>
                                        </div>
                                    </div>
                                     -->
                                </div>
                                <div class="row type0">
                                    <div class="col-sm-12 text-right">
                                        <button id="submit" type="submit" class="btn btn-blue">작성완료</button>
                                        <a href="/kno/knowledgeDetail.do?title=${knowledgeDetail.title }&knowledgeNo=${knowledgeDetail.knowlgNo}" class="btn btn-black">취소</a>
                                    </div>
                                </div>
                            </fieldset>
                        <!-- //글작성 -->
                    </div>
                    <!-- //page-body -->
                </div>
                <!-- CONTENTS -->

                <!-- 관련지식 선택 팝업 -->
                <div class="modal fade" id="relatedSelPopup" tabindex="-1" role="dialog" aria-labelledby="relatedSelPopupLabel">
                    <div class="modal-dialog" role="document">
                    	<div class="modal-content">
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	                            <h4 class="modal-title" id="relatedSelPopupLabel">관련지식 선택</h4>
	                        </div>
	                        <div class="modal-body">
	                            <div class="srch_area">
	                                <fieldset>
	                                    <legend class="sr-only">키워드 검색</legend>
	                                    <div class="input-group">
	                                        <label for="rltText" class="sr-only">키워드 검색</label>
	                                        <input type="text" id="rltText" name="rltText" class="form-control" placeholder="제목 및 키워드로 검색 후 선택해 주시기 바랍니다.">
	                                        <span class="input-group-btn"><a href="javascript:;" id="rltBtn" class="btn btn-default">검색</a></span>
	                                    </div>
	                                </fieldset>
	                            </div>
	                            <div class="tab-content">
	                                <div class="hummingbird-treeview well chk_tree_area">
	                                    <div class="checkbox">
	                                        <label for="relatedSrchChk"><input type="checkbox" id="relatedSrchChk" class="all_chk" /> 전체선택</label>
	                                    </div>
	                                    <ul id="relateList" class="chk_tree_list hummingbird-base treeview">
	                                    </ul>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" id="rltChk" class="btn btn-blue" data-dismiss="modal">확인</button>
	                        </div>
                    	</div>
                    </div>
                </div>
                <!-- //관련지식 선택 팝업 -->
                
                <!-- 조직그룹 선택 팝업 -->
                <div class="modal fade" id="selectGrpPopup" tabindex="-1" role="dialog" aria-labelledby="selectGrpPopupLabel">
                    <div class="modal-dialog" role="document">
	                    <div class="modal-content">
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	                            <h4 class="modal-title" id="selectGrpPopupLabel">부서/개인/그룹 선택</h4>
	                        </div>
	                        <div class="modal-body">
	                            <ul class="nav nav-tabs" role="tablist">
	                                <li role="presentation" class="active"><a href="#selectGrpTab1" aria-controls="selectGrpTab1" role="tab" data-toggle="tab">부서</a></li>
	                                <li role="presentation"><a href="#selectGrpTab2" aria-controls="selectGrpTab2" role="tab" data-toggle="tab">개인</a></li>
	                                <li role="presentation"><a href="#selectGrpTab3" aria-controls="selectGrpTab3" role="tab" data-toggle="tab">그룹</a></li>
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
	                                        <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
	                                        <ul id="orgList" class="chk_tree_list hummingbird-base treeview">
	                                        	<c:forEach var="top" items="${topList }" varStatus="topStatus">
                                                <li>
                                                	<i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }" value="${top.ouCode }" data-id="customChk-${topStatus.index+1 }" data-name="${top.ou }" />${top.ou }</label>
                                                    <ul>
                                                    	<c:forEach var="parent" items="${parentList }" varStatus="parentStatus">
                                                    	<c:if test="${parent.parentOuCode eq top.ouCode }">
                                                        <li>
                                                            <i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }-${parentStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }-${parentStatus.index+1 }" value="${parent.ouCode }"data-id="customChk-${topStatus.index+1 }-${parentStatus.index+1 }" data-name="${parent.ou }" />${parent.ou }</label>
                                                            <ul class="not_depth_list">
                                                            	<c:forEach var="child" items="${childList }" varStatus="childStatus">
                                                            	<c:if test="${child.parentOuCode eq parent.ouCode }">
                                                                <li>
                                                                	<i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" value="${child.ouCode }" data-id="customChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" data-name="${child.ou }" />${child.ou }</label>
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
	                                <div id="selectGrpTab3" class="tab-pane" role="tabpanel">
	                                <c:choose>
	                                	<c:when test="${not empty groupList }">
	                                    <div class="hummingbird-treeview well chk_tree_area">
	                                        <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
	                                        <div class="checkbox">
	                                            <label for="allSrchGrp"><input type="checkbox" id="allSrchGrp" class="all_chk" /> 전체선택</label>
	                                        </div>
	                                        <ul id="grpList" class="chk_tree_list hummingbird-base treeview">
	                                        	<c:forEach var="group" items="${groupList }" varStatus="status">
	                                        	<li><label for="allSrchGrp-${status.index }"><input id="allSrchGrp-${status.index }" name="groupList" data-id="allSrchGrp-${status.index }" type="checkbox" value="${group.groupNo }" data-name="${group.groupNm }">${group.groupNm }</label></li>
	                                        	</c:forEach>
	                                        </ul>
	                                    </div>
	                                    </c:when>
										<c:otherwise>
	                                    <!-- 검색결과 없음 -->
	                                    <div class="well text-center mb_0">
	                                        <p>등록된 그룹이 없습니다</p>
	                                    </div>
	                                    <!-- //검색결과 없음 -->
	                                    </c:otherwise>
	                                </c:choose>
	                                    <p class="mt_5 fs_95"><span class="text-danger">※</span> 그룹 편집은  <a href="/myp/mypage.do" class="text-danger underline">마이 페이지</a>에서 가능합니다</p>
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
                
                <!-- 승인자 선택 팝업 -->
                <div class="modal fade" id="approvalSelPopup" tabindex="-1" role="dialog" aria-labelledby="approvalSelPopupLabel">
                    <div class="modal-dialog" role="document">
	                    <div class="modal-content">
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	                            <h4 class="modal-title" id="approvalSelPopupLabel">승인자 선택</h4>
	                        </div>
	                        <div class="modal-body">
	                            <div class="srch_area">
	                                <fieldset>
	                                    <legend class="sr-only">키워드 검색</legend>
	                                    <div class="input-group">
	                                        <label for="aprvText" class="sr-only">키워드 검색</label>
	                                        <input type="text" id="aprvText" name="aprvText" class="form-control" placeholder="이름 검색(2글자 이상)">
	                                        <span class="input-group-btn"><a href="javascript:;" id="aprvBtn" class="btn btn-default">검색</a></span>
	                                    </div>
	                                </fieldset>
	                            </div>
	                            <div class="tab-content">
	                                <div class="well chk_tree_area">
	                                    <ul id="approvalList" class="radio_list">
	                                    </ul>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" id="aprvChk" class="btn btn-blue" data-dismiss="modal">확인</button>
	                        </div>
	                    </div>
	                </div>
                </div>
                <!-- //승인자 선택 팝업 -->
				</form:form>

                <!-- 링크등록 팝업 -->
                <div class="modal fade" id="lnkRegPopup" tabindex="-1" role="dialog" aria-labelledby="lnkRegPopupLabel">
                    <div class="modal-dialog" role="document">
                    	<div class="modal-content">
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	                            <h4 class="modal-title" id="lnkRegPopupLabel">링크 등록</h4>
	                        </div>
	                        <div class="modal-body">
	                            <ul class="nav nav-tabs" role="tablist">
	                                <li role="presentation" class="active"><a href="#lnkRegTab1" aria-controls="lnkRegTab1" role="tab" data-toggle="tab">내부 문서</a></li>
	                                <li role="presentation"><a href="#lnkRegTab2" aria-controls="lnkRegTab2" role="tab" data-toggle="tab">URL 직접등록</a></li>
	                            </ul>
	                            <div class="tab-content">
	                                <div id="lnkRegTab1" class="tab-pane active" role="tabpanel">
	                                    <div class="srch_area">
	                                        <fieldset>
	                                            <legend class="sr-only">이름 검색영역</legend>
	                                            <div class="input-group">
	                                                <label for="lnkText" class="sr-only">이름 입력</label>
	                                                <input type="text" id="lnkText" name="lnkText" class="form-control" placeholder="키워드 검색">
	                                                <span class="input-group-btn"><a href="javascript:;" id="lnkSrchBtn" class="btn btn-default">검색</a></span>
	                                            </div>
	                                        </fieldset>
	                                    </div>
	                                    <div class="well chk_tree_area">
	                                        <ul id="lnkList" class="radio_list">
	                                        </ul>
	                                    </div>
	                                    <!-- 검색결과 없음 -->
	                                    <div class="well text-center mb_0">
	                                        <p>검색 결과가 없습니다</p>
	                                    </div>
	                                    <!-- //검색결과 없음 -->
	                                </div>
	                                <div id="lnkRegTab2" class="tab-pane" role="tabpanel">
	                                    <div class="form-group">
	                                        <label for="lnkRegUrl" class="sr-only">URL</label>
	                                        <input type="url" id="lnkRegUrl" name="lnkUrl" class="form-control" placeholder="URL을 입력해주세요." />
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" id="lnkAddBtn" class="btn btn-blue" data-dismiss="modal">확인</button>
	                            <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
	                        </div>
	                    </div>
                    </div>
                </div>
                <!-- //링크등록 선택 팝업 -->
            </div>
            <!-- //row -->
        </div>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script type="text/javascript">
	CKEDITOR.replace('inpText');
	
	$(function() {
		
		$("#convert").click(function(e){
			var formData = new FormData();
			formData.append('file',$('#convFile')[0].files[0]);
			
			CKEDITOR.instances.inpText.setData("");
        	$.ajax({
        		url : '/kno/fileConvert.do',
        		type : 'POST',
        		data : formData,
        		contentType : false,
        		processData : false,
        		dataType : 'json',
               	success : function(data) {
        			CKEDITOR.instances.inpText.insertHtml(data.text);
        		},
        		error : function(request, status, error){
        			alert("에러가 발생하였습니다.");
        		}
        	});
		});
		
		$("#rltBtn").click(function(e){
			var searchText = $("input[name=rltText]").val();
     		$.ajax({
     			url : '/kno/relateKnowledgeList.do',
     			data : {
     				searchType : 'TITLE',
     				searchText : searchText 
     			},
     			dataType: "json",
     			success : function(data) {
                   	if(data.knowledgeList.length > 0){
                   		$('#relateList il').remove();
                       	for(var i=0; i < data.knowledgeList.length; i++){
                       		$('#relateList').append('<li><label for="relatedSrchChk-'+i+'"><input type="checkbox" name="relateKnowledgeList" id="relatedSrchChk-'+i+'" data-id="relatedSrchChk-'+i+'" value="'+data.knowledgeList[i].title+'"></label>'+data.knowledgeList[i].title+'</li>');
                       	}
                   	} else{
                   		$('#relateList').append('<li>검색 결과가 없습니다.</li>');
                   	}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});

		$("#rltChk").click(function(e){
			$('input:checkbox[name="relateKnowledgeList"]').each(function(e){
				if(this.checked){
					$('#rltList').append('<span class="tag_btn label label-default">'+this.value+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');		
				}
			});
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
			
			$('input:checkbox[name="groupList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#groupName').text();
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
						$('#rlsList').append('<span id="groupName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
					}
				}
			});
			
			$( 'input[name="allChk1"]' ).attr( 'checked', false );
			//$( 'input[name="orgList"]' ).attr( 'checked', false );
			$( 'input[name="allSrchChk"]' ).attr( 'checked', false );
			//$( 'input[name="userList"]' ).attr( 'checked', false );
			$( 'input[name="allSrchGrp"]' ).attr( 'checked', false );
			//$( 'input[name="groupList"]' ).attr( 'checked', false );
		});
		
		$("#aprvBtn").click(function(e){
			var displayName = $("input[name=aprvText]").val();
			
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
     				if(data.userList.length > 0){
                   		$('#approvalList li').remove(); 
                       	for(var i=0; i < data.userList.length; i++){
                       		$('#approvalList').append('<li><div class="radio"><label for="approvalSrchChk'+i+'"><input type="radio" id="approvalSrchChk'+i+'" name="approverId" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" data-ou="'+data.userList[i].ou+'"/>'+data.userList[i].ou+' '+data.userList[i].displayName+'</label></div></li>');
                       	}
     				} else{
                   		$('#approvalList').append('<li>검색 결과가 없습니다.</li>');
                   	}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});
		
		$("#aprvChk").click(function(e){
			$('input:radio[name="approverId"]').each(function(e){
				if(this.checked){
					if($('#aprvList').children('#ouName').text() != '') {
						alert('승인자가 선택되어 있습니다.');
						return false;
					}

					var sid = $(this).val();
					var ou = $(this).data('ou');
					var name = $(this).data('name');
			 		$.ajax({
			 			url : '/usr/selectUserRoleCheck.do',
			 			data : {
			 				sid : sid,
			 				approverYn : 'Y'
			 			},
			 			dataType: "json",
			 			success : function(data) {
			 				if(data > 0){
								$('#aprvList').append('<span id="ouName" class="tag_btn label label-default">'+ ou +' '+ name +'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
								//$('#approvalList li').remove();
								$('#aprvText').val('');
			 				} else{
			 					alert("승인권한이 없는 사용자 입니다.");
			 				}			 					
			 			},
			 			error : function(){
			 				alert("에러가 발생하였습니다.");
			 			}
			 		});
				}
			});
		});
		
		$("#lnkSrchBtn").click(function(e){
			var lnkText = $("input[name=lnkText]").val();
     		$.ajax({
     			url : '/kno/relateKnowledgeList.do',
     			data : {
     				searchType : 'TITLE',
     				searchText : lnkText 
     			},
     			dataType: "json",
     			success : function(data) {
     				if(data.knowledgeList.length > 0){
                   		$('#lnkList li').remove();
                       	for(var i=0; i < data.knowledgeList.length; i++){
                       		$('#lnkList').append('<li><div class="radio"><label for="srchLnkSrchChk'+i+'"><input type="radio" id="srchLnkSrchChk'+i+'" name="lnkSrch" value="'+data.knowledgeList[i].title+'"/>'+data.knowledgeList[i].title+'</label></div></li>'); 
                       	}	
     				} else{
     					$('#lnkList').append('<li>검색 결과가 없습니다.</li>');
     				}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});
		
		$("#lnkAddBtn").click(function(e){
			e.preventDefault();
			var selection = CKEDITOR.instances.inpText.getSelection();
			var text = CKEDITOR.instances.inpText.getSelection().getSelectedText();
			
			if(text == ''){
				alert("텍스트를 선택해주세요");
				return false;
			}
			
		    var lnkSrch = $(":input:radio[name=lnkSrch]:checked").val();

			if(lnkSrch != undefined){
				var url = '/kno/knowledgeDetail.do?title='+lnkSrch;
			} else{
				var url = $("input[name=lnkUrl]").val();
			}
			
			if(url == ''){
				alert("지식을 선택하시거나 URL을 입력해주세요");
				return false;
			}
			
			CKEDITOR.instances.inpText.insertHtml('<a href="'+encodeURI(url)+'">'+text+'</a>');
		});
		
		$("#lnkAddPop").click(function(e){
			e.preventDefault();
			var selection = CKEDITOR.instances.inpText.getSelection();
			var text = CKEDITOR.instances.inpText.getSelection().getSelectedText();
			
			if(text == ''){
				alert("텍스트를 선택해주세요");
				return false;
			}
			
     		$.ajax({
     			url : '/kno/relateKnowledgeList.do',
     			data : {
     				searchType : 'TITLE',
     				searchText : text 
     			},
     			dataType: "json",
     			success : function(data) {
     				if(data.knowledgeList.length > 0){
                   		$('#lnkList li').remove(); 
                       	for(var i=0; i < data.knowledgeList.length; i++){
                       		$('#lnkList').append('<li><div class="radio"><label for="srchLnkSrchChk'+i+'"><input type="radio" id="srchLnkSrchChk'+i+'" name="lnkSrch" value="'+data.knowledgeList[i].title+'"/>'+data.knowledgeList[i].title+'</label></div></li>'); 
                       	}
     				} else{
     					$('#lnkList').append('<li>검색 결과가 없습니다.</li>');
     				}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});
		
		$("#submit").click(function() {
            if($('#subSel').val() == 0){
            	alert("지식맵을 선택해주세요.");
            	return false;
            }
            var cont = CKEDITOR.instances.inpText.getData();
            if(cont == ''){
            	alert("내용을 입력해주세요.");
            	return false;
            }
            if($('#keyword').val() == ''){
            	alert("키워드를 입력해주세요.");
            	return false;
            }
            
            /*
            var type = $('#typeSel').val();
            if((type == 'REPORT' || type == 'REFERENCE') && $('input[name=approverId]').val() == undefined){
            	alert("승인자를 선택해주세요.");
            	return false;
            }
            */
            
			var files=$('input[name="atchFile"]')[0].files;
 			
            for(var i= 0; i<files.length; i++){
            	var filename = files[i].name;
            	
            	var ext = filename.substring(filename.lastIndexOf('.')+1);
            	
            	if($.inArray(ext.toUpperCase(), ['DOCX', 'HWP', 'PDF', 'XLS', 
							            		'AI', 'ZIP', 'EGG', 'XLSX', 
							            		'PPTX', 'PPT', 'TXT', 'GIF', 
							            		'JPG', 'JPEG', 'MP4', 'MP3', 'WMV',
							            		'MPEG', 'MPG', 'AVI', 'PNG', 'PSD', 'BMP', 
							            		'DOC', 'XLSM', 'OTF', 'EXE']) == -1) {
            		alert('업로드가 불가능한 확장자 파일이 포함되어 있습니다.\n\n업로드 가능한 확장자\n[gif, png, jpg, jpeg, doc, docx, xls, xlsx, hwp, pdf, ai, zip, egg, pptx, ppt, txt, mp4, wmv, avi, psd, bmp, xlsm, otf, exe]');
            		return false;
            	}
            }
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
		
		var cmmntyNo = '${cmmntyNo}'
		if(cmmntyNo != ''){
			$("#typeSel option[value!=PERSONAL]").remove();
			$("#typeSel").change();
		}
		
		$('input[type="text"]').keydown(function() {
			if (event.keyCode === 13) {
				event.preventDefault();
			};
		});
		
	});
</script>