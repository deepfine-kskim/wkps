/**
 *  Class Name : EgovClntInfo.java
 *  Description : 클라이언트(Client)의 IP주소, OS정보, 웹브라우저정보를 조회하는 Business Interface class
 *  Modification Information
 * 
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.01.19    박지욱          최초 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 01. 19
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
package egovframework.com.utl.sim.service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;

public class EgovClntInfo {
	
	/**
	 * 클라이언트(Client)의 IP주소를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String ipAddr IP주소
	*/
	public static String getClntIP(HttpServletRequest request) {
		
		// IP주소
		String ipAddr = request.getRemoteAddr();
		return ipAddr;
	}
	
	/**
	 * 클라이언트(Client)의 OS 정보를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String osInfo OS 정보
	 * @exception Exception
	*/
	public static String getClntOsInfo(HttpServletRequest request) {
	
		String userAgent = request.getHeader("user-agent");
		String osInfo = userAgent.toUpperCase().split(";")[2].split("\\)")[0];
		String osConf = EgovProperties.getProperty(Globals.CLIENT_CONF_PATH, osInfo.replaceAll(" ", ""));
		String newOsInfo = "";
		if (StringUtils.isNotBlank(osConf)) {
			newOsInfo = osConf;
		} else {
			newOsInfo = osInfo;
		}
		return newOsInfo;
	}
	
	/**
	 * 클라이언트(Client)의 웹브라우저 종류를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String webKind 웹브라우저 종류
	 * @exception Exception
	*/
	public static String getClntWebKind(HttpServletRequest request) {
		
		String userAgent = request.getHeader("user-agent");
		
		// 웹브라우저 종류 조회
		String webKind = "";
		if (userAgent.toUpperCase().indexOf("GECKO") != -1) {
			if (userAgent.toUpperCase().indexOf("NESCAPE") != -1) {
				webKind = "Netscape (Gecko/Netscape)";
			} else if (userAgent.toUpperCase().indexOf("FIREFOX") != -1) {
				webKind = "Mozilla Firefox (Gecko/Firefox)";
			} else {
				webKind = "Mozilla (Gecko/Mozilla)";
			}
		} else if (userAgent.toUpperCase().indexOf("MSIE") != -1) {
			if (userAgent.toUpperCase().indexOf("OPERA") != -1) {
				webKind = "Opera (MSIE/Opera/Compatible)";
			} else {
				webKind = "Internet Explorer (MSIE/Compatible)";
			}
		} else if (userAgent.toUpperCase().indexOf("SAFARI") != -1) {
			if (userAgent.toUpperCase().indexOf("CHROME") != -1) {
				webKind = "Google Chrome";
			} else {
				webKind = "Safari";
			}
		} else if (userAgent.toUpperCase().indexOf("THUNDERBIRD") != -1) {
			webKind = "Thunderbird";
		} else {
			webKind = "Other Web Browsers";
		}
		return webKind;
	}
	
	/**
	 * 클라이언트(Client)의 웹브라우저 버전을 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String webVer 웹브라우저 버전
	 * @exception Exception
	*/
	public static String getClntWebVer(HttpServletRequest request) {
		
		String userAgent = request.getHeader("user-agent");
		
		// 웹브라우저 버전 조회
		String webVer = "";
		String [] arr = {"MSIE", "OPERA", "NETSCAPE", "FIREFOX", "SAFARI"};
		for (int i = 0; i < arr.length; i++) {
			int sLoc = userAgent.toUpperCase().indexOf(arr[i]);
			if (sLoc != -1) {
				int fLoc = sLoc + arr[i].length();
				webVer = userAgent.toUpperCase().substring(fLoc, fLoc+5);
				webVer = webVer.replaceAll("/", "").replaceAll(";", "").replaceAll("^", "").replaceAll(",", "").replaceAll("//.", "");
			}
		}
		return webVer;
	}
}
