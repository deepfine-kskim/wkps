<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String a = (String)session.getValue("SESSION_ID");

%>
<script type="text/javascript" src="js/jquery/jquery.fancytree.js"></script><!-- Fancy Tree -->
<script type="text/javascript" src="js/jquery/jquery.deserialize.min.js"></script><!-- Form deserialization -->
<script type="text/javascript" src="js/jquery/jquery.justified.js"></script><!-- Image gallery -->
<script type="text/javascript" src="js/lightbox.js"></script><!-- Image lightbox -->
<script type="text/javascript" src="js/jquery/i18n/jquery.konan.sf-ko.js"></script><!-- KSF localization -->
<script type="text/javascript" src="js/jquery/i18n/jquery.ui.datepicker-ko.js"></script><!-- Date picker localization -->
<script type="text/javascript" src="js/jquery/jquery.inputmask.bundle.js"></script>
<script type="text/javascript" src="js/search-ui.js"></script><!-- UI -->
<script type="text/javascript" src="js/kwl-1.0.0.js"></script><!-- KLA -->
<script type="text/javascript" src="js/search.js"></script><!-- Events -->
<script type="text/javascript" src="js/search.ksf.js"></script><!-- KSF Events -->
<script type="text/javascript" src="js/pagenav.js"></script><!-- page -->

<script src="js/jquery.blockUI-2.7.0.min.js"/>

${send}