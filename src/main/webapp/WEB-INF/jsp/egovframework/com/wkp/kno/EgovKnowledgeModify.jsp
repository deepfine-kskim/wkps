<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
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
                                        	<c:forEach var="excellenceUser" items="${excellenceUserList }" varStatus="status">
                                                <c:if test="${status.index < 5}">
                                                    <li>
                                                        <strong class="text-primary">${excellenceUser.rki }위</strong> ${excellenceUser.displayName }
                                                    </li>
                                                </c:if>
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
				<form:form id="mdfFrm" class="form-horizontal" action="${isOwner ? '/kno/modifyKnowledge.do' : '/kno/modifyKnowledgeRequest.do'}" modelAttribute="knowledgeVO">
                <div id="contents" class="col-md-9">
                    <div class="page-body">
                        <%--<p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>--%>
                            <input type="hidden" name="title" value="${knowledgeDetail.title }">
                        	<input type="hidden" name="knowlgNo" value="${knowledgeDetail.knowlgNo }">
							<input type="hidden" name="sortOrdr" value="${knowledgeContents.sortOrdr }">
							<input type="hidden" name="knowlgMapType" value="${knowledgeDetail.knowlgMapType }">
							<input type="hidden" name="aprvYn" value="Y"> <!-- 승인여부 -->
							<fieldset>
                                <legend class="sr-only">지식 편집</legend>
                                <div class="brd_write_area wiki_frms">
                                    <div class="form-group">
                                        <label for="inpText" class="col-sm-2 control-label"><%--<span class="req">*</span> --%>내용</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" id="inpText" name="cont" placeholder="내용을 입력하세요" <%--required--%>>
                                            ${knowledgeContents.cont}
                                            </textarea>
                                        </div>
                                    </div>
                                    <c:if test="${not isOwner}">
                                        <div class="form-group">
                                            <label for="requestContent" class="col-sm-2 control-label">편집 내용 요약</label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" rows="3" id="requestContent" name="requestContent" placeholder="편집요청 부분을 요약기재하면 담당자에게 전달됩니다."></textarea>
                                            </div>
                                        </div>
                                    </c:if>
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
                                <div class="row type0">
                                    <div class="col-sm-6">
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <button id="submit" type="submit" class="btn btn-blue">작성완료</button>
                                        <a href="javascript:;" class="btn btn-black dev-cancel">취소</a>
                                    </div>
                                </div>
                            </fieldset>
                        <!-- //글작성 -->
                    </div>
                    <!-- //page-body -->
                </div>
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
                <!-- CONTENTS -->
            </div>
            <!-- //row -->
        </div>
<form:form name="knowledgeFrm" modelAttribute="knowledgeVO">
    <input type="hidden" name="title" value="${knowledgeDetail.title}">
    <input type="hidden" name="knowlgNo" value="${knowledgeDetail.knowlgNo}">
    <input type="hidden" name="knowlgMapType" value="${knowledgeVO.knowlgMapType}">
    <input type="hidden" name="knowlgMapNo" value="${knowledgeVO.knowlgMapNo}">
    <input type="hidden" name="page" value="${knowledgeVO.page}">
</form:form>
<script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<script type="text/javascript">
	CKEDITOR.replace('inpText');
	
	$(function() {
	
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
		
		$("#submit").click(function() {
            var cont = CKEDITOR.instances.inpText.getData();
            /*if(cont == ''){
            	alert("내용을 입력해주세요.");
            	return false;
            }*/
            /*
            var type = '${knowledgeDetail.knowlgMapType }';
            if((type == 'REPORT' || type == 'REFERENCE') && $('input[name=approverId]').val() == undefined){
            	alert("승인자를 선택해주세요.");
            	return false;
            }
            */
		});

        $('.dev-cancel').on('click', function (e) {
            e.preventDefault();
            var form = $("form[name=knowledgeFrm]");
            form.attr("action", "/kno/knowledgeDetail.do");
            form.submit();
        });
	});
</script>