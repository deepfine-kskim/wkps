package egovframework.mgt.wkp.sta.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.mgt.wkp.sta.service.StaticsConnectVO;
import egovframework.mgt.wkp.sta.service.StaticsKnowledgeVO;
import egovframework.mgt.wkp.sta.service.StaticsQnaVO;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository("staticsDAO")
public class StaticsDAO extends EgovComAbstractDAO {
    
	public List<StaticsConnectVO> selectConnectStatics(Integer year, Integer month) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("year", year);
        param.put("month", month);

        return selectList("StaticsDAO.selectConnectStatics", param);
    }
    
    public List<StaticsQnaVO> selectQnaStatics(Integer year, Integer month) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("year", year);
        param.put("month", month);

        return selectList("StaticsDAO.selectQnaStatics", param);
    }
    
	public List<StaticsKnowledgeVO> selectKnowledgeStatics(Integer year, Integer month) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("year", year);
        param.put("month", month);
        
		return selectList("StaticsDAO.selectKnowledgeStatics", param);
	}
    
	public List<KnowledgeVO> selectKnowledgeList(KnowledgeVO knowledgeVO) {
		return selectList("StaticsDAO.selectKnowledgeList", knowledgeVO);
	}
	
	public int selectKnowledgeListCount(KnowledgeVO knowledgeVO) {
		return selectOne("StaticsDAO.selectKnowledgeListCount", knowledgeVO);
	}

	public List<KnowledgeVO> selectInterestsList(KnowledgeVO knowledgeVO) {
		return selectList("StaticsDAO.selectInterestsList", knowledgeVO);
	}
	
	public int selectInterestsListCount() {
		return selectOne("StaticsDAO.selectInterestsListCount");
	}

	public List<StaticsKnowledgeVO> selectViewStatics(StaticsKnowledgeVO param) {
		return selectList("StaticsDAO.selectViewStatics", param);
	}

	public int selectViewStaticsCount(StaticsKnowledgeVO param) {
		return selectOne("StaticsDAO.selectViewStaticsCount", param);
	}

	public List<StaticsKnowledgeVO> selectRecommendStatics(StaticsKnowledgeVO param) {
		return selectList("StaticsDAO.selectRecommendStatics", param);
	}

	public int selectRecommendStaticsCount(StaticsKnowledgeVO param) {
		return selectOne("StaticsDAO.selectRecommendStaticsCount", param);
	}

	public List<StaticsKnowledgeVO> selectUserStatics(StaticsKnowledgeVO param) {
		return selectList("StaticsDAO.selectUserStatics", param);
	}

	public int selectUserStaticsCount(StaticsKnowledgeVO param) {
		return selectOne("StaticsDAO.selectUserStaticsCount", param);
	}

	public List<StaticsKnowledgeVO> selectRecommendUserStatics(StaticsKnowledgeVO param) {
		return selectList("StaticsDAO.selectRecommendUserStatics", param);
	}

	public int selectRecommendUserStaticsCount(StaticsKnowledgeVO param) {
		return selectOne("StaticsDAO.selectRecommendUserStaticsCount", param);
	}

	public List<StaticsKnowledgeVO> selectActiveUserStatics(StaticsKnowledgeVO param) {
		return selectList("StaticsDAO.selectActiveUserStatics", param);
	}

	public int selectActiveUserStaticsCount(StaticsKnowledgeVO param) {
		return selectOne("StaticsDAO.selectActiveUserStaticsCount", param);
	}

	public List<StaticsKnowledgeVO> selectOrgStatics(StaticsKnowledgeVO param) {
		return selectList("StaticsDAO.selectOrgStatics", param);
	}

	public int selectOrgStaticsCount(StaticsKnowledgeVO param) {
		return selectOne("StaticsDAO.selectOrgStaticsCount", param);
	}
}
