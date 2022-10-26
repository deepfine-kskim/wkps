package egovframework.com.wkp.srv.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.srv.service.*;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
@Repository("surveyDAO")
public class SurveyDAO extends EgovComAbstractDAO {

	/**
	 * 2020.10.07
	 * 설문의 리스트를 가져온다.
	 * @param surveyVO
	 * @return
	 * @
	 */
	public List<SurveyVO> selectSurveyList(SurveyVO surveyVO) {
		return selectList("SurveyDAO.selectSurveyList", surveyVO);
	}

	public List<SurveyVO> selectSurveyManageList(SurveyVO surveyVO) {
		return selectList("SurveyDAO.selectSurveyManageList", surveyVO);
	}

	/**
	 * 2020.10.07
	 * 설문의 리스트를 가져온다.
	 * @param surveyVO
	 * @return
	 * @
	 */
	public List<SurveyVO> selectSurveyListByMine(SurveyVO surveyVO) {
		return selectList("SurveyDAO.selectSurveyListByMine", surveyVO);
	}
	

	/**
	 * 2020.10.07
	 * 설문의 리스트의 총 개수를 가져온다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int selectSurveyListCountByMine(SurveyVO surveyVO) {
		return selectOne("SurveyDAO.selectSurveyListCountByMine", surveyVO);
	}

	/**
	 * 2020.10.07
	 * 설문의 리스트의 총 개수를 가져온다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int selectSurveyListCount(SurveyVO surveyVO) {
		return selectOne("SurveyDAO.selectSurveyListCount", surveyVO);
	}

	public int selectSurveyManageListCount(SurveyVO surveyVO) {
		return selectOne("SurveyDAO.selectSurveyManageListCount", surveyVO);
	}

	/**
	 * 2020.10.07
	 * 설문의 참여한 사람의 총 개수를 가져온다.
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int selectSurveyJoinCount(SurveyVO surveyVO) {
		return selectOne("SurveyDAO.selectSurveyJoinCount", surveyVO);
	}

	/**
	 * 2020.10.07
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int insert(SurveyVO surveyVO) {
		return insert("SurveyDAO.insert", surveyVO);
	}

/**
	 * 2020.10.30
	 * @param surveyVO
	 * @return int
	 * @
	 */
	public int updateSurveyState(SurveyVO surveyVO) {
		return insert("SurveyDAO.updateSurveyState", surveyVO);
	}

	/**
	 * 설문조사 상세
	 * @param surveyVO
	 * @return
	 * @
	 */
	public SurveyVO selectDetail(SurveyVO surveyVO) {
		return selectOne("SurveyDAO.selectDetail", surveyVO);
	}

	/**
	 * 설문조사 상세
	 * @param surveyVO
	 * @return
	 * @
	 */
	public List<SurveyVO> selectMyAnswer(SurveyVO surveyVO) {
		return selectList("SurveyDAO.selectMyAnswer", surveyVO);
	}

	/**
	 * 설문조사 대답 참여자 수
	 * @param surveyAnswerVO
	 * @return
	 * @
	 */
	public int selectAnswerJoinCount(SurveyAnswerVO surveyAnswerVO) {
		return selectOne("SurveyDAO.selectAnswerJoinCount", surveyAnswerVO);
	}

	/**
	 * 설문조사 삭제하기
	 * @param surveyVO
	 * @return
	 * @
	 */
	public int delete(SurveyVO surveyVO) {
		return update("SurveyDAO.delete", surveyVO);
	}

	/**
	 * 내설문조사 삭제하기
	 * @param surveyanswerVO
	 * @return
	 * @
	 */
	public int delete(SurveyAnswerVO surveyanswerVO) {
		return update("SurveyDAO.deleteMyAnswer", surveyanswerVO);
	}
	
	/**
	 * 설문조사 공개변경
	 * @param surveyVO
	 * @return
	 * @
	 */
	public int updateSurveyRelease(SurveyVO surveyVO) {
		return update("SurveyDAO.updateSurveyRelease", surveyVO);
	}

	/**
	 * 설문조사 수정하기
	 * @param surveyVO
	 * @return
	 * @
	 */
	public int updateSurvey(SurveyVO surveyVO) {
		return update("SurveyDAO.updateSurvey", surveyVO);
	}

	/**
	 * 설문조사 질문 등록하기
	 * @param surveyQuestionVO
	 * @return
	 * @
	 */
	public int insertQuestion(SurveyQuestionVO surveyQuestionVO) {
		return insert("SurveyDAO.insertQuestion", surveyQuestionVO);
	}

	public int deleteQuestion(Long surveyNo) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("surveyNo", surveyNo);
		return delete("SurveyDAO.deleteQuestion", param);
	}

	public int deleteExample(Long surveyNo) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("surveyNo", surveyNo);
		return delete("SurveyDAO.deleteExample", param);
	}

	public int deleteAnswer(Long surveyNo) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("surveyNo", surveyNo);
		return delete("SurveyDAO.deleteAnswer", param);
	}

	public int insertExample(SurveyExampleVO surveyExampleVO) {
		return insert("SurveyDAO.insertExample", surveyExampleVO);
	}

	public List<SurveyQuestionVO> selectQuestionList(SurveyQuestionVO surveyQuestionVO) {
		return selectList("SurveyDAO.selectQuestionList", surveyQuestionVO);
	}

	public List<SurveyExampleVO> selectExampleList(SurveyExampleVO surveyExampleVO) {
		return selectList("SurveyDAO.selectExampleList", surveyExampleVO);
	}

	public List<SurveyStatisticsDTO> selectResultList(SurveyStatisticsDTO surveyStatisticsDTO) {
		return selectList("SurveyDAO.selectResultList", surveyStatisticsDTO);
	}

	public int updateSurveyDoingState() {
		return update("SurveyDAO.updateSurveyDoingState");
	}

	public int updateSurveyEndDate(SurveyVO vo) {
		return update("SurveyDAO.updateSurveyEndDate", vo) ;
	}

	public int insertAnswer(SurveyAnswerVO surveyAnswerVO) {
		return insert("SurveyDAO.insertAnswer", surveyAnswerVO);
	}

	public List<SurveyExcelDTO> selectSurveyExcelList(SurveyExcelDTO surveyExcelDTO) {
		return selectList("SurveyDAO.selectSurveyExcelList", surveyExcelDTO);
	}

	public List<SurveyAnswerVO> selectAnswerUser(Long surveyExampleNo) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("surveyExampleNo", surveyExampleNo);
		return selectList("SurveyDAO.selectAnswerUser", param);
	}
	
	public List<SurveyQuestionVO> selectQuestionNumberList(SurveyQuestionVO surveyQuestionVO) {
		return selectList("SurveyDAO.selectQuestionNumberList", surveyQuestionVO);
	}

    public List<SurveyAnswerVO> selectAnswerUserList(SurveyAnswerVO surveyAnswerVO)  {
        return selectList("SurveyDAO.selectAnswerUserList", surveyAnswerVO);
    }
    
	public List<SurveyAnswerVO> selectAnswer(SurveyAnswerVO surveyAnswerVO) {
		return selectList("SurveyDAO.selectAnswer", surveyAnswerVO);
	}

}
