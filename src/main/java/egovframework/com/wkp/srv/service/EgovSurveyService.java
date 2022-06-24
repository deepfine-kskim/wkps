package egovframework.com.wkp.srv.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;

import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
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
 *  2011.08.26  서준식          EsntlId를 이용한 로그인 추가
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
public interface EgovSurveyService {

	/**
     * 2020.10.07
	 * 설문조사 리스트를 가져온다.
	 * @param surveyVO
	 * @return ListWithPageNavigation<SurveyVO>
	 * @
	 */
	public ListWithPageNavigation<SurveyVO> selectSurveyList(SurveyVO surveyVO);
	public ListWithPageNavigation<SurveyVO> selectSurveyManageList(SurveyVO surveyVO);

	/**
	 * 2020.10.10
	 * 내가 작성한 설문조사 리스트를 가져온다.
	 * @param surveyVO
	 * @return ListWithPageNavigation<SurveyVO>
	 * @
	 */
	public List<SurveyVO> selectSurveyListByMine(SurveyVO surveyVO);

	/**
	 * 2020.10.07
	 * 설문조사 리스트의 카운트를 가져온다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int selectSurveyListCountByMine(SurveyVO surveyVO);
	
	/**
	 * 2020.10.07
	 * 설문조사 리스트의 카운트를 가져온다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int selectSurveyListCount(SurveyVO surveyVO);
	public int selectSurveyManageListCount(SurveyVO surveyVO);

	/**
	 * 2020.10.11
	 * 설문에 참여한 사람의 카운트를 가져온다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int selectSurveyJoinCount(SurveyVO surveyVO);

	/**
	 * 2020.10.07
	 * 설문조사의 상세내용을 가져온다.
	 * @param surveyVO
	 * @return SurveyVO
	 * @
	 */
	public SurveyVO selectDetail(SurveyVO surveyVO);

	/**
	 *  2020.10.07
	 * 설문조사를 등록한다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public SurveyVO insert(SurveyVO surveyVO);

	/**
	 * 2020.10.07
	 * 설문을 수정한다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public boolean update(SurveyVO surveyVO);

	/**
	 * 설문에 관련된 모든 질문과 예제를 지운다
	 * @param surveyNo
	 * @return
	 * @
	 */
	public void deleteQuestion(Long surveyNo);

	/**
	 * 2020.10.07 설문을 삭제한다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int delete(SurveyVO surveyVO);
	
	/**
	 * 설문 공개여부를 변경한다.
	 * @param surveyVO
	 * @return boolean
	 */
	public boolean updateSurveyRelease(SurveyVO surveyVO);

	/**
	 *
	 * @param surveyQuestionVO
	 * @return
	 * @
	 */
	public SurveyQuestionVO insertQuestion(SurveyQuestionVO surveyQuestionVO);

	/**
	 *
	 * @param surveyExampleVO
	 * @return
	 * @
	 */
	public SurveyExampleVO insertExample(SurveyExampleVO surveyExampleVO);

	/**
	 *
	 * @param surveyQuestionVO
	 * @return
	 * @
	 */
	public List<SurveyQuestionVO> selectQuestionList(SurveyQuestionVO surveyQuestionVO);

	/**
	 *
	 * @param surveyExampleVO
	 * @return
	 * @
	 */
	public List<SurveyExampleVO> selectExampleList(SurveyExampleVO surveyExampleVO);

	/**
	 * 설문 상태 중 진행중인 글들 날짜를 보고 업데이트
	 * @return
	 */
	public boolean updateSurveyDoingState();

	/**
	 * 설문 답변 등록하기
	 * @param surveyAnswerVO
	 * @return
	 */
	public int insertAnswer(SurveyAnswerVO surveyAnswerVO);

	/**
	 * 2020.10.07
	 * 설문조사의 참여정보를 가져온다.
	 * @param surveyNo
	 * @return SurveyVO
	 * @
	 */
	public boolean selectAnswerJoinCount(Long surveyNo, String registerId);

	/**
	 * 설문조사 결과페이지 통계 데이터
	 * @param surveyNo
	 * @param registerId
	 * @return
	 * @
	 */
	public List<SurveyStatisticsDTO> selectResultList(Long surveyNo, String registerId);

	/**
	 * 설문조사 종료 기간 변경
	 * @param vo
	 * @return
	 */
    public int updateSurveyEndDate(SurveyVO vo) ;

	/**
	 * 설문조사 엑셀 다운로드 데이터
	 * @param surveyNo
	 * @return
	 */
	public List<SurveyExcelDTO> selectSurveyExcelList(Long surveyNo);
	
	/**
	 * 설문조사 응답자 리스트
	 * @param surveyExampleNo
	 * @return
	 */
	public List<SurveyAnswerVO> selectAnswerUser(Long surveyExampleNo);
	
	/**
	 * 설문조사 상태 변경
	 * @param surveyVO
	 * @return
	 */
	public boolean updateSurveyState(SurveyVO surveyVO);
	
	public List<SurveyQuestionVO> selectQuestionNumberList(SurveyQuestionVO surveyQuestionVO);
	
	public List<SurveyAnswerVO> selectAnswerUserList(SurveyAnswerVO surveyAnswerVO);
	
	public List<SurveyAnswerVO> selectAnswer(SurveyAnswerVO surveyAnswerVO);
}
