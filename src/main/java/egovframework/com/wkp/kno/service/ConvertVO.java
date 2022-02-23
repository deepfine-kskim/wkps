package egovframework.com.wkp.kno.service;

import org.apache.poi.hwpf.converter.HtmlDocumentFacade;
import org.w3c.dom.Element;

import lombok.Data;

/**
 * 세션 VO 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
@Data
public class ConvertVO {
	
	private HtmlDocumentFacade htmlDocumentFacade;
	private Element page;
}
