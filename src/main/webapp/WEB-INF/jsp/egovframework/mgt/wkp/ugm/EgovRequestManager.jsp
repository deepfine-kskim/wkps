<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">부서 지식관리자 관리</h2>
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
                    <li class="active">부서 지식관리자 관리</li>
                </ol>
                <div id="contents">
					<form:form action="/adm/insertOrgManager.do" modelAttribute="userVO">
                    <table class="table table-bordered text-center table-hover">
                        <caption class="sr-only">게시판 리스트</caption>
                        <colgroup>
                            <col style="width:10%;" />
                            <col />
                            <col />
                            <col />
                            <col />
                        </colgroup>
                        <thead>
                            <tr>
								<th scope="col">선택</th>
                                <th scope="col">이름</th>
                                <th scope="col">부서</th>
                                <th scope="col">삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="manager" items="${requestManagerList }" varStatus="status">
                            <tr>
                            	<td><label for="brdChk${status.index }"><input type="checkbox" id="brdChk${status.index }" name="userList[${status.index }].sid" value="${manager.sid }" required="required"/></label></td>
                                <td>${manager.displayName }</td>
                                <td>${manager.ou }</td>
                                <td><a href="/adm/deleteRequestManager.do?sid=${manager.sid }" class="btn btn-default" onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="btn_area text-right">
                        <button type="submit" class="btn btn-blue min-lg btn-lg">등록</button>
                    </div>
                    </form:form>
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