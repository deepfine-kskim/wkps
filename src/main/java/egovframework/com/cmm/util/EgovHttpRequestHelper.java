package egovframework.com.cmm.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * @Class Name : EgovHttpRequestHelper.java
 * @Description : HTTP Request 정보 취득 Helper 클래스
 * @Modification Information
 *
 *    수정일         수정자         수정내용
 *    -------        -------     -------------------
 *    2014.09.11	표준프레임워크		최초생성
* @author Vincent Han
 * @since 2014.09.11
 * @version 3.5
 * @see <pre>
 * web.xml 상에 다음과 같은 Listener 등록 필요
 * &lt;listener&gt;
 *	  &lt;listener-class&gt;org.springframework.web.context.request.RequestContextListener&lt;/listener-class&gt;
 * &lt;/listener&gt;
 * </pre>
 */
public class EgovHttpRequestHelper {
	
	public static boolean isInHttpRequest() {
		try {
			getCurrentRequest();
		} catch (IllegalStateException ise) {
			return false;
		}
		
		return true;
	}
	
	public static HttpServletRequest getCurrentRequest() {
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		
		return sra.getRequest();
	}
	
	public static String getRequestIp() {
		HttpServletRequest request = getCurrentRequest();

		String ip = request.getHeader("X-Forwarded-For");

		if (StringUtils.isBlank(ip)) {
			ip = request.getHeader("Proxy-Client-IP");

		}
		if (StringUtils.isBlank(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");

		}
		if (StringUtils.isBlank(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");

		}
		if (StringUtils.isBlank(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");

		}

		if (StringUtils.isBlank(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		return ip;
	}
	
	public static String getRequestURI() {
		return getCurrentRequest().getRequestURI();
	}
	
	public static HttpSession getCurrentSession() {
		return getCurrentRequest().getSession();
	}
}
