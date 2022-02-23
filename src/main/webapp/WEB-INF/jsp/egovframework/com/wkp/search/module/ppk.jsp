<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="side_card_box mside_tog">
    <div class="side_top">
        <strong class="name text-danger"><i class="fa fa-tags"></i> 인기검색어</strong>
    </div>
    <div id="rankings" class="mside_tog_cont">
        <ol class="num_list">
        	<c:forEach var="ppkResult" items="${ppkList}" varStatus="status">
            	<li><a href="javascript:ppkSrch('${ppkResult.ppk}')"><span class="num">${ppkResult.meta}</span> ${ppkResult.ppk}</a></li>
            </c:forEach>
        </ol>
    </div>
</div>