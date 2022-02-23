package egovframework.com.cmm.util;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.com.wkp.usr.service.UserVO;

/**
 * EgovXssChecker 클래스
 *
 * @author 장동한
 * @since 2016.10.27
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일        수정자           수정내용
 *  -------      -------------  ----------------------
 *   2016.10.17  장동한           최초 생성
 *   2017.03.03     조성원 	  시큐어코딩(ES)-오류 메시지를 통한 정보노출[CWE-209]
 * </pre>
 */


public class EgovXssChecker {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovXssChecker.class);
	
    /**
	 * 사용자에 대한 크로스사이트스크립트(Xss) 확인한다.
	 * 수정, 상세조회, 삭제시 사용
	 * @param uniqId Stirng 
	 * @return boolean
	 * @exception IllegalArgumentException
	 */
	public static boolean checkerUserXss(HttpServletRequest request, String sUniqId) {
		
		boolean bLog = false;
		
		try {
			//@ 공통모듈을 이용한 권한체크
			UserVO loginVO = (UserVO)EgovUserDetailsHelper.getAuthenticatedUser();

	    	if(bLog){
	    		LOGGER.debug("@Step1. XSS Check uniqId  : {}", sUniqId);
	    		LOGGER.debug("Step2. XSS Session uniqId  : {}", loginVO.getSid());
	    		LOGGER.debug("Step4. XSS Session getAuthorities  : {}", EgovUserDetailsHelper.getAuthorities());
	    	}
			
		//2017.03.03 	조성원 	시큐어코딩(ES)-오류 메시지를 통한 정보노출[CWE-209]	
		} catch(IllegalArgumentException e) {
			LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return true;
	}


}
