<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.dreamsecurity.sso.config.SSOConfig" %>
<%@ page import="com.dreamsecurity.sso.crypto.util.EncFunc" %>
<%@ page import="com.dreamsecurity.sso.crypto.util.HashEncFunc" %>
<%@ page import="com.dreamsecurity.sso.service.SSOService" %>
<%@ page import="com.dreamsecurity.sso.service.SSOServiceFactory" %>
<%@ page import="com.dreamsecurity.sso.message.SSOResp"%>
<%@ page import="com.dreamsecurity.sso.common.SSOBase"%>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="com.dreamsecurity.sso.log.Logger" %>
<%@ page import="com.dreamsecurity.sso.log.LoggerFactory" %>
<%@ page import="com.dreamsecurity.sso.service.SSOApiBase" %>
<%@ include file="./ssoCommon.jsp"%>
<%!
    
   private  Logger log = LoggerFactory.getInstance().getLogger(this.getClass());
	
	private void homepathCheck(String newpath){
		String homepath = System.getProperty("dreamsecurity.home.path");
		log.debug("current dreampath : "+homepath);
		if(null == homepath || "".equals(homepath)){
			System.setProperty("dreamsecurity.home.path",newpath);
			log.debug("new dreampath : "+newpath);
		}
	}
%>

<%
	System.out.println(" ===== TokenCheck  START =============================================");
	NumberFormat nf = new DecimalFormat("000000");
	String encryptedData = request.getParameter("ED");
	SSOService service = null;
	SSOResp resp = null;
	// Service 초기화
	try {
		service = SSOServiceFactory.getInstance(DREAM_HOME).getService(session);
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("encryptedData :: "+encryptedData);
	String tokens = null;
	String encryptedTokens = null;
	String accessURL = request.getRequestURL().toString();
	System.out.println(" ## requestURL : "+request.getRequestURL());
	System.out.println(" ## requestURI : "+request.getRequestURI());
		// 토큰확인
		
		System.out.println("User ip : "+request.getRemoteAddr());
		if(null == encryptedData || "".equals(encryptedData)){
			out.print(nf.format(0));
			return;
		}
		
			resp=service.validTokenCheck(encryptedData, request.getRemoteAddr());
			System.out.println(resp.getCode());
			int returnCode = resp.getCode();
			if (returnCode ==  SSOApiBase.RET_TOKEN_CHECK_FAIL)
			{
				System.out.println(" response : "+999999+resp.getMessage());
				out.print(999999+resp.getMessage());
			}
			else
			{
				System.out.println(" response : success");
				out.print(nf.format(1));
			}
	
%>
