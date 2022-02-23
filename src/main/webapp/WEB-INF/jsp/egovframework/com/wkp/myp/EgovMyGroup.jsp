<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
			<div id="contents">
	            <div class="page-header">
	                <h2>그룹 편집</h2>
	            </div>
	            <!-- //page-header -->
                <div class="page-body">
                    <div class="well well-white">
                        <div class="form-horizontal">
                            <div class="form-group mb_0">
                                <label for="grpNameSel" class="col-sm-4 control-label">그룹명</label>
                                <div class="col-sm-5">
                                    <input type="text" name="groupNm" class="form-control" value="${groupNm }" />
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row type0 grp_edit_row">
                            <div class="col-md-5 col-md-push-7 edit_box2">
                                <div class="panel panel-default panel-sm">
                                    <div class="panel-heading text-center">
                                        <strong class="panel-title">부서/개인 선택</strong>
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
			                            </div>
			                        </div>
                                </div>
                            </div>


                            <div class="col-md-2 edit_btn_area">
                                <ul class="text-center edit_nav">
                                    <li class="btn_wrap"><button type="button" id="grpAdd" class="edit_move"><span class="sr-only">이동</span></button></li>
                                    <li class="btn_wrap"><button type="button" id="grpDel" class="edit_cancel"><span class="sr-only">취소</span></button></li>
                                    <!-- 비활성화 버튼에 disabled 클래스 -->
                                </ul>
                            </div>

                            <div class="col-md-5 col-md-pull-7 edit_box1">
                                <div class="panel panel-default panel-sm">
                                	<form:form name="grpFrm" action="/myp/insertGroupDetail.do" modelAttribute="groupVO">
                                	<input type="hidden" name="groupNo" value="${groupNo }">
                                	<input type="hidden" name="deleteGrp" value="">
                                    <div class="panel-heading text-center">
                                        <strong class="panel-title">그룹 등록 목록</strong>
                                    </div>
                                    <div class="panel-body">
                                        <div class="edit_area edit_chk_area">
                                            <div class="hummingbird-treeview">
                                                <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
                                                <ul id="grpList" class="chk_tree_list hummingbird-base treeview">
                                                	<c:forEach var="group" items="${groupDetail }" varStatus="status">
                                                    <li>
                                                    	<label for="chk-${status.index}">
                                                    	<input id="chk-${status.index}" <c:choose><c:when test="${group.targetTypeCd eq 'ORG'}">name="orgList"</c:when><c:otherwise>name="userList"</c:otherwise></c:choose> data-id="customchk-${status.index}" type="checkbox" value="${group.targetCode}">${group.ouCode} ${group.targetName}
                                                    	</label>
                                                    </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                        <!-- //row -->
                    </div>
                    <div class="col-xs-6">
                        <a href="/myp/mypage.do" class="btn btn-black outline">마이페이지</a>
                    </div>
                    <div class="col-xs-6 text-right">
                    	<a id="grpSave" href="#alertPopup" data-toggle="modal" data-target="#alertPopup" class="btn btn-blue">확인</a>
                        <a href="/myp/deleteGroup.do?groupNo=${groupNo}" class="btn btn-danger">삭제</a>
                    </div>
                </div>
                <!-- //page-body -->

                <!-- 알림팝업 -->
                <%-- <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                    <div class="modal-dialog modal-sm" role="document">
                        <form class="modal-content">
                            <div class="modal-header sr-only">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="alertPopupLabel">알림</h4>
                            </div>
                            <div class="modal-body text-center">
                                <span class="text-primary">저장</span>  되었습니다.
                            </div>
                            <div class="modal-footer text-center">
                                <button type="button" id="grpSave" class="btn btn-blue btn-sm" data-dismiss="modal">확인</button>
                            </div>
                        </form>
                    </div>
                </div> --%>
                <!-- //알림팝업 -->

            </div>
            <!-- CONTENTS -->
        </div>
        
<script>
	$(function(){
		$("#orgBtn").click(function(e){
			var ou = $("input[name=orgText]").val();
			$( 'input[name="allChk1"]' ).attr( 'checked', false );
     		$.ajax({
     			url : '/org/orgList.do',
     			data : {
     				ou : ou 
     			},
     			dataType: "json",
     			success : function(data) {
               		$('#orgList li').remove(); 
                   	for(var i=0; i < data.orgList.length; i++){
                   		$('#orgList').append('<li><label for="chk-'+i+'"><input id="chk-'+i+'" name="orgList" data-id="customChk-'+i+'" type="checkbox" value="'+data.orgList[i].ouCode+'" data-idx="'+i+'" data-code="'+data.orgList[i].ouCode+'" data-name="'+data.orgList[i].ou+'">'+data.orgList[i].ou+'</label></li>');
                   	}
     			},
     			error : function(){

     			}
     		});
		});
		
		$("#userBtn").click(function(e){
			var displayName = $("input[name=userText]").val();
			$( 'input[name="allSrchChk"]' ).attr( 'checked', false );
     		$.ajax({
     			url : '/usr/userList.do',
     			data : {
     				displayName : displayName
     			},
     			dataType: "json",
     			success : function(data) {
               		$('#userList li').remove(); 
                   	for(var i=0; i < data.userList.length; i++){
                   		$('#userList').append('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-idx="'+i+'" data-sid="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" + data-ou="'+data.userList[i].ou+'">'+ data.userList[i].ou + ' ' + data.userList[i].displayName+'</label></li>');
                   	}
     			},
     			error : function(){

     			}
     		});
		});
		
		$("#grpAdd").click(function(e){
			$('input:checkbox[name="orgList"]').each(function(e){
				var grpChk = 0;
				if(this.checked){
					var grpCode = $(this).val();
					//console.log("선택 - " + grpCode);
					$("#grpList").children().each(function() {
						console.log($.trim("기존 등록 - " + $("#grpList").children('li').children('label').children('input').attr('value')));
						if($.trim(grpCode) == $.trim($(this).children('label').children('input').attr('value'))) {
							alert($.trim($(this).text()) + " 부서는 이미 포함되어 있습니다.");
							grpChk = grpChk + 1;
							return false;
						}
					});
					
					if(grpChk == 0) {
						$('#grpList').append('<li><label for="chk-'+$(this).data('idx')+'"><input id="chk-'+$(this).data('idx')+'" name="orgList" data-id="customChk-'+$(this).data('idx')+'" type="checkbox" value="'+grpCode+'" checked="checked">'+$(this).data('name')+'</label></li>');	
					}
				}	
			});
			$("#orgList").children('li').children('label').children('input[name="orgList"]' ).attr('checked', false);

			$('input:checkbox[name="userList"]').each(function(e){
				var nameChk = 0;
				if(this.checked){
					var nameCode = $(this).val();
					//console.log("선택 - " + nameCode);
					$("#grpList").children().each(function() {
						//console.log("기존 - " + $("#grpList").children('li').children('label').children('input').attr('value'));
						if(nameCode == $.trim($(this).children('label').children('input').attr('value'))) {
							alert($.trim($('input:checkbox[name="userList"]').data('ou') + ' ' + $('input:checkbox[name="userList"]').data('name')) + " 그룹원이 이미 포함되어 있습니다.")
							nameChk = nameChk + 1;
							return false;
						}
					});
					
					if(nameChk == 0) {
						$('#grpList').append('<li><label for="allSrchChk-'+$(this).data('idx')+'"><input id="allSrchChk-'+$(this).data('idx')+'" name="userList" data-id="allSrchChk-'+$(this).data('idx')+'" type="checkbox" value="'+nameCode+'" checked="checked">'+$(this).data('ou')+' '+$(this).data('name')+'</label></li>');	
					}
				}
			});
					
			$("#userList").children('li').children('label').children('input[name="userList"]' ).attr('checked', false);
			$( 'input[name="allChk1"]' ).attr( 'checked', false );
			$( 'input[name="allSrchChk"]' ).attr( 'checked', false );
			
			var form = $("form[name=grpFrm]");
            form.submit();
			
		});
		
		$("#grpDel").click(function(e){
		    $('input[type="checkbox"]:checked').each(function (index) {
		    	$(this).closest('label').closest('li').remove();
		    	
		    	//alert($(this).val());
		        //$("input[name=deleteGrp]").value("value 값 바꾸기");

		    	$.ajax({
	     			url : '/myp/deleteGroupDetail.do',
	     			data : {
	     				groupNo : ${groupNo},
	     				targetCode : $(this).val()
	     			},
	     			dataType: "json",
	     			success : function(data) {
	               		alert(data);
	     			},
	     			error : function(){

	     			}
	     		});
		    });
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
		
		
		$('#grpSave').click(function(e){
			location.href="/myp/mypage.do";
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