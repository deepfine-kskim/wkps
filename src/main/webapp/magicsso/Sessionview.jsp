<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="com.dreamsecurity.sso.crypto.util.DEFCrypto"%>
<%@page import="java.util.*"%>

 <%@ include file="./ssoCommon.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>사용자 조회</TITLE>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./js/deployJava.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/MagicLine.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/MagicPass.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/Login.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/Monitor.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/Certificate.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/cookie.js" charset="utf-8"></script>
<script type="text/javascript">
function logout(idx){
	switch(idx){
	case 1 : MagicPass.siteLogout(); break;
	case 2 : location.href=MagicPass.loginUrl; break;
	}
	
}
var flag = false;
function showLayer(){
	if(!flag){
	 	document.getElementById("sysinfo_lay").style.display="block";
	 	document.getElementById("showLayer").value="환경정보 감추기";
	}else{
		document.getElementById("sysinfo_lay").style.display="none";
		document.getElementById("showLayer").value="환경정보 보기";
	}
	flag = !flag;
}
</script>
</HEAD>

<body  topmargin=0 leftmargin=50 height=100% width=100%>
<form name="frmMemberList" method="post" action="" onsubmit="sso_search_user()">
<table cellpadding=0 cellspacing=0 width=80% height=98%>
<tr valign=top>
	<td>
		<table cellpadding=0 cellspacing=0 width=100%>
		<tr>
		</tr>
		</table>
		<p style='margin-top:12px;'></p>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr height=25>
				<td nowrap><img src="./img/board/search_type01_le.gif"></td>
				<td width=95% bgcolor=EDEDED align="center" id="u0_info">
					로그인 사용자 정보 (Sample)
				</td>
				<td width=5% bgcolor=EDEDED align="right" id="u0_info">
				<% if(null != session.getAttribute("SSO_ID")) {%>
					<input class=s_btn_4gray type="button" id="logoutBt" name="logoutBt" value="로그아웃" onclick="logout(1);return false;"/>
				<% }else{%>
					<input class=s_btn_4gray type="button" id="logoutBt" name="logoutBt" value="로그인" onclick="logout(2);return false;"/>
				<%} %>
				</td>
				<td nowrap><img src="./img/board/search_type01_ri.gif"></td>
			</tr>
		</table>
		<p class=br_5></p>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="board_type01">
		<tr height=25 align="center">
			<td width="20%" class="board_type01_ti">이름 (세션)</td>
			<td class="board_type01_ti">값</td>
		</tr>
		<tr height=25 align=left>
			<!-- <td class="board_type01_in_td"> </td> -->
			<td class="board_type01_in_td"> File.encoding</td>
			<td class="board_type01_in_td"><%=System.getProperty("file.encoding") %> </td>
			<!-- <td class="board_type01_in_td"> </td> -->
		</tr>
		<tr>
			<td height="1" colspan="100" class="board_type01_line"></td>
		</tr>
		
		<tr height=25 align=left bgcolor="F9F9F9">
			<td class="board_type01_in_td"> SESSION_ID</td>
			<td class="board_type01_in_td"><%=session.getId() %> </td>
		</tr>
		<tr>
			<td height="1" colspan="100" class="board_type01_line"></td>
		</tr>
<%
    int i=0;
	Enumeration sNames = session.getAttributeNames();
	while(sNames.hasMoreElements())
	{
		Object so = sNames.nextElement();
		if(so != null){
%>
			<tr height=25 align=left bgcolor='<%=(i % 2) == 0? "ffffff" : "F9F9F9"%>' style="cursor:pointer;" >
				<td class='board_type01_in_td'><%= ((String)so).replaceAll("!\"#[$]%&\\(\\)\\{\\}@`[*]:[+];-.<>,\\^~|'\\[\\]", "")%></td>
				<td class='board_type01_in_td'><%=session.getAttribute(((String)so).replaceAll("!\"#[$]%&\\(\\)\\{\\}@`[*]:[+];-.<>,\\^~|'\\[\\]", "")) %></td>
			</tr>
			<tr>
				<td height="1" colspan="100" class="board_type01_line"></td>
			</tr>
<%
			i++;
		}

	}
	
%>

		</table>
		
		<!-- request 정보 -->
		<p class=br_5></p>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="board_type01">
		<tr height=25 align="center">
			<td width="20%" class="board_type01_ti">이름 (Request)</td>
			<td class="board_type01_ti">값</td>
		</tr>
		
		<tr>
			<td height="1" colspan="100" class="board_type01_line"></td>
		</tr>
<%
    int j=0;
	Enumeration rNames = request.getParameterNames();
	while(rNames.hasMoreElements())
	{
		Object so = rNames.nextElement();
		if(so != null){
%>
			<tr height=25 align=left bgcolor='<%=(j % 2) == 0? "ffffff" : "F9F9F9"%>' style="cursor:pointer;" >
				<td class='board_type01_in_td'><%= ((String)so).replaceAll("!\"#[$]%&\\(\\)\\{\\}@`[*]:[+];-.<>,\\^~|'\\[\\]", "")%></td>
				<td class='board_type01_in_td'><%=request.getParameter(((String)so).replaceAll("!\"#[$]%&\\(\\)\\{\\}@`[*]:[+];-.<>,\\^~|'\\[\\]", "")) %></td>
			</tr>
			<tr>
				<td height="1" colspan="100" class="board_type01_line"></td>
			</tr>
<%
			j++;
		}

	}
%>

		</table>
		
		<!-- 시스템 정보 -->
		<p class=br_5></p>
		<input type="button"  id="showLayer" name="showLayer" value="환경정보보기" onclick="showLayer();return false;"  />
		<div id="sysinfo_lay"  style="display: none;">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="board_type01">
		<tr height=25 align="center">
			<td width="20%" class="board_type01_ti">이름 (Request)</td>
			<td class="board_type01_ti">값</td>
		</tr>
		
		<tr>
			<td height="1" colspan="100" class="board_type01_line"></td>
		</tr>
<%
    int z=0;
	Enumeration sysNames = System.getProperties().propertyNames();
	while(sysNames.hasMoreElements())
	{
		Object so = sysNames.nextElement();
		if(so != null){
%>
			<tr height=25 align=left bgcolor='<%=(j % 2) == 0? "ffffff" : "F9F9F9"%>' style="cursor:pointer;" >
				<td class='board_type01_in_td'><%= ((String)so).replaceAll("!\"#[$]%&\\(\\)\\{\\}@`[*]:[+];-.<>,\\^~|'\\[\\]", "")%></td>
				<td class='board_type01_in_td'><%=System.getProperty(((String)so).replaceAll("!\"#[$]%&\\(\\)\\{\\}@`[*]:[+];-.<>,\\^~|'\\[\\]", "")) %></td>
			</tr>
			<tr>
				<td height="1" colspan="100" class="board_type01_line"></td>
			</tr>
<%
			j++;
		}

	}
%>

		</table>
		</div>
</table>
</form>
</body>
</HTML>
