package egovframework.com.wkp.srv.service.impl;

import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.qna.service.impl.EgovQnaServiceImpl;
import egovframework.com.wkp.srv.service.*;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
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
 *  2014.12.08	이기하			암호화방식 변경(EgovFileScrty.encryptPassword)
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 * @since 2009.03.06
 */
@Service("surveyService")
public class EgovSurveyServiceImpl extends EgovAbstractServiceImpl implements EgovSurveyService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovQnaServiceImpl.class);

    @Resource(name = "surveyDAO")
    private SurveyDAO surveyDAO;

    @Resource(name = "logService")
    EgovLogService egovLogService;

    /**
     * 2020.10.07
     * 설문의 리스트를 가져온다.
     *
     * @param surveyVO
     * @return ListWithPageNavigation<SurveyVO>
     * @
     */
    @Override
    public ListWithPageNavigation<SurveyVO> selectSurveyList(SurveyVO surveyVO) {

        ListWithPageNavigation<SurveyVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation =
                new PageNavigation(selectSurveyListCount(surveyVO), surveyVO.getPage(), null, null);
        surveyVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        surveyVO.setItemOffset(pageNavigation.getItemCountPerPage() * (surveyVO.getPage() - 1));
        result.setList(surveyDAO.selectSurveyList(surveyVO));
        result.setPageNavigation(pageNavigation);

        egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.SURVEY, null);

        return result;
    }

    /**
     * 내가 만든 설문조사 리스트를 가져온다.
     * 2020.10.10
     *
     * @param surveyVO
     * @return List<SurveyVO>
     * @
     */
    @Override
    public List<SurveyVO> selectSurveyListByMine(SurveyVO surveyVO) {
        return surveyDAO.selectSurveyListByMine(surveyVO);
    }
    
    /**
     * 2020.10.07
     * 설문의 총 리스트 개수를 가져온다.
     *
     * @param surveyVO
     * @return int
     * @
     */
    @Override
    public int selectSurveyListCountByMine(SurveyVO surveyVO) {
        return surveyDAO.selectSurveyListCountByMine(surveyVO);
    }

    /**
     * 2020.10.07
     * 설문의 총 리스트 개수를 가져온다.
     *
     * @param surveyVO
     * @return int
     * @
     */
    @Override
    public int selectSurveyListCount(SurveyVO surveyVO) {
        return surveyDAO.selectSurveyListCount(surveyVO);
    }

    @Override
    public int selectSurveyJoinCount(SurveyVO surveyVO) {
        return surveyDAO.selectSurveyJoinCount(surveyVO);
    }

    /**
     * 단일 설문조사 내용을 가져온다.
     *
     * @param surveyVO
     * @return
     * @
     */
    @Override
    public SurveyVO selectDetail(SurveyVO surveyVO) {
        SurveyVO result = surveyDAO.selectDetail(surveyVO);
        if (result != null) {
            SurveyQuestionVO param = new SurveyQuestionVO();
            param.setSurveyNo(surveyVO.getSurveyNo());
            result.setQuestionList(selectQuestionList(param));
        }

        egovLogService.insert(LogType.SELECT_DETAIL, LogSubjectType.SURVEY, result);

        return result;
    }

    @Override
    public SurveyVO insert(SurveyVO surveyVO) {

        if (surveyDAO.insert(surveyVO) > 0) {

            egovLogService.insert(LogType.INSERT, LogSubjectType.SURVEY, surveyVO);

            if (surveyVO.getQuestionList() != null) {
                for (SurveyQuestionVO surveyQuestionVO : surveyVO.getQuestionList()) {
                    surveyQuestionVO.setSurveyNo(surveyVO.getSurveyNo());
                    insertQuestion(surveyQuestionVO);
                }
            }
        }

        return surveyVO;
    }

    @Override
    public boolean update(SurveyVO surveyVO) {
        boolean result = false;
        if(surveyDAO.updateSurvey(surveyVO) > 0 ) {

            egovLogService.insert(LogType.UPDATE, LogSubjectType.SURVEY, surveyVO);

            //관련된 퀴즈와 예제, 답변을 다 지운다. 다 맞출 수 없어서 초기화를 한다.
            deleteQuestion(surveyVO.getSurveyNo());

            if (surveyVO.getQuestionList() != null) {
                for (SurveyQuestionVO surveyQuestionVO : surveyVO.getQuestionList()) {
                    surveyQuestionVO.setSurveyNo(surveyVO.getSurveyNo());
                    insertQuestion(surveyQuestionVO);
                }
            }
            result = true;
        }
        return result;
    }

    @Override
    public int delete(SurveyVO surveyVO) {
        egovLogService.insert(LogType.DELETE, LogSubjectType.SURVEY, surveyVO);
        return surveyDAO.delete(surveyVO);
    }
    
    @Override
    public boolean updateSurveyRelease(SurveyVO surveyVO) {
        boolean result = false;
        try {
            result = surveyDAO.updateSurveyRelease(surveyVO) > 0;
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return result;
    }

    @Override
    public void deleteQuestion(Long surveyNo) {
        surveyDAO.deleteQuestion(surveyNo);
        surveyDAO.deleteExample(surveyNo);
        surveyDAO.deleteAnswer(surveyNo);
    }

    @Override
    public SurveyQuestionVO insertQuestion(SurveyQuestionVO surveyQuestionVO) {

        if (surveyDAO.insertQuestion(surveyQuestionVO) > 0) {
            if (surveyQuestionVO.getSurveyExampleList() != null && surveyQuestionVO.getSurveyExampleList().size() > 0) {
                for (SurveyExampleVO ex : surveyQuestionVO.getSurveyExampleList()) {
                    ex.setSurveyQusNo(surveyQuestionVO.getSurveyQusNo());
                    ex.setSurveyNo(surveyQuestionVO.getSurveyNo());
                    insertExample(ex);
                }
            }
        }
        return surveyQuestionVO;
    }

    @Override
    public SurveyExampleVO insertExample(SurveyExampleVO surveyExampleVO) {
        surveyDAO.insertExample(surveyExampleVO);
        return surveyExampleVO;
    }

    @Override
    public List<SurveyQuestionVO> selectQuestionList(SurveyQuestionVO surveyQuestionVO) {
        List<SurveyQuestionVO> questions = surveyDAO.selectQuestionList(surveyQuestionVO);
        if (questions != null) {
            for (SurveyQuestionVO q : questions) {
                SurveyExampleVO vo = new SurveyExampleVO();
                vo.setSurveyQusNo(q.getSurveyQusNo());
                q.setSurveyExampleList(selectExampleList(vo));
            }
        }
        return questions;
    }

    @Override
    public List<SurveyExampleVO> selectExampleList(SurveyExampleVO surveyExampleVO) {
        List<SurveyExampleVO> examples = surveyDAO.selectExampleList(surveyExampleVO);
        for (SurveyExampleVO vo : examples) {
            vo.setFileType(EgovFileUploadUtil.getFileType(vo.getFileExtsn()));
        }

        return examples;
    }

    @Override
    public boolean updateSurveyDoingState() {
        boolean result = false;
        try {
            result = surveyDAO.updateSurveyDoingState() > 0;
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return result;
    }

    @Override
    public int insertAnswer(SurveyAnswerVO surveyAnswerVO) {
        egovLogService.insert(LogType.INSERT_ANSWER, LogSubjectType.SURVEY, surveyAnswerVO);
        return surveyDAO.insertAnswer(surveyAnswerVO);
    }

    @Override
    public boolean selectAnswerJoinCount(Long surveyNo, String registerId) {
        SurveyAnswerVO surveyAnswerVO = new SurveyAnswerVO();
        surveyAnswerVO.setSurveyNo(surveyNo);
        surveyAnswerVO.setRegisterId(registerId);
        return surveyDAO.selectAnswerJoinCount(surveyAnswerVO) > 0;
    }

    @Override
    public List<SurveyStatisticsDTO> selectResultList(Long surveyNo, String registerId) {
        SurveyStatisticsDTO vo = new SurveyStatisticsDTO();
        vo.setSurveyNo(surveyNo);
        vo.setRegisterId(registerId);

        egovLogService.insert(LogType.SELECT_RESULT, LogSubjectType.SURVEY, vo);

        return surveyDAO.selectResultList(vo);
    }

    @Override
    public int updateSurveyEndDate(SurveyVO vo) {
        return surveyDAO.updateSurveyEndDate(vo);
    }

    @Override
    public List<SurveyExcelDTO> selectSurveyExcelList(Long surveyNo)  {
        SurveyExcelDTO surveyExcelDTO = new SurveyExcelDTO();
        surveyExcelDTO.setSurveyNo(surveyNo);

        egovLogService.insert(LogType.DOWNLOAD_EXCEL, LogSubjectType.SURVEY, surveyExcelDTO);

        return surveyDAO.selectSurveyExcelList(surveyExcelDTO);
    }

    @Override
    public List<SurveyAnswerVO> selectAnswerUser(Long surveyExampleNo)  {
        return surveyDAO.selectAnswerUser(surveyExampleNo);
    }

    @Override
    public boolean updateSurveyState(SurveyVO surveyVO) {
        return surveyDAO.updateSurveyState(surveyVO) > 0;
    }
    
	@Override
	public List<SurveyQuestionVO> selectQuestionNumberList(SurveyQuestionVO surveyQuestionVO) {
		return surveyDAO.selectQuestionNumberList(surveyQuestionVO);
	}
	
    @Override
    public List<SurveyAnswerVO> selectAnswerUserList(SurveyAnswerVO surveyAnswerVO)  {
        return surveyDAO.selectAnswerUserList(surveyAnswerVO);
    }

	@Override
	public List<SurveyAnswerVO> selectAnswer(SurveyAnswerVO surveyAnswerVO) {
		return surveyDAO.selectAnswer(surveyAnswerVO);
	}

}
