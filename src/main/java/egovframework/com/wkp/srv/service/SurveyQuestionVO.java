/**
 * 개요
 * - 로그인정책에 대한 VO 클래스를 정의한다.
 *
 * 상세내용
 * - 로그인정책정보의 목록 항목을 관리한다.
 * @author lee.m.j
 * @version 1.0
 * @created 03-8-2009 오후 2:08:55
 *  <pre>
 * == 개정이력(Modification Information) ==
 *
 *   수정일       수정자           수정내용
 *  -------     --------    ---------------------------
 *  2009.8.3    이문준     최초 생성
 * </pre>
 */

package egovframework.com.wkp.srv.service;

import egovframework.com.utl.wed.enums.SurveyQuestionType;
import lombok.Data;

import java.util.List;

@Data
public class SurveyQuestionVO {

	private static final long serialVersionUID = 1L;

	private Long surveyNo;
	private Long surveyQusNo;
	private SurveyQuestionType qusTypeCd;
	private String cont;
	private String esntlYn;
	private Integer orderNo;

	private List<SurveyExampleVO> surveyExampleList;
	private SurveyAnswerVO answer;
}
