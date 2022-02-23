<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="./ssoCommon.jsp" %>
<%
	String code = XSSCheck(request.getParameter("code"));
    String msg  = XSSCheck(request.getParameter("message"));
    code = (null == code || "".equals(code))?(String)request.getAttribute("code"):code;
    msg  = (null == msg  || "".equals(msg)) ?(String)request.getAttribute("rltMsg"):msg;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Notice</title>
	<style>
	@charset "utf-8";
html,body{margin:0;padding:0;width:100%;overflow:hidden;}

#head				{background:url("../img/icon_install.png") no-repeat 10px 50%;background-color:#369;height:50px;font:normal 11pt 돋움,dotum;letter-spacing:-1px;color:#fff;font-weight:bold;text-indent:40px;}
#head div			{float:left;}
#head #buttonClose	{background:url("../img/btn_close.gif") no-repeat 50% 50%;width:50px;height:50px;position:absolute;right:0;cursor:pointer;}

#main	{background:#FFF;font:normal 9pt "돋움",dotum;position:relative;padding:10px;text-align:justify;}
#main p {line-height:1.2em}

#foot		{background:#FFF;text-align:center;}
#foot p		{font:normal 8pt 돋움,dotum}
#foot input	{margin:0;padding:2px;}

#download{background:url("../img/btn_offLineDownload.gif");width:136px;height:29px;border:0;cursor:pointer;text-align:center;}

.valignMiddle	{vertical-align:middle;line-height:50px}
.underline		{text-decoration:underline;}
.clear			{clear:left;}

.boxCase		{margin-top:30px;}
#messageBox		{text-align:center;font:normal 12pt "돋움",dotum;font-weight:bold;}
#messageArea	{width:500px;margin:auto auto;margin-top:40px;padding-top:20px;border-top:1px solid #ccc;text-align:left;font:normal 10pt "돋움",dotum;font-weight:bold;}
#buttonBox		{width:500px;margin:auto auto;margin-top:40px;padding-top:20px;border-top:1px solid #ccc;text-align:center;}
	</style>
</head>
<body>
	<div id="head" style="background-color:#B00">
		<div class="valignMiddle">SSO  오류 알림</div>
		<div id="buttonClose" title="닫기"  onclick="window.self.close();"></div>
	</div>
	<div id="main">
		<div class="boxCase">
			<div id="messageBox">잘못된 접근입니다. 정상적인 이용을 부탁드립니다.</div>
			<div id="messageArea"></div>
			<div id="buttonBox"><button id="closeWindow" onclick="window.self.close();">창닫기</button></div>
		</div>
	</div>
	
	<script type="text/javascript">
	//<![CDATA[
		document.getElementById("messageArea").innerHTML = "<dl><dd>에러코드 : <%=code%></dd></dl><dl><dd>에러메시지 : <%=msg%></dd></dl>";
	//]]>
	</script>
</body>
</html>