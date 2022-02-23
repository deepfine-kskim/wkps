package egovframework.com.kf.service;

import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;

/**
 * 게시판 검색하기 위한 서비스 인터페이스
 * 
 * @author seunghee.kim
 * @since 2016.06.30
 */
public interface SrhSurveyService {
	
	/**
	 * 게시판정보를 검색한다.
	 * @param paramVO
	 * @return
	 */
	public RestResultVO SurveySearch(ParameterVO paramVO) throws Exception;
	
}
