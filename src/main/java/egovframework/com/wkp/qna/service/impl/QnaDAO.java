package egovframework.com.wkp.qna.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.com.wkp.qna.service.FaqVO;
import egovframework.com.wkp.qna.service.AnswerRecommendVO;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.qna.service.AnswerVO;
import egovframework.com.wkp.qna.service.QuestionVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
 *
 * @author 공통서비스 개발팀 박지욱
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.26  서준식          EsntlId를 이용한 로그인 추가
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 * @since 2020.10.01
 */
@Repository("qnaDAO")
public class QnaDAO extends EgovComAbstractDAO {

    /**
     * 질문 리스트를 가져온다.
     * 2020.10.01
     *
     * @return
     * @
     */
    public List<QuestionVO> selectQuestionList(QuestionVO param) {
        return selectList("QnaDAO.selectQuestionList", param);
    }

    /**
     * 질문의 이전 글을 가져온다.
     * 2020.10.01
     *
     * @param param
     * @return
     * @
     */
    public QuestionVO selectQuestionPre(QuestionVO param) {
        return selectOne("QnaDAO.selectQuestionPre", param);
    }

    /**
     * 질문의 다음 글을 가져온다.
     * 2020.10.01
     *
     * @param param
     * @return
     * @
     */
    public QuestionVO selectQuestionNext(QuestionVO param) {
        return selectOne("QnaDAO.selectQuestionNext", param);
    }

    /**
     * 질문 리스트 총 숫자를 가져온다.
     * 2020.10.01
     *
     * @return
     * @
     */
    public int selectQuestionListCount(QuestionVO param) {
        return selectOne("QnaDAO.selectQuestionListCount", param);
    }

    /**
     * 질문 중 답할 수 있는 답변의 숫자를 가져온다.
     * 2020.10.01
     *
     * @return
     * @
     */
    public int selectQuestionWaitCount(String registerId) {

        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("registerId", registerId);
        return selectOne("QnaDAO.selectQuestionWaitCount", param);
    }

    /**
     * 질문을 등록한다.
     * 2020.10.02
     *
     * @param questionVO
     * @return
     * @
     */
    public int insertQuestion(QuestionVO questionVO) {
        return insert("QnaDAO.insertQuestion", questionVO);
    }

    /**
     * 질문 상세를 가져온다.
     * 2020.10.02
     *
     * @param questionVO
     * @return
     * @
     */
    public QuestionVO selectQuestionDetail(QuestionVO questionVO) {
        return selectOne("QnaDAO.selectQuestionDetail", questionVO);
    }

    /**
     * 2020.10.03
     * 질문을 수정한다.
     *
     * @param questionVO
     * @return
     * @
     */
    public int updateQuestion(QuestionVO questionVO) {
        return update("QnaDAO.updateQuestion", questionVO);
    }

    /**
     * 2020.10.04
     * 질문을 완료한다.
     * @param questionVO
     * @return
     * @
     */
    public int updateQuestionComplete(QuestionVO questionVO) {
        return update("QnaDAO.updateQuestionComplete", questionVO);
    }

    /**
     * 2020.10.03
     * 질문을 삭제한다.
     *
     * @param questionVO
     * @return
     * @
     */
    public int deleteQuestion(QuestionVO questionVO) {
        return update("QnaDAO.deleteQuestion", questionVO);
    }

    /**
     * 2020.10.03 QnA 답변 리스트를 반환한다.
     *
     * @param answerVO
     * @return List<AnswerVO>
     * @
     */
    public List<AnswerVO> selectAnswerList(AnswerVO answerVO) {
        return selectList("QnaDAO.selectAnswerList", answerVO);
    }

    /**
     * 2020.10.03 QnA 답변 리스트를 반환한다.
     *
     * @param answerVO
     * @return List<AnswerVO>
     * @
     */
    public AnswerVO selectAnswer(AnswerVO answerVO) {
        return selectOne("QnaDAO.selectAnswer", answerVO);
    }

    /**
     * 2020.10.03 QnA이 답변을 등록한다.
     *
     * @param answerVO
     * @return
     * @
     */
    public int insertAnswer(AnswerVO answerVO) {
        return insert("QnaDAO.insertAnswer", answerVO);
    }

    /**
     * 2020.10.04
     * QnA 채택된 답변 리스트를 가져온다.
     *
     * @param answerVO
     * @return
     * @
     */
    public List<AnswerVO> selectAnswerSelectionList(AnswerVO answerVO) {
        return selectList("QnaDAO.selectAnswerSelectionList", answerVO);
    }

    /**
     * 2020.10.04
     * QnA 답변을 채택한다
     *
     * @param answerVO
     * @return
     * @
     */
    public int updateAnswerSelection(AnswerVO answerVO) {
        return update("QnaDAO.updateAnswerSelection", answerVO);
    }

    /**
     * QnA 답변을 추천한다.
     * 2020.10.04
     *
     * @param answerRecommendVO
     * @return
     * @
     */
    public int insertAnswerRecommend(AnswerRecommendVO answerRecommendVO) {
        return insert("QnaDAO.insertAnswerRecommend", answerRecommendVO);
    }

    /**
     * QnA 답변을 추천숫자를 가져온다.
     * 2020.10.04
     *
     * @param answerRecommendVO
     * @return
     * @
     */
    public int selectAnswerRecommendCount(AnswerRecommendVO answerRecommendVO) {
        return selectOne("QnaDAO.selectAnswerRecommendCount", answerRecommendVO);
    }

    /**
     * 나의 QnA 채택된 답변 수를 가져온다.
     * 2020.10.04
     *
     * @param answerVO
     * @return
     * @
     */
    public int selectMyAnswerSelectionCount(AnswerVO answerVO) {
        return selectOne("QnaDAO.selectMyAnswerSelectionCount", answerVO);
    }

    /**
     * 나의 QnA 답변수를 가져온다.
     * 2020.10.04
     *
     * @param answerVO
     * @return
     * @
     */
    public int selectMyAnswerCount(AnswerVO answerVO) {
        return selectOne("QnaDAO.selectMyAnswerCount", answerVO);
    }

    /**
     * 나의 QnA 질문 수를 가져온다.
     * 2020.10.04
     *
     * @param answerVO
     * @return int
     * @
     */
    public int selectMyQuestionCount(AnswerVO answerVO) {
        return selectOne("QnaDAO.selectMyQuestionCount", answerVO);
    }

    /**
     * QnA 답변을 추천을 취소한다.
     * 2020.10.04
     *
     * @param answerRecommendVO
     * @return
     * @
     */
    public int deleteAnswerRecommend(AnswerRecommendVO answerRecommendVO) {
        return delete("QnaDAO.deleteAnswerRecommend", answerRecommendVO);
    }
    
	public List<FaqVO> selectFaqList(FaqVO faqVO) {
		return selectList("BbsDAO.selectFaqList", faqVO);
	}
	
    public int selectFaqListCount(FaqVO faqVO) {
        return selectOne("BbsDAO.selectFaqListCount", faqVO);
    }

	public FaqVO selectFaqDetail(FaqVO faqVO) {
		return selectOne("BbsDAO.selectFaqDetail", faqVO);
	}
	
    public FaqVO selectFaqPre(FaqVO faqVO) {
        return selectOne("BbsDAO.selectFaqPre", faqVO);
    }

    public FaqVO selectFaqNext(FaqVO faqVO) {
        return selectOne("BbsDAO.selectFaqNext", faqVO);
    }

	public int insertFaq(FaqVO faqVO) {
		return insert("BbsDAO.insertFaq", faqVO);
	}

	public int updateFaq(FaqVO faqVO) {
		return update("BbsDAO.updateFaq", faqVO);
	}

	public int deleteFaq(FaqVO faqVO) {
		return delete("BbsDAO.deleteFaq", faqVO);
	}

    public int updateQuestionSlctnYn(AnswerVO answerVO) {
        return update("QnaDAO.updateQuestionSlctnYn", answerVO);
    }
}
