package egovframework.com.wkp.qna.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.qna.service.FaqVO;

import java.util.List;

/**
 * QA의 리스트, 상세, 쓰기, 업데이트 등을 하는 서비
 *
 * @author QA서비스 개발팀
 * @version 1.0업
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2020.10.01  정창주		작
 *  </pre>
 * @since 2020.10.01
 */
public interface EgovQnaService {

    /**
     * 2020.10.01
     * QA 리스트 가져오는 공통 서비스
     *
     * @param questionVO
     * @return List<QusetionVO>
     */
    public ListWithPageNavigation<QuestionVO> selectQuestionList(QuestionVO questionVO);

    /**
     * 2020.10.01
     * QA
     *
     * @param param
     * @return
     */
    public int selectQuestionListCount(QuestionVO param);

    /**
     * 2020.10.02
     * QA 리스트 가져오는 공통 서비스
     *
     * @param registerId
     * @return
     */
    public int selectQuestionWaitCount(String registerId);

    /**
     * 2020.10.02
     * 질문을 등록한다.
     *
     * @param questionVO
     * @return int
     */
    public int insertQuestion(QuestionVO questionVO);

    /**
     * 2020.10.02
     * 질문상세를 가져온다.
     *
     * @param questionVO
     * @return QuestionVO
     */
    public QuestionVO selectQuestionDetail(QuestionVO questionVO);

    /**
     * 2020.10.03
     * 이전 질문상세를 가져온다.
     *
     * @param questionVO
     * @return QuestionVO
     */
    public QuestionVO selectQuestionPre(QuestionVO questionVO);

    /**
     * 2020.10.03
     * 다음 질문상세를 가져온다.
     *
     * @param questionVO
     * @return QuestionVO
     */
    public QuestionVO selectQuestionNext(QuestionVO questionVO);

    /**
     * 2020.10.03
     * 질문 수정한다.
     *
     * @param questionVO
     * @return int
     */
    public int updateQuestion(QuestionVO questionVO);

    /**
     * 2020.10.03 질문을 삭제한다.
     *
     * @param questionVO
     * @return int
     */
    public int deleteQuestion(QuestionVO questionVO);

    /**
     * 2020.10.03
     * 답변 리스트를 가져온다.
     *
     * @param answerVO
     * @return List<AnswerVO>
     */
    public List<AnswerVO> selectAnswerList(AnswerVO answerVO);

    /**
     * 2020.10.03
     * 답변을 가져온다.
     *
     * @param answerVO
     * @return List<AnswerVO>
     */
    public AnswerVO selectAnswer(AnswerVO answerVO);

    /**
     * 2020.10.03
     * 답변을 등록한다.
     *
     * @param answerVO
     * @return int
     */
    public int insertAnswer(AnswerVO answerVO);

    /**
     * 2020.10.03
     * QnA 답변을 채택한다.
     *
     * @param answerVO
     * @return int
     */
    public int updateAnswerSelection(AnswerVO answerVO);

    /**
     * 2020.10.04
     * QnA 답변에 추천을 토글한다.
     *
     * @param answerRecommendVO
     * @return AnswerRecommendVO
     */
    public AnswerRecommendVO toggleAnswerRecommend(AnswerRecommendVO answerRecommendVO);

    /**
     * 2020.10.04
     * QnA 통계를 전달한다.
     *
     * @param registerId
     * @return RankDTO
     */
    public RankDTO selectQuestionRank(String registerId);
    
    public int selectMyAnswerCount(AnswerVO answerVO);
    
    public int selectMyQuestionCount(AnswerVO answerVO);
    
    public ListWithPageNavigation<FaqVO> selectFaqList(FaqVO faqVO);
    
    public int selectFaqListCount(FaqVO faqVO);
    
    public FaqVO selectFaqDetail(FaqVO faqVO);

    public FaqVO selectFaqPre(FaqVO faqVO);

    public FaqVO selectFaqNext(FaqVO faqVO);
    
    public int insertFaq(FaqVO faqVO);
    
    public int updateFaq(FaqVO faqVO);
     
    public int deleteFaq(FaqVO faqVO);

}
