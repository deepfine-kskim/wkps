<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
		<div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>마이페이지</h2>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <div class="row type12 mypage_grid">
                        <div id="grid1" class="col-md-4 col-sm-6">
                            <div class="frame_line">
                                <div class="title_bar">
                                    <h3>개인정보</h3>
                                </div>
                                <ul class="my_data_list tit_st_list">
                                    <li><div class="tit"><i class="fa fa-user-circle-o fa-fw" aria-hidden="true"></i>닉네임</div><div class="data text-right"><span class="text-primary"><c:choose><c:when test="${not empty nickName }">${nickName }</c:when><c:otherwise>${loginVO.nickName }</c:otherwise></c:choose></span></div></li>
                                    <!-- <li><div class="tit"><i class="fa fa-dot-circle-o fa-fw" aria-hidden="true"></i>마일리지</div><div class="data text-right"><span class="text-danger">${myMileageScore }</span>점</div></li> -->
                                    <li><div class="tit"><i class="fa fa-commenting-o fa-fw" aria-hidden="true"></i>질문수</div><div class="data text-right">${myQuestionCnt }</div></li>
                                    <li><div class="tit"><i class="fa fa-comments-o fa-fw" aria-hidden="true"></i>답변수</div><div class="data text-right">${myAnswerCnt }</div></li>
                                </ul>
                                <hr />
                                <!--
                                <div class="col-xs-6">
									<a href="javascript:;" id="reqManagerBtn" class="btn btn-black mt_10 btn-xs">부서 지식 관리자 등록 요청</a>
								</div>
								-->
								<div class="text-right">
									<a href="#nickNamePopup" data-toggle="modal" data-target="#nickNamePopup" class="btn btn-black outline mt_10 btn-xs">닉네임 변경</a>
                                </div>
                            </div>
                        </div>
                        <div id="grid2" class="col-md-4 col-sm-6">
                            <div class="frame_line">
                                <div class="title_bar">
                                    <h3>지식 수정요청/승계</h3>
                                </div>
                                <ul class="dot_list tit_st_list under">
                                    <%--<li><div class="tit"><a href="/myp/errorList.do">오류 신고</a></div> <div class="data text-danger text-right"><a href="/myp/errorList.do">${errorCnt }건</a></div></li>--%>
                                    <%--<li><div class="tit"><a href="/myp/approvalList.do">지식 등록</a></div>  <div class="data text-danger text-right"><a href="/myp/approvalList.do">${myCnt }건</a></div></li>--%>
                                    <li><div class="tit"><a href="/myp/modificationList.do">지식 수정요청</a></div></li>
                                    <li><div class="tit"><a href="/myp/succeedList.do">지식 승계</a></div></li>
                                </ul>
                            </div>
                        </div>
                        <div id="grid3" class="col-md-4 col-sm-6">
                            <div class="frame_line myp_slider_box">
                                <div class="title_bar">
                                    <h3>지식 즐겨찾기</h3>
                                </div>
                                <div class="list_slider owl-carousel owl-theme">
                                    <div class="item">
                                        <ul class="dot_list tit_st_list">
                                        	<c:forEach var="bookmark" items="${bookmarkList}">
                                                <li>
                                                    <div class="tit"><a href="/kno/knowledgeDetail.do?title=${bookmark.title}">${bookmark.title}</a></div>
                                                    <div class="data text-danger text-right" style="padding-right: 10px;"><a href="/myp/deleteBookmark.do?title=${bookmark.title}" onclick="return confirm('삭제하시겠습니까?');">[삭제]</a></div>
                                        	    </li>
                                        	</c:forEach>                                            
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="grid4" class="col-md-4 col-sm-6">
                            <div class="frame_line">
                                <div class="title_bar">
                                    <h3>My그룹</h3>
                                </div>
                                <ul id="grpList" class="dot_list tit_st_list">
                                	<c:forEach var="group" items="${groupList }">
                                    <li><div class="tit">${group.groupNm }</div> <div class="data text-danger text-right"><a href="/myp/insertGroupDetailView.do?groupNo=${group.groupNo }" class="text-danger ml_5">[편집]</a></div></li>
                                    </c:forEach>
                                </ul>
                                <hr />
                                <div class="text-right">
				                    <div class="inp_grp_box">
				                        <div class="input-group">
				                            <label for="grpName" class="sr-only">그룹명 입력</label>
				                            <input type="text" id="grpName" name="grpName" class="form-control" placeholder="그룹명" />
				                            <span class="input-group-btn"><a href="javascript:;" id="addBtn" class="btn btn-black">추가</a></span>
				                        </div>
				                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="grid5" class="col-md-4 col-sm-6">
                            <div class="frame_line">
                                <div class="title_bar">
                                    <h3>배경 설정</h3>
                                </div>
                                <ul class="dot_list tit_st_list">
                                    <li><div class="tit text-blue"><a href="/myp/myBG.do">[등록]</a></div> <div class="data text-danger text-right"><a href="/myp/deleteMyBG.do" onclick="return confirm('삭제하시겠습니까?');">[삭제]</a></div></li>
                                </ul>
                            </div>
                        </div>
                        <div id="grid6" class="col-sm-6 col-md-4">
                            <div class="frame_line myp_slider_box">
                                <div class="title_bar">
                                    <h3>관심분야</h3>
                                </div>
                                <div class="list_slider owl-carousel owl-theme">
                                    <div class="item">
                                        <ul class="dot_list">
                                            <c:forEach var="interests" items="${interestsList }">
                                            <li>
                                            	<a href="/kno/knowledgeList.do?knowlgMapNo=${interests.knowlgMapNo }">
                                            	<c:choose>
													<c:when test="${interests.knowlgMapType eq 'REPORT' }">행정자료</c:when>
													<c:when test="${interests.knowlgMapType eq 'REFERENCE' }">업무참고자료</c:when>
													<c:otherwise>개인별지식</c:otherwise>
												</c:choose>
												> ${interests.upNm } > ${interests.knowlgMapNm }
												</a>
											</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 원하는 박스를 클릭하신 후, 마우스를 누르신 상태로 순서를 이동시킬 수 있습니다.</p>
                </div>
                <!-- //page-body -->

                <!-- 닉네임 팝업 -->
                <div class="modal fade" id="nickNamePopup" tabindex="-1" role="dialog" aria-labelledby="nickNamePopupLabel">
                    <div class="modal-dialog" role="document">
                        <form:form class="modal-content form-horizontal" action="/usr/insertNickName.do" modelAttribute="userVO">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="nickNamePopupLabel"><strong>닉네임 변경</strong></h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group mb_0">
                                    <label for="commNickName" class="col-sm-3 control-label">닉네임</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="commNickName" name="nickName" placeholder="변경하실 닉네임을 입력하세요." required="required" />
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-blue">확인</button>
                                <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
                            </div>
                        </form:form>
                    </div>
                </div>
                <!-- //닉네임 팝업 -->

                <script src="/js/egovframework/com/wkp/myp.js"></script>
            </div>
            <!-- //CONTENTS -->
        </div>
<script>
	$(function(){
		$('#addBtn').click(function(){
			var grpName = $('input[name=grpName]').val();
			if(grpName == ''){
				alert("그룹명을 입력 해주세요.");
				return false;
			}
			
			$.ajax({
				url : '/myp/groupListRole.do',
				data : {
					groupNm : grpName
				},
				dataType: "json",
				success : function(data) {
		           	if(parseInt(data) > 0) {
		           		alert("그룹 이름이 중복 되었습니다.");
		           	} else {
		           		$.ajax({
		         			url : '/myp/insertGroup.do',
		         			data : {
		         				groupNm : grpName
		         			},
		         			dataType: "json",
		                    global: false,
		         			success : function(data) {
		         				$('#grpList').append('<li><div class="tit"><a href="#" data-toggle="modal" data-target="#treeGrpPopup">'+grpName+'</a></div> <div class="data text-danger text-right"><a href="/myp/insertGroupDetailView.do?groupNo='+data.groupNo+'" class="text-danger ml_5">[편집]</a></div></li>');
		         			},
		         			error : function(){
		         				alert("에러가 발생하였습니다.");
		         			}
		    			});
		           	}
				},
				error : function(){

				}
			});
		});
		
		$('#reqManagerBtn').click(function(){
			$.ajax({
     			url : '/usr/insertRequestManager.do',
     			dataType: "json",
                global: false,
     			success : function(data) {
     				alert("등록되었습니다.");
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
			});			
		});
	});
</script>
<c:if test="${not empty myBG }">
<style>
body{
	background-image:url("${myBG[0].fileStreCours }${myBG[0].streFileNm }");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</c:if>