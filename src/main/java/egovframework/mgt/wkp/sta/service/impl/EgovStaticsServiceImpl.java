package egovframework.mgt.wkp.sta.service.impl;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.mgt.wkp.sta.service.*;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

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
@Service("staticsService")
public class EgovStaticsServiceImpl extends EgovAbstractServiceImpl implements EgovStaticsService {

    @Resource(name = "staticsDAO")
    private StaticsDAO staticsDAO;

    @Override
    public StaticsVO selectConnectStatics(Integer year, Integer month) {
        StaticsVO result = new StaticsVO();

        long totalConnectUserCount = 0;
        long totalConnectCount = 0;
        long totalPreConnectUserCount = 0;
        long totalPreConnectCount = 0;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        Calendar cal = Calendar.getInstance();

        int now = Integer.parseInt(sdf.format(cal.getTime()));

        List<StaticsConnectVO> list = staticsDAO.selectConnectStatics(year, month);

        List<StaticsConnectVO> resultList = new ArrayList<>();

        if (list != null) {
            for (int i = 0; list.size() > i; i++) {
                int day = Integer.parseInt(list.get(i).getDt().replace("-", ""));
                if (now >= day) {
                    if (i != 0 && list.get(i - 1) != null) {
                        list.get(i).setPreVisitUserCount(list.get(i).getVisitUserCount() - list.get(i - 1).getVisitUserCount());
                        list.get(i).setPreVisitCount(list.get(i).getVisitCount() - list.get(i - 1).getVisitCount());
                    }

                    totalConnectUserCount += list.get(i).getVisitUserCount();
                    totalConnectCount += list.get(i).getVisitCount();
                    totalPreConnectUserCount += list.get(i).getPreVisitUserCount();
                    totalPreConnectCount += list.get(i).getPreVisitCount();
                    resultList.add(list.get(i));
                }
            }

        }
        result.setStaticsConnectVoList(resultList);
        result.setTotalConnectUserCount(totalConnectUserCount);
        result.setTotalConnectCount(totalConnectCount);
        result.setTotalPreConnectUserCount(totalPreConnectUserCount);
        result.setTotalPreConnectCount(totalPreConnectCount);

        return result;
    }

    @Override
    public StaticsVO selectQnaStatics(Integer year, Integer month) {
        StaticsVO result = new StaticsVO();

        long totalQuestionCount = 0;
        long totalAnswerCountCount = 0;
        long totalPreQuestionCount = 0;
        long totalPreAnswerCountCount = 0;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        Calendar cal = Calendar.getInstance();

        int now = Integer.parseInt(sdf.format(cal.getTime()));
        List<StaticsQnaVO> list = staticsDAO.selectQnaStatics(year, month);
        List<StaticsQnaVO> resultList = new ArrayList<>();

        if (list != null) {
            for (int i = 0; list.size() > i; i++) {
                int day = Integer.parseInt(list.get(i).getDt().replace("-", ""));
                if (now >= day) {
                    if (i != 0 && list.get(i - 1) != null) {
                        list.get(i).setPreQuestionCount(list.get(i).getQuestionCount() - list.get(i - 1).getQuestionCount());
                        list.get(i).setPreAnswerCount(list.get(i).getAnswerCount() - list.get(i - 1).getAnswerCount());
                    }

                    totalQuestionCount += list.get(i).getQuestionCount();
                    totalAnswerCountCount += list.get(i).getAnswerCount();
                    totalPreQuestionCount += list.get(i).getPreQuestionCount();
                    totalPreAnswerCountCount += list.get(i).getPreAnswerCount();
                    resultList.add(list.get(i));
                }
            }

        }
        result.setStaticsQnaVoList(resultList);
        result.setTotalQuestionCount(totalQuestionCount);
        result.setTotalAnswerCountCount(totalAnswerCountCount);
        result.setTotalPreQuestionCount(totalPreQuestionCount);
        result.setTotalPreAnswerCountCount(totalPreAnswerCountCount);

        return result;
    }
    
	@Override
	public StaticsVO selectKnowledgeStatics(Integer year, Integer month) {
        StaticsVO result = new StaticsVO();

        long totalKnowledgeCount = 0;
        long totalPreKnowledgeCount = 0;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        Calendar cal = Calendar.getInstance();

        int now = Integer.parseInt(sdf.format(cal.getTime()));

        List<StaticsKnowledgeVO> list = staticsDAO.selectKnowledgeStatics(year, month);

        List<StaticsKnowledgeVO> resultList = new ArrayList<>();

        if (list != null) {
            for (int i = 0; list.size() > i; i++) {
                int day = Integer.parseInt(list.get(i).getDt().replace("-", ""));
                if (now >= day) {
                    if (i != 0 && list.get(i - 1) != null) {
                        list.get(i).setPreKnowledgeCount(list.get(i).getKnowledgeCount() - list.get(i - 1).getKnowledgeCount());
                    }

                    totalKnowledgeCount += list.get(i).getKnowledgeCount();
                    totalPreKnowledgeCount += list.get(i).getPreKnowledgeCount();
                    resultList.add(list.get(i));
                }
            }

        }
        result.setStaticsKnowledgeVoList(resultList);
        result.setTotalKnowledgeCount(totalKnowledgeCount);
        result.setTotalPreKnowledgeCount(totalPreKnowledgeCount);

        return result;
	}

	@Override
	public ListWithPageNavigation<KnowledgeVO> selectKnowledgeList(KnowledgeVO knowledgeVO) {

        ListWithPageNavigation<KnowledgeVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectKnowledgeListCount(knowledgeVO), knowledgeVO.getPage(), null, 10);
        knowledgeVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        knowledgeVO.setItemOffset(pageNavigation.getItemCountPerPage() * (knowledgeVO.getPage() - 1));
        result.setList(staticsDAO.selectKnowledgeList(knowledgeVO));
        result.setPageNavigation(pageNavigation);

        return result;
	}
	
	@Override
	public int selectKnowledgeListCount(KnowledgeVO knowledgeVO) {
		return staticsDAO.selectKnowledgeListCount(knowledgeVO);
	}

	@Override
	public ListWithPageNavigation<KnowledgeVO> selectInterestsList(KnowledgeVO knowledgeVO) {
        
		ListWithPageNavigation<KnowledgeVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectInterestsListCount(), knowledgeVO.getPage(), null, 10);
        knowledgeVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        knowledgeVO.setItemOffset(pageNavigation.getItemCountPerPage() * (knowledgeVO.getPage() - 1));
        result.setList(staticsDAO.selectInterestsList(knowledgeVO));
        result.setPageNavigation(pageNavigation);

        return result;    
	}

	@Override
	public int selectInterestsListCount() {
		return staticsDAO.selectInterestsListCount();
	}

    @Override
    public ListWithPageNavigation<StaticsKnowledgeVO> selectViewStatics(StaticsKnowledgeVO param) {
        ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = new ListWithPageNavigation<>();
        PageNavigation pageNavigation = new PageNavigation(selectViewStaticsCount(param), param.getPage(), null, 10);
        param.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        param.setItemOffset(pageNavigation.getItemCountPerPage() * (param.getPage() - 1));
        listWithPageNavigation.setList(staticsDAO.selectViewStatics(param));
        listWithPageNavigation.setPageNavigation(pageNavigation);
        return listWithPageNavigation;
    }

    @Override
    public int selectViewStaticsCount(StaticsKnowledgeVO param) {
        return staticsDAO.selectViewStaticsCount(param);
    }

    @Override
    public ListWithPageNavigation<StaticsKnowledgeVO> selectRecommendStatics(StaticsKnowledgeVO param) {
        ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = new ListWithPageNavigation<>();
        PageNavigation pageNavigation = new PageNavigation(selectRecommendStaticsCount(param), param.getPage(), null, 10);
        param.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        param.setItemOffset(pageNavigation.getItemCountPerPage() * (param.getPage() - 1));
        listWithPageNavigation.setList(staticsDAO.selectRecommendStatics(param));
        listWithPageNavigation.setPageNavigation(pageNavigation);
        return listWithPageNavigation;
    }

    @Override
    public int selectRecommendStaticsCount(StaticsKnowledgeVO param) {
        return staticsDAO.selectRecommendStaticsCount(param);
    }

    @Override
    public ListWithPageNavigation<StaticsKnowledgeVO> selectUserStatics(StaticsKnowledgeVO param) {
        ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = new ListWithPageNavigation<>();
        PageNavigation pageNavigation = new PageNavigation(selectUserStaticsCount(param), param.getPage(), null, 10);
        param.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        param.setItemOffset(pageNavigation.getItemCountPerPage() * (param.getPage() - 1));
        listWithPageNavigation.setList(staticsDAO.selectUserStatics(param));
        listWithPageNavigation.setPageNavigation(pageNavigation);
        return listWithPageNavigation;
    }

    @Override
    public int selectUserStaticsCount(StaticsKnowledgeVO param) {
        return staticsDAO.selectUserStaticsCount(param);
    }

    @Override
    public ListWithPageNavigation<StaticsKnowledgeVO> selectRecommendUserStatics(StaticsKnowledgeVO param) {
        ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = new ListWithPageNavigation<>();
        PageNavigation pageNavigation = new PageNavigation(selectRecommendUserStaticsCount(param), param.getPage(), null, 10);
        param.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        param.setItemOffset(pageNavigation.getItemCountPerPage() * (param.getPage() - 1));
        listWithPageNavigation.setList(staticsDAO.selectRecommendUserStatics(param));
        listWithPageNavigation.setPageNavigation(pageNavigation);
        return listWithPageNavigation;
    }

    @Override
    public int selectRecommendUserStaticsCount(StaticsKnowledgeVO param) {
        return staticsDAO.selectRecommendUserStaticsCount(param);
    }

    @Override
    public ListWithPageNavigation<StaticsKnowledgeVO> selectActiveUserStatics(StaticsKnowledgeVO param) {
        ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = new ListWithPageNavigation<>();
        PageNavigation pageNavigation = new PageNavigation(selectActiveUserStaticsCount(param), param.getPage(), null, 10);
        param.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        param.setItemOffset(pageNavigation.getItemCountPerPage() * (param.getPage() - 1));
        listWithPageNavigation.setList(staticsDAO.selectActiveUserStatics(param));
        listWithPageNavigation.setPageNavigation(pageNavigation);
        return listWithPageNavigation;
    }

    @Override
    public int selectActiveUserStaticsCount(StaticsKnowledgeVO param) {
        return staticsDAO.selectActiveUserStaticsCount(param);
    }

    @Override
    public ListWithPageNavigation<StaticsKnowledgeVO> selectOrgStatics(StaticsKnowledgeVO param) {
        ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = new ListWithPageNavigation<>();
        PageNavigation pageNavigation = new PageNavigation(selectOrgStaticsCount(param), param.getPage(), null, 10);
        param.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        param.setItemOffset(pageNavigation.getItemCountPerPage() * (param.getPage() - 1));
        listWithPageNavigation.setList(staticsDAO.selectOrgStatics(param));
        listWithPageNavigation.setPageNavigation(pageNavigation);
        return listWithPageNavigation;
    }

    @Override
    public int selectOrgStaticsCount(StaticsKnowledgeVO param) {
        return staticsDAO.selectOrgStaticsCount(param);
    }

}
