<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">관리자 관리</h2>
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
                    <li>사용자 관리</li>
                    <li class="active">관리자 관리</li>
                </ol>
                <div id="contents">
                <div style="font-weight: bold; font-size: 12pt;">※하나의 사용자는 하나의 권한만 가능합니다.</div>
                    <table class="table table-bordered text-center table-hover">
                        <caption class="sr-only">게시판 리스트</caption>
                        <colgroup>
                            <col style="width:10%;" />
                            <col />
                            <col />
                            <col />
                            <col style="width:10%;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">이름</th>
                                <th scope="col">부서</th>
                                <th scope="col">권한</th>
                                <th scope="col">삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="manager" items="${managerList }" varStatus="status">
                            <tr>
                                <td>${status.index+1 }</td>
                                <td>${manager.displayName }</td>
                                <td>${manager.ou }</td>
                                <td>${manager.roleNm }</td>
                                <td><a href="/adm/deleteManager.do?sid=${manager.sid }" class="btn btn-default" onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="btn_area text-right">
                        <a href="#newRegPopup" class="btn btn-blue min-lg btn-lg" data-toggle="modal" data-target="#newRegPopup">등록</a>
                    </div>
                </div>
                <!-- //CONTENTS -->
                
                <div id="newRegPopup" class="modal fade" role="dialog" aria-labelledby="newRegPopupLabel">
                    <div class="modal-dialog" role="document">
                        <form:form id="roleForm" class="modal-content form-horizontal" action="/adm/insertManager.do" modelAttribute="userVO">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <div class="h4 modal-title" id="newRegPopupLabel">관리자 신규 등록</div>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">권한</label>
                                    <div class="col-sm-6">
                                        <form:select path="roleCd" class="form-control">
                                            <option value="ROLE_ORG">부서지식관리자</option>
                                            <option value="ROLE_KNOWLEDGE">지식관리자</option>
                                            <option value="ROLE_SURVEY">설문조사 관리자</option>
                                            <option value="ROLE_COMMUNITY">커뮤니티 관리자</option>
                                            <option value="ROLE_ADMIN">시스템 관리자</option>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="mbSrch" class="col-sm-2 control-label">추가</label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <input type="text" id="mbSrch" name="userName" class="form-control" placeholder="이름 검색(2글자 이상 입력)" />
                                            <span class="input-group-btn"><button type="button" id="srchBtn" class="btn btn-default">검색</button></span>
                                        </div>
                                        <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 관리자로 등록할 사용자의 이름을 검색 후 등록해 주세요.</p>
                                        <!-- 검색결과 -->
                                        <div class="result_area">
                                            <table class="table table-condensed text-center table-bordered table-hover all_chks_frm">
                                                <caption class="sr-only">가입신청 회원 목록</caption>
                                                <colgroup>
                                                    <col style="width:10%;">
                                                    <col>
                                                    <col>
                                                </colgroup>
                                                <thead>
                                                <tr>
                                                    <th scope="col">선택</th>
                                                    <th scope="col">이름</th>
                                                    <th scope="col">부서</th>
                                                </tr>
                                                </thead>
                                                <tbody id="userList">
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
                <script>
                    $('.list-select > .list-group-item').on('click', function() {
                        $('.list-group-item').not($(this)).removeClass('active');
                        $(this).toggleClass('active');
                    });
                </script>
                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->
<script>
	$(function(){		
		$("#srchBtn").click(function(e){
			var displayName = $("input[name=userName]").val();
			$.ajax({
				url : '/usr/userList.do',
				data : {
					displayName : displayName
				},
				dataType: "json",
				success : function(data) {
		       		$('#userList tr').remove(); 
		           	for(var i=0; i < data.userList.length; i++){
		           		$('#userList').append('<tr>'+
		           				'<td><label for="brdChk'+i+'"><input type="radio" id="brdChk'+i+'" name="sid" value="'+data.userList[i].sid+'"  required="required"/></label></td>'+
		           				'<td>'+data.userList[i].displayName+'</td>'+
		           				'<td>'+data.userList[i].ou+'</td>'+
		           				'</tr>');
		           	}
				},
				error : function(){

				}
			});
		});
		
		
		$('#roleForm').submit(function(event){ 
			// 자동 submit을 시키는 것을 막는다. 
			event.preventDefault(); 
			
			var displayName = $("input[name=userName]").val();
			if(displayName == '') {
				alert("이름을 입력해주세요.");
				return false;
			}
			
			var sid = $("input[name=sid]").val();
			$.ajax({
				url : '/usr/selectUserRoleCheck.do',
				data : {
					sid : sid
				},
				dataType: "json",
				success : function(data) {
		           	if(parseInt(data) > 0) {
		           		alert("하나의 사용자는 하나의 권한만 가능합니다.");
		           	} else {
		           		event.currentTarget.submit();
		           	}
				},
				error : function(){

				}
			});
		});
		
	});
</script>