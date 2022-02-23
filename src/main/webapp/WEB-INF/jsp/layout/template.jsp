<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" 	uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="/images/egovframework/com/favicon.ico">
	<link rel="icon" href="/images/egovframework/com/favicon.ico">
    <title>새로운 경기 공정한 세상</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
    <!--[if IEMobile]>
    <meta http-equiv="cleartype" content="on" />
    <![endif]-->
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <!--[if lt IE 9]>
    <script src="/js/egovframework/com/wkp/html5shiv.min.js"></script>
    <script src="/js/egovframework/com/wkp/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="/css/egovframework/com/wkp/common.css" />
    <link rel="stylesheet" href="/css/egovframework/com/wkp/site.css" />
    <link rel="stylesheet" href="/css/egovframework/com/wkp/wiki.css" />
    <link rel="stylesheet" href="/css/egovframework/com/wkp/community.css" />
    <script src="/js/egovframework/com/wkp/jquery-1.11.3.min.js"></script>
    <script src="/js/egovframework/com/wkp/jquery.blockUI-2.7.0.min.js"></script>
    <script src="/js/egovframework/com/wkp/jquery.cookie.js"></script>
    <script src="/js/egovframework/com/wkp/moment.js"></script>
    <script src="/js/egovframework/com/wkp/base.js"></script>
    <script src="/js/egovframework/com/wkp/jquery-ui.min.js"></script>
    <script src="/js/egovframework/com/wkp/metisMenu.min.js"></script>
    <script src="/js/egovframework/com/wkp/owl.carousel.min.js"></script>
    <script src="/js/egovframework/com/wkp/main.js"></script>
    <script>
        $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
    </script>
</head>
<body>
<div id="wrap">
	<div id="skipNav">
	    <a href="#contents">본문 바로가기</a>
	    <a href="#gnbList">주메뉴 바로가기</a>
	</div>
	<tiles:insertAttribute name="header" />
	<div id="page">
	<tiles:insertAttribute name="contents" />
	<!-- //CONTNETS -->
	</div>
	<!-- //PAGE -->
	<tiles:insertAttribute name="footer" />
</div>
<!-- //WRAP -->
<script src="/js/egovframework/com/wkp/bootstrap.min.js"></script>
<script src='/js/egovframework/com/wkp/bootstrap-tagsinput.min.js'></script>
<script src="/js/egovframework/com/wkp/bootstrap-datetimepicker.min.js"></script>
<script src="/js/egovframework/com/wkp/jquery.easing.js"></script>
<script src="/js/egovframework/com/wkp/owl.carousel.min.js"></script>
<script src='/js/egovframework/com/wkp/jquery.matchHeight-min.js'></script>
<script src="/js/egovframework/com/wkp/hummingbird-treeview-1.3.js"></script>
<script src="/js/egovframework/com/wkp/jquery.mCustomScrollbar.concat.min.js"></script>
<!-- <script src="/js/egovframework/com/wkp/jquery.datetimepicker.full.js"></script> -->
<script src="/js/egovframework/com/wkp/ui.js"></script>
</body>
</html>