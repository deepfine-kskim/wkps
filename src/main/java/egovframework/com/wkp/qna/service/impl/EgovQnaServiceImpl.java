package egovframework.com.wkp.qna.service.impl;

import java.util.List;
import javax.annotation.Resource;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.qna.service.FaqVO;
import egovframework.com.wkp.qna.service.*;
import egovframework.mgt.wkp.log.service.EgovLogService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
 *
 * @author 공통서비스 개발팀 박지욱
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  ----    ---    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.26  서준식          EsntlId를 이용한 로그인 추가
 *  2014.12.08	이기하			암호화방식 변경(EgovFileScrty.encryptPassword)
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 * @since 2009.03.06
 */
@Service("qnaService")
public class EgovQnaServiceImpl extends EgovAbstractServiceImpl implements EgovQnaService {
	
    private static final Logger LOGGER = LoggerFactory.getLogger(EgovQnaServiceImpl.class);

    @Resource(name = "qnaDAO")
    private QnaDAO qnaDAO;

    @Resource(name = "logService")
    EgovLogService egovLogService;

    /**
     * 2020.10.01
     * QA 리스트 가져오는 공통 서비스
     *
     * @param questionVO
     * @return List<QusetionVO>
     * @
     */
    @Override
    public ListWithPageNavigation<QuestionVO> selectQuestionList(QuestionVO questionVO) {

        ListWithPageNavigation<QuestionVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectQuestionListCount(questionVO), questionVO.getPage(), null, null);
        questionVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        questionVO.setItemOffset(pageNavigation.getItemCountPerPage() * (questionVO.getPage() - 1));
        result.setList(qnaDAO.selectQuestionList(questionVO));
        result.setPageNavigation(pageNavigation);

        egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.QNA, null);

        return result;
    }

    /**
     * 2020.10.03
     *
     * @param param
     * @return
     * @
     */
    @Override
    public int selectQuestionListCount(QuestionVO param) {
        return qnaDAO.selectQuestionListCount(param);
    }

    /**
     * 2020.10.03
     *
     * @param registerId
     * @return
     * @
     */
    @Override
    public int selectQuestionWaitCount(String registerId) {
        return qnaDAO.selectQuestionWaitCount(registerId);
    }


    /**
     * 2020.10.03
     *
     * @param questionVO
     * @return
     * @
     */
    @Override
    public int insertQuestion(QuestionVO questionVO) {
        egovLogService.insert(LogType.INSERT, LogSubjectType.QNA, questionVO);
        return qnaDAO.insertQuestion(questionVO);
    }

    /**
     * 2020.10.03
     *
     * @param questionVO
     * @return
     * @
     */
    @Override
    public QuestionVO selectQuestionDetail(QuestionVO questionVO) {
        QuestionVO result = qnaDAO.selectQuestionDetail(questionVO);

        if (result != null) {
            AnswerVO param = new AnswerVO();
            param.setQuestionNo(questionVO.getQuestionNo());
            param.setRegisterId(questionVO.getRegisterId());
            param.setRegisterName(questionVO.getRegisterName());
            result.setAnswerList(selectAnswerList(param));
        }

        egovLogService.insert(LogType.SELECT_DETAIL, LogSubjectType.QNA, result);

        return result;
    }

    /**
     * 2020.10.03
     *
     * @param questionVO
     * @return
     * @
     */
    @Override
    public QuestionVO selectQuestionPre(QuestionVO questionVO) {
        return qnaDAO.selectQuestionPre(questionVO);
    }

    /**
     * @param questionVO
     * @return
     * @
     */
    @Override
    public QuestionVO selectQuestionNext(QuestionVO questionVO) {
        return qnaDAO.selectQuestionNext(questionVO);
    }

    /**
     * 2020.10.02
     * 질문을 수정한다.
     *
     * @param questionVO
     * @return
     * @
     */
    @Override
    public int updateQuestion(QuestionVO questionVO) {

        egovLogService.insert(LogType.UPDATE, LogSubjectType.QNA, questionVO);
        return qnaDAO.updateQuestion(questionVO);
    }

    /**
     * 2020.10.02
     * 질문을 삭제한다.
     *
     * @param questionVO
     * @return
     * @
     */
    @Override
    public int deleteQuestion(QuestionVO questionVO) {
        egovLogService.insert(LogType.DELETE, LogSubjectType.QNA, questionVO);
        return qnaDAO.deleteQuestion(questionVO);
    }

    /**
     * 2020.10.02
     *
     * @param answerVO
     * @return
     * @
     */
    @Override
    public List<AnswerVO> selectAnswerList(AnswerVO answerVO) {
        return qnaDAO.selectAnswerList(answerVO);
    }

    @Override
    public AnswerVO selectAnswer(AnswerVO answerVO) {
        return qnaDAO.selectAnswer(answerVO);
    }

    /**
     * 2020.10.02
     *
     * @param answerVO
     * @return
     * @
     */
    @Override
    public int insertAnswer(AnswerVO answerVO) {
        egovLogService.insert(LogType.INSERT_ANSWER, LogSubjectType.QNA, answerVO);
        qnaDAO.updateQuestionSlctnYn(answerVO);
        return qnaDAO.insertAnswer(answerVO);
    }

    /**
     * 2020.10.03
     * QnA 답변을 채택한다.
     *
     * @param answerVO
     * @return
     * @
     */
    @Override
    public int updateAnswerSelection(AnswerVO answerVO) {
        List<AnswerVO> answerList = qnaDAO.selectAnswerSelectionList(answerVO);
        int result = 0;

        //답변한 데이터가 없어야 업데이트를 한다.
        if (answerList == null || answerList.size() < 1) {
            egovLogService.insert(LogType.UPDATE_ANSWER_CHOICE, LogSubjectType.QNA, answerVO);
            result = qnaDAO.updateAnswerSelection(answerVO);
        }

        //답변채택이 성공하면 질문완성업데이트
        if(result > 0) {
            QuestionVO param = new QuestionVO();
            param.setQuestionNo(answerVO.getQuestionNo());
            param.setUpdaterId(answerVO.getUpdaterId());
            param.setRegisterId(answerVO.getRegisterId());
            qnaDAO.updateQuestionComplete(param);
        }

        return result;
    }

    /**
     * 2020.10.04
     * QnA 답변에 추천을 토글한다.
     *
     * @param answerRecommendVO
     * @return AnswerRecommendVO
     * @
     */
    @Override
    public AnswerRecommendVO toggleAnswerRecommend(AnswerRecommendVO answerRecommendVO) {
        AnswerRecommendVO result = new AnswerRecommendVO();

        try {
            if (qnaDAO.insertAnswerRecommend(answerRecommendVO) > 0) {
                result.setMine(true);
            }
        } catch (Exception e) {
            qnaDAO.deleteAnswerRecommend(answerRecommendVO);
        }
        result.setRecommendCount(qnaDAO.selectAnswerRecommendCount(answerRecommendVO));

        egovLogService.insert(result.isMine() ? LogType.INSERT_ANSWER_RECOMMENDATION:LogType.DELETE_ANSWER_RECOMMENDATION, LogSubjectType.QNA, answerRecommendVO);

        return result;
    }

    /**
     * 2020.10.04
     * QnA 통계를 전달한다.
     *
     * @param registerId
     * @return RankDTO
     * @
     */
    @Override
    public RankDTO selectQuestionRank(String registerId) {
        RankDTO result = new RankDTO();
        try {
            AnswerVO param = new AnswerVO();
            param.setRegisterId(registerId);
            result.setMyAnswerCount(qnaDAO.selectMyAnswerCount(param));
            result.setMyAnswerSelectionCount(qnaDAO.selectMyAnswerSelectionCount(param));
            result.setMyQuestionCount(qnaDAO.selectMyQuestionCount(param));
            result.setAnswerSelectionPercent((double)result.getMyAnswerSelectionCount() / (double)result.getMyAnswerCount() * 100);
            if(Double.isNaN(result.getAnswerSelectionPercent()) || Double.isInfinite(result.getAnswerSelectionPercent())) {
                result.setAnswerSelectionPercent(0);
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return result;
    }

	@Override
	public int selectMyAnswerCount(AnswerVO answerVO) {
		return qnaDAO.selectMyAnswerCount(answerVO);
	}

	@Override
	public int selectMyQuestionCount(AnswerVO answerVO) {
		return qnaDAO.selectMyQuestionCount(answerVO);
	}
	

	@Override
	public ListWithPageNavigation<FaqVO> selectFaqList(FaqVO faqVO) {
        
		ListWithPageNavigation<FaqVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectFaqListCount(faqVO), faqVO.getPage(), null, null);
        faqVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        faqVO.setItemOffset(pageNavigation.getItemCountPerPage() * (faqVO.getPage() - 1));
        result.setList(qnaDAO.selectFaqList(faqVO));
        result.setPageNavigation(pageNavigation);

		egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.FAQ, null);
        return result;
	}
	
	@Override
	public int selectFaqListCount(FaqVO faqVO) {
        return qnaDAO.selectFaqListCount(faqVO);
	}

	@Override
	public FaqVO selectFaqDetail(FaqVO faqVO) {
		FaqVO vo = qnaDAO.selectFaqDetail(faqVO);
		egovLogService.insert(LogType.SELECT_DETAIL, LogSubjectType.FAQ, vo);

		return vo;
	}
	
	@Override
	public FaqVO selectFaqPre(FaqVO faqVO) {
        return qnaDAO.selectFaqPre(faqVO);
	}

	@Override
	public FaqVO selectFaqNext(FaqVO faqVO) {
        return qnaDAO.selectFaqNext(faqVO);
	}

	@Override
	public int insertFaq(FaqVO faqVO) {
		egovLogService.insert(LogType.INSERT, LogSubjectType.FAQ, faqVO);

		return qnaDAO.insertFaq(faqVO);
	}

	@Override
	public int updateFaq(FaqVO faqVO) {
		egovLogService.insert(LogType.UPDATE, LogSubjectType.FAQ,faqVO);
		return qnaDAO.updateFaq(faqVO);
	}

	@Override
	public int deleteFaq(FaqVO faqVO) {
		egovLogService.insert(LogType.DELETE, LogSubjectType.FAQ, faqVO.getFaqNo());
		return qnaDAO.deleteFaq(faqVO);
	}

}
