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
<%@ include file="./ssoCommon.jsp"%>
<%!
    
	private Logger log =LoggerFactory.getInstance().getLogger(this.getClass());

	private void setUserInformation(SSOService service, HttpSession httpSession,HttpServletResponse httpResponse) {
		httpSession.setAttribute(S_LOGIN_ID, service.getTokenValue(T_USER_ID));
		httpSession.setAttribute(S_LOGIN_NAME, service.getTokenValue(T_LOGIN_NAME));
		httpSession.setAttribute(S_PW, service.getTokenValue(T_PW));
		httpSession.setAttribute(S_COMP_CODE, service.getTokenValue(T_COMP_CODE));
		
		httpSession.setAttribute(S_SN_VALIDATE, service.getTokenValue(T_SN_VALIDATE));
		httpSession.setAttribute(S_PW_VALIDATE, service.getTokenValue(T_PW_VALIDATE));
		httpSession.setAttribute(S_LASTLOGIN_CHECK, service.getTokenValue(T_LASTLOGIN_CHECK));
		httpSession.setAttribute(S_ACLCODE_LIST, service.getTokenValue(T_ACLCODE_LIST));
		
	}
	
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
    Logger logger = LoggerFactory.getInstance().getLogger(this.getClass());
	homepathCheck(getServletConfig().getServletContext().getRealPath(DREAM_HOME));
	NumberFormat nf = new DecimalFormat("000000");
	System.out.println(" ##### START ##### ");
    String process = request.getParameter("proc"); // S : 안전번호 확인 || null : 기존로그인
	String loginType = request.getParameter("loginType");
	String encryptedData = request.getParameter("ED");
	String macAddr = request.getParameter("MAC");
	System.out.println("process :: "+process);
	System.out.println("encryptedData :: "+encryptedData);
	String tokens = null;
	String encryptedTokens = null;
	
	SSOService service = null;
	SSOResp resp = null;
	// Service 초기화
	try {
		service = SSOServiceFactory.getInstance(DREAM_HOME).getService(session);
	} catch (Exception e) {
		logger.error(e);
		e.printStackTrace();
	}
	System.out.println(" ##### encryptedData : "+encryptedData);
	
	// 로그인
	if (loginType == null)
	{
		loginType = "0";		// 기본값은 ID/PASS 로그인
	}
    Map req = new HashMap();
    req.put(SSOBase.P_LOGIN_TYPE,loginType);
    req.put(SSOBase.P_ENCRYPTED_DATA,encryptedData);
    req.put(SSOBase.P_USER_IP,(null == macAddr || "".equals(macAddr))?request.getRemoteAddr():request.getRemoteAddr()+SSOBase._SEP+macAddr);
    req.put(SSOBase.P_CHARSET,"EUC-KR");
    
	resp = service.loginFromTest(req);
	
	if(0==resp.getCode()){
		out.println(resp.getMessage());
	}else{
		out.println(nf.format(223));
	}
		
	
%>