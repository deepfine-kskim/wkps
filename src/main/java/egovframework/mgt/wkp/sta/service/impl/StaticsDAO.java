package egovframework.mgt.wkp.sta.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.mgt.wkp.sta.service.StaticsKnowledgeVO;
import egovframework.mgt.wkp.sta.service.StaticsConnectVO;
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
	
	public int selectKnowledgeListCount() {
		return selectOne("StaticsDAO.selectKnowledgeListCount");
	}

	public List<KnowledgeVO> selectInterestsList(KnowledgeVO knowledgeVO) {
		return selectList("StaticsDAO.selectInterestsList", knowledgeVO);
	}
	
	public int selectInterestsListCount() {
		return selectOne("StaticsDAO.selectInterestsListCount");
	}
}
