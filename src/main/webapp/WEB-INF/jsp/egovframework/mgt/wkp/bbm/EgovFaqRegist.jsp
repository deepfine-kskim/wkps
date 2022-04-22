<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">FAQ</h2>
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
                    <li>게시판 관리</li>
                    <li class="active">FAQ</li>
                </ol>
                <div id="contents">
                    <!-- 글작성 -->
                    <div class="well well-lg well-white">
                    <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
					<form:form name="faqFrm" class="form-horizontal" action="/adm/insertFaq.do" modelAttribute="faqVO" method="post" enctype="multipart/form-data">
                        <fieldset>
                            <legend class="sr-only">게시판 글작성</legend>
                            <div class="brd_write_area">
                                <div class="form-group">
                                    <label for="faqType" class="col-xs-2 control-label"><span class="req">*</span>지식맵</label>
                                    <div class="col-xs-10">
                                        <form:select path="faqType" class="form-control">
                                            <option value="KNOWLEDGE">지식백과</option>
                                            <option value="REQUEST">지식요청</option>
                                            <option value="SURVEY">설문조사</option>
                                            <option value="COMMUNITY">커뮤니티</option>
                                            <option value="ETC">기타</option>
                                            <%--<option value="QNA">Q&A</option>
                                            <option value="FAQ">FAQ</option>
                                            <option value="NOTICE">공지사항</option>
                                            <option value="CALENDAR">일정</option>--%>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inpSubject" class="col-xs-2 control-label"><span class="req">*</span> 제목</label>
                                    <div class="col-xs-10">
                                        <input type="text" class="form-control" id="inpSubject" name="title" placeholder="제목를 입력하세요" required />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inpText" class="col-xs-2 control-label"><span class="req">*</span> 내용</label>
                                    <div class="col-xs-10">
                                        <textarea class="form-control" rows="10" id="inpText" name="cont" required></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="file" class="col-xs-2 control-label">첨부파일</label>
                                    <div class="col-xs-7">
                                        <input type="file" class="form-control" id="file" name="file" />
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="text-right">
                        <button type="submit" class="btn btn-blue btn-lg">작성완료</button>
                        <a href="/adm/faqList.do" class="btn btn-black btn-lg">취소</a>
                    </div>
                    </form:form>
                    <!-- //글작성 -->                
                </div>
                <!-- //CONTENTS -->
                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->
<script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<script type="text/javascript">
	CKEDITOR.replace('inpText');
</script>