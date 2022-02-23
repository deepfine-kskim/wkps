<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>배경 설정</h2>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <div class="well well-primary outline msg_box">
                    	마이 페이지의 배경화면을 바꾸실 수 있습니다.
                    </div>
					<p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
	            	<form:form id="BGFrm" class="form-horizontal" action="/myp/updateMyBG.do" modelAttribute="userVO" encType="multipart/form-data">
	            	<fieldset>
		            	<legend class="sr-only">게시판 글작성</legend>
		            	<div class="brd_write_area">
		                    <div class="form-group">
		                        <label for="inpFile1" class="col-sm-1 control-label"><span class="req">*</span> 첨부파일</label>
		                        <div class="col-sm-11">
		                            <input type="file" class="form-control" id="inpFile1" name="file" required />
		                        </div>
		                    </div>
		                    <div class="text-center">
		                        <button type="submit" class="btn btn-blue">선택적용</button>
		                        <a href="/myp/mypage.do" class="btn btn-black">취소</a>
		                    </div>
		                </div>
	                </fieldset>
					</form:form>
                </div>
                <!-- //page-body -->
                <script src="/js/egovframework/com/wkp/myp.js"></script>

            </div>
            <!-- //CONTENTS -->
        </div>
<c:if test="${not empty myBG }">
<style>
body{
	background-image:url("${myBG[0].fileStreCours }${myBG[0].streFileNm }");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</c:if>