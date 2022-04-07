package egovframework.mgt.wkp.sta.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.kno.service.KnowledgeVO;

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
public interface EgovStaticsService {

    public StaticsVO selectConnectStatics(Integer year, Integer Month);
    
    public StaticsVO selectQnaStatics(Integer year, Integer Month);
    
    public StaticsVO selectKnowledgeStatics(Integer year, Integer Month);
    
    public ListWithPageNavigation<KnowledgeVO> selectKnowledgeList(KnowledgeVO knowledgeVO);
    
    public int selectKnowledgeListCount();
    
    public ListWithPageNavigation<KnowledgeVO> selectInterestsList(KnowledgeVO knowledgeVO);
    
    public int selectInterestsListCount();

    public ListWithPageNavigation<StaticsKnowledgeVO> selectViewStatics(StaticsKnowledgeVO param);

    public int selectViewStaticsCount(StaticsKnowledgeVO param);

    public ListWithPageNavigation<StaticsKnowledgeVO> selectRecommendStatics(StaticsKnowledgeVO param);

    public int selectRecommendStaticsCount(StaticsKnowledgeVO param);

    public ListWithPageNavigation<StaticsKnowledgeVO> selectUserStatics(StaticsKnowledgeVO param);

    public int selectUserStaticsCount(StaticsKnowledgeVO param);

    public ListWithPageNavigation<StaticsKnowledgeVO> selectRecommendUserStatics(StaticsKnowledgeVO param);

    public int selectRecommendUserStaticsCount(StaticsKnowledgeVO param);

    public ListWithPageNavigation<StaticsKnowledgeVO> selectOrgStatics(StaticsKnowledgeVO param);

    public int selectOrgStaticsCount(StaticsKnowledgeVO param);

}
