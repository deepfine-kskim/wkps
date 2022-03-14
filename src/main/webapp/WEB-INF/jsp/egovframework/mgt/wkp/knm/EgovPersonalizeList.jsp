<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">맞춤 지식 관리</h2>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="msg"><strong class="text-primary">${loginVO.displayName }</strong>님! 반갑습니다.</p>
                        <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
                    </div>
                </div>
            </div>
            <!-- //cont_header -->
            <div class="cont_body">
            	<ol class="breadcrumb">
                    <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
                    <li>지식 관리</li>
                    <li class="active">맞춤 지식 관리</li>
                </ol>
                <div id="contents">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#bbsTab1" aria-controls="bbsTab1" role="tab" data-toggle="tab">행정자료</a></li>
                        <li role="presentation"><a href="#bbsTab2" aria-controls="bbsTab2" role="tab" data-toggle="tab">업무참고자료</a></li>
                        <li role="presentation"><a href="#bbsTab3" aria-controls="bbsTab3" role="tab" data-toggle="tab">개인별지식</a></li>
                    </ul>
                    <div class="tab-content">
                    	<div class="dropdown d-inline-block">
                    		<button type="button" class="btn dropdown-toggle outline" id="schSortOpt" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                    			<span class="selection">부서</span> <span class="caret"></span>
                    		</button>
                    		<ul class="dropdown-menu" aria-labelledby="schSortOpt">
                    			<c:forEach var="org" items="${orgList }">
                    				<li<c:if test="${org.ouCode eq ouCode }"> class="active"</c:if>><a href="/adm/personalizeList.do?ouCode=${org.ouCode }">${org.ou}</a></li>
                    			</c:forEach>
                    		</ul>
                    	</div>
                    	<div role="tabpanel" class="tab-pane active" id="bbsTab1">
		                    <table class="table text-center table-bordered table-hover brd_list">
		                        <caption class="sr-only">게시판 목록</caption>
		                        <colgroup>
		                            <col style="width:100px;">
		                            <col style="width:120px;">
		                            <col>
		                            <col>
		                            <col>
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                        </colgroup>
		                        <thead>
		                        <tr>
		                            <th scope="col">번호</th>
		                            <th scope="col">유형</th>
		                            <th scope="col">부서</th>
		                            <th scope="col">제목</th>
		                            <th scope="col">작성자</th>
		                            <th scope="col">추천수</th>
		                            <th scope="col">조회수</th>
		                            <th scope="col">등록일</th>
		                            <th scope="col">삭제</th>
		                        </tr>
		                        </thead>
		                        <tbody>
		                        	<c:forEach var="personalize" items="${personalizeList }">
		                        	<c:if test="${personalize.knowlgMapType eq 'REPORT'}">
			                        <tr>
			                            <td>${personalize.rki }</td>
			                            <td><span class="text-warning">${personalize.knowlgMapType }</span></td>
			                            <td>${personalize.ou }</td>
			                            <td class="text-left">
			                                <p class="subject">
			                                    <a href="#">${personalize.title }</a>
			                                </p>
			                            </td>
			                            <td>${personalize.registerId }</td>
			                            <td><span class="text-blue">${personalize.recomendCnt }</span></td>
			                            <td><span class="text-black">${personalize.inqCnt }</span></td>
			                            <td>${personalize.registDtm }</td> 
			                            <td><a href="/adm/deletePersonalize.do?rki=${personalize.rki }&knowlgMapType=${personalize.knowlgMapType }&ouCode=${personalize.ouCode }" class="btn btn-default" onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
			                        </tr>
			                        </c:if>
			                        </c:forEach>
		                        </tbody>
		                    </table>
		                    <div class="btn_area text-right">
								<a href="#newRegPopup" class="btn btn-blue min-lg btn-lg" data-toggle="modal" data-target="#newRegPopup">등록</a>
							</div>
						</div>
                    	<div role="tabpanel" class="tab-pane" id="bbsTab2">
		                    <table class="table text-center table-bordered table-hover brd_list">
		                        <caption class="sr-only">게시판 목록</caption>
		                        <colgroup>
		                            <col style="width:100px;">
		                            <col style="width:120px;">
		                            <col>
		                            <col>
		                            <col>
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                        </colgroup>
		                        <thead>
		                        <tr>
		                            <th scope="col">번호</th>
		                            <th scope="col">유형</th>
		                            <th scope="col">부서</th>
		                            <th scope="col">제목</th>
		                            <th scope="col">작성자</th>
		                            <th scope="col">추천수</th>
		                            <th scope="col">조회수</th>
		                            <th scope="col">등록일</th>
		                            <th scope="col">삭제</th>
		                        </tr>
		                        </thead>
		                        <tbody>
		                        	<c:forEach var="personalize" items="${personalizeList }">
		                        	<c:if test="${personalize.knowlgMapType eq 'REFERENCE'}">
			                        <tr>
			                            <td>${personalize.rki }</td>
			                            <td><span class="text-warning">${personalize.knowlgMapType }</span></td>
			                            <td>${personalize.ou }</td>
			                            <td class="text-left">
			                                <p class="subject">
			                                    <a href="#">${personalize.title }</a>
			                                </p>
			                            </td>
			                            <td>${personalize.registerId }</td>
			                            <td><span class="text-blue">${personalize.recomendCnt }</span></td>
			                            <td><span class="text-black">${personalize.inqCnt }</span></td>
			                            <td>${personalize.registDtm }</td> 
			                            <td><a href="/adm/deletePersonalize.do?rki=${personalize.rki }&knowlgMapType=${personalize.knowlgMapType }&ouCode=${personalize.ouCode }" class="btn btn-default" onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
			                        </tr>
			                        </c:if>
			                        </c:forEach>
		                        </tbody>
		                    </table>
		                    <div class="btn_area text-right">
								<a href="#newRegPopup" class="btn btn-blue min-lg btn-lg" data-toggle="modal" data-target="#newRegPopup">등록</a>
							</div>
						</div>
                    	<div role="tabpanel" class="tab-pane" id="bbsTab3">
		                    <table class="table text-center table-bordered table-hover brd_list">
		                        <caption class="sr-only">게시판 목록</caption>
		                        <colgroup>
		                            <col style="width:100px;">
		                            <col style="width:120px;">
		                            <col>
		                            <col>
		                            <col>
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                            <col style="width:10%;">
		                        </colgroup>
		                        <thead>
		                        <tr>
		                            <th scope="col">번호</th>
		                            <th scope="col">유형</th>
		                            <th scope="col">부서</th>
		                            <th scope="col">제목</th>
		                            <th scope="col">작성자</th>
		                            <th scope="col">추천수</th>
		                            <th scope="col">조회수</th>
		                            <th scope="col">등록일</th>
		                            <th scope="col">삭제</th>
		                        </tr>
		                        </thead>
		                        <tbody>
		                        	<c:forEach var="personalize" items="${personalizeList }">
		                        	<c:if test="${personalize.knowlgMapType eq 'PERSONAL'}">
			                        <tr>
			                            <td>${personalize.rki }</td>
			                            <td><span class="text-warning">${personalize.knowlgMapType }</span></td>
			                            <td>${personalize.ou }</td>
			                            <td class="text-left">
			                                <p class="subject">
			                                    <a href="#">${personalize.title }</a>
			                                </p>
			                            </td>
			                            <td>${personalize.registerId }</td>
			                            <td><span class="text-blue">${personalize.recomendCnt }</span></td>
			                            <td><span class="text-black">${personalize.inqCnt }</span></td>
			                            <td>${personalize.registDtm }</td>
			                            <td><a href="/adm/deletePersonalize.do?rki=${personalize.rki }&knowlgMapType=${personalize.knowlgMapType }&ouCode=${personalize.ouCode }" class="btn btn-default" onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
			                        </tr>
			                        </c:if>
			                        </c:forEach>
		                        </tbody>
		                    </table>
		                    <div class="btn_area text-right">
								<a href="#newRegPopup" class="btn btn-blue min-lg btn-lg" data-toggle="modal" data-target="#newRegPopup">등록</a>
							</div>
						</div>
					</div>
                </div>
                <!-- //CONTENTS -->
                
                <div id="newRegPopup" class="modal fade" role="dialog" aria-labelledby="newRegPopupLabel">
                    <div class="modal-dialog" role="document">
                        <form:form id="personalizeFrm" class="modal-content form-horizontal" action="/adm/insertPersonalize.do" modelAttribute="personalizeVO">
                        	<input type="hidden" name="recomendTypeCd" value="PERSONALIZE">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <div class="h4 modal-title" id="newRegPopupLabel">등록</div>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">번호</label>
                                    <div class="col-sm-6">
                                        <form:select path="rki" class="form-control">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">지식맵</label>
                                    <div class="col-sm-6">
                                        <form:select path="knowlgMapType" class="form-control">
                                            <option value="REPORT">행정자료</option>
                                            <option value="REFERENCE">업무참고자료</option>
                                            <option value="PERSONAL">개인별지식</option>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">부서</label>
                                    <div class="col-sm-6">
                                        <form:select path="ouCode" class="form-control">
                                        	<c:forEach var="org" items="${orgList }">
                                        		<option value="${org.ouCode }">${org.ou }</option>
                                        	</c:forEach>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="mbSrch" class="col-sm-2 control-label">이름</label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <input type="text" id="mbSrch" name="srchText" class="form-control flow-enter-search" placeholder="지식 검색(2글자 이상 입력)" data-search-button="srchBtn"/>
                                            <span class="input-group-btn"><button type="button" id="srchBtn" class="btn btn-default">검색</button></span>
                                        </div>
                                        <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 등록할 지식을 검색 후 등록해 주세요.</p>
                                        <!-- 검색결과 -->
                                        <div class="result_area">
                                            <table class="table table-condensed text-center table-bordered table-hover all_chks_frm">
                                                <caption class="sr-only">사용자 목록</caption>
                                                <colgroup>
                                                    <col style="width:10%;">
                                                    <col>
                                                    <col>
                                                </colgroup>
                                                <thead>
                                                <tr>
                                                    <th scope="col">선택</th> 
                                                    <th scope="col">지식맵유형</th>
                                                    <th scope="col">제목</th>
                                                </tr>
                                                </thead>
                                                <tbody id="srchList">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer text-center">
                                <button type="submit" class="btn btn-primary min-md">확인</button>
                                <button type="button" class="btn btn-default min-md" data-dismiss="modal">취소</button>
                            </div>
                        </form:form>
                    </div>
                </div>
                <!-- //팝업 영역 종료 -->
                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->
<script type="text/javascript">
	$(function() {
		var errMsg = '${errMsg}';
		if(errMsg != ''){
			alert(errMsg);
		}
		
		$("#srchBtn").click(function(e){
			var searchText = $("input[name=srchText]").val();
			var knowlgMapType = $('select[name=knowlgMapType]').val();
     		$.ajax({
     			url : '/kno/relateKnowledgeList.do',
     			data : {
     				knowlgMapType : knowlgMapType,
     				searchType : 'TITLE',
     				searchText : searchText
     			},
     			dataType: "json",
     			success : function(data) {
		       		$('#srchList tr').remove();
		       		if(data.knowledgeList.length > 0){
			           	for(var i=0; i < data.knowledgeList.length; i++){
			           		$('#srchList').append('<tr>'+
			           				'<td><label for="brdChk'+i+'"><input type="radio" id="brdChk'+i+'" name="title" value="'+data.knowledgeList[i].title+'" required/></label></td>'+
			           				'<td>'+data.knowledgeList[i].knowlgMapType+'</td>'+
			           				'<td>'+data.knowledgeList[i].title+'</td>'+
			           				'</tr>');
			           	}
		       		} else{
		           		$('#srchList').append('<tr><td colspan="3">검색 결과가 없습니다.</td></tr>');
		       		}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});
		
		$('#personalizeFrm').submit(function(){
			var title = $('input[name="title"]:checked').val();
			if(title == null || title == undefined ){
				alert("등록할 지식을 선택해주세요.");
				return false;
			}
			if(!confirm('등록 하시겠습니까?')){
				return false;
			}
		});
		
		$('input[type="text"]').keydown(function() {
			if (event.keyCode === 13) {
				event.preventDefault();
			};
		});
	});
</script>