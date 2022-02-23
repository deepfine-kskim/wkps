package egovframework.com.wkp.kno.service.impl;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.kno.service.ErrorStatementVO;
import egovframework.com.wkp.kno.service.KnowledgeContentsVO;
import egovframework.com.wkp.kno.service.KnowledgeMapVO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.com.wkp.kno.service.OrgMileageVO;
import egovframework.com.wkp.kno.service.RelateKnowlgVO;
import egovframework.com.wkp.kno.service.UserMileageVO;
import egovframework.mgt.wkp.log.service.LogVO;

@Repository("knowledgeDAO")
public class KnowledgeDAO extends EgovComAbstractDAO {

	public List<KnowledgeVO> selectKnowledgeList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectKnowledgeList", knowledgeVO);
	}
	
    public int selectKnowledgeListCount(KnowledgeVO knowledgeVO) {
        return selectOne("KnowledgeDAO.selectKnowledgeListCount", knowledgeVO);
    }

	public Date selectKnowledgeLastUpdated(KnowledgeVO knowledgeVO) {
        return selectOne("KnowledgeDAO.selectKnowledgeLastUpdated", knowledgeVO);    	
    }
    
	public KnowledgeVO selectKnowledgeDetail(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectKnowledgeDetail", knowledgeVO);
	}
	
	public int insertKnowledge(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertKnowledge", knowledgeVO);
	}
	
	public int updateKnowledge(KnowledgeVO knowledgeVO) {
		return update("KnowledgeDAO.updateKnowledge", knowledgeVO);
	}

	public int deleteKnowledge(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteKnowledge", knowledgeVO);
	}
	
	public int insertKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO) {
		return insert("KnowledgeDAO.insertKnowledgeContents", knowledgeContentsVO);
	}
	
	public int updateKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO) {
		return update("KnowledgeDAO.updateKnowledgeContents", knowledgeContentsVO);
	}
	
	public int insertPreview(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertPreview", knowledgeVO);
	}

	public List<KnowledgeContentsVO> selectKnowledgeContentsList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectKnowledgeContentsList", knowledgeVO);
	}
	
	public KnowledgeContentsVO selectKnowledgeContentsDetail(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectKnowledgeContentsDetail", knowledgeVO);
	}
	
	public List<KnowledgeMapVO> selectKnowledgeMapList(KnowledgeMapVO knowledgeMapVO) {
		return selectList("KnowledgeDAO.selectKnowledgeMapList", knowledgeMapVO);
	}
		
	public KnowledgeMapVO selectKnowledgeMap(long knowlgMapNo) {
		return selectOne("KnowledgeDAO.selectKnowledgeMap", knowlgMapNo);
	}

	public List<String> selectRelateKnowledgeList(long relateKnowlgNo) {
		return selectList("KnowledgeDAO.selectRelateKnowledgeList", relateKnowlgNo);
	}
	
	public List<RelateKnowlgVO> selectRelateKnowledgeListDelChk(long relateKnowlgNo) {
		return selectList("KnowledgeDAO.selectRelateKnowledgeListDelChk", relateKnowlgNo);
	}
	
	public int deleteRelateKnowlg(RelateKnowlgVO relateKnowlgVO) {
		return delete("KnowledgeDAO.deleteRelateKnowlg", relateKnowlgVO);
	}
	
	public int updateKnowlg(KnowledgeVO knowledgeVO) {
		return update("KnowledgeDAO.updateKnowlg", knowledgeVO);
	}
	
	public long insertRelateKnowledge(KnowledgeVO knowledgeVO) {
		insert("KnowledgeDAO.insertRelateKnowledge", knowledgeVO);
		for(int i=0; i < knowledgeVO.getRelateKnowledgeList().size(); i++){			
			knowledgeVO.setSortOrdr(i+1);
			//System.out.println("knowledgeVO.getRelateKnowledgeList().get(i) - " + knowledgeVO.getRelateKnowledgeList().get(i));
			knowledgeVO.setRelateKnowlgTitle(knowledgeVO.getRelateKnowledgeList().get(i));
			insert("KnowledgeDAO.insertRelateKnowledgeDetail", knowledgeVO);
		}
		return knowledgeVO.getRelateKnowlgNo();
	}	
	
	public List<KnowledgeVO> selectKnowledgeHistoryList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectKnowledgeHistoryList", knowledgeVO);
	}
	
	public List<ErrorStatementVO> selectErrorStatementList(ErrorStatementVO errorStatementVO) {
		return selectList("KnowledgeDAO.selectErrorStatementList", errorStatementVO);
	}

	public int selectErrorStatementListCount(ErrorStatementVO errorStatementVO) {
		return selectOne("KnowledgeDAO.selectErrorStatementListCount", errorStatementVO);
	}

	public ErrorStatementVO selectErrorStatementDetail(ErrorStatementVO errorStatementVO) {
		return selectOne("KnowledgeDAO.selectErrorStatementDetail", errorStatementVO);
	}
	
	public ErrorStatementVO selectErrorStatementPre(ErrorStatementVO errorStatementVO) {
		return selectOne("KnowledgeDAO.selectErrorStatementPre", errorStatementVO);
	}
	
	public ErrorStatementVO selectErrorStatementNext(ErrorStatementVO errorStatementVO) {
		return selectOne("KnowledgeDAO.selectErrorStatementNext", errorStatementVO);
	}

	public int insertErrorStatement(ErrorStatementVO errorStatementVO) {
		return insert("KnowledgeDAO.insertErrorStatement", errorStatementVO);
	}
	
	public int updateErrorStatement(ErrorStatementVO errorStatementVO) {
		return update("KnowledgeDAO.updateErrorStatement", errorStatementVO);
	}

	public int updateErrorStatementAnswer(ErrorStatementVO errorStatementVO) {
		return update("KnowledgeDAO.updateErrorStatementAnswer", errorStatementVO);
	}

	public List<KnowledgeVO> selectBookmarkList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectBookmarkList", knowledgeVO);
	}
	
	public int insertBookmark(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertBookmark", knowledgeVO);
	}
	
	public int updateApproval(KnowledgeVO knowledgeVO) {
		return update("KnowledgeDAO.updateApproval", knowledgeVO);
	}
	
	public int insertUserMileage(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertUserMileage", knowledgeVO);
	}

	public int insertOrgMileage(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertOrgMileage", knowledgeVO);
	}
	
	public int deleteUserMileage(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteUserMileage", knowledgeVO);
	}

	public int deleteOrgMileage(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteOrgMileage", knowledgeVO);
	}
	
	public List<UserMileageVO> selectUserMileageList(UserMileageVO userMileageVO) {
		return selectList("KnowledgeDAO.selectUserMileageList", userMileageVO);
	}

	public List<UserMileageVO> selectUserMileageDetail(UserMileageVO userMileageVO) {
		return selectList("KnowledgeDAO.selectUserMileageDetail", userMileageVO);
	}

	public List<OrgMileageVO> selectOrgMileageList(OrgMileageVO orgMileageVO) {
		return selectList("KnowledgeDAO.selectOrgMileageList", orgMileageVO);
	}

	public List<OrgMileageVO> selectOrgMileageDetail(OrgMileageVO orgMileageVO) {
		return selectList("KnowledgeDAO.selectOrgMileageDetail", orgMileageVO);
	}
	
    public int selectUserMileageListCount(UserMileageVO userMileageVO) {
        return selectOne("KnowledgeDAO.selectUserMileageListCount", userMileageVO);
    }
    
    public int selectUserMileageDetailCount(UserMileageVO userMileageVO) {
        return selectOne("KnowledgeDAO.selectUserMileageDetailCount", userMileageVO);
    }
    
    public int selectOrgMileageListCount(OrgMileageVO orgMileageVO) {
        return selectOne("KnowledgeDAO.selectOrgMileageListCount", orgMileageVO);
    }
    
    public int selectOrgMileageDetailCount(OrgMileageVO orgMileageVO) {
        return selectOne("KnowledgeDAO.selectOrgMileageDetailCount", orgMileageVO);
    }
    
	public int updateInqCnt(KnowledgeVO knowledgeVO) {
		return update("KnowledgeDAO.updateInqCnt", knowledgeVO);
	}
	
	public int insertRecommend(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertRecommend", knowledgeVO);
	}
	
	public int deleteRecommend(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteRecommend", knowledgeVO);
	}
	
	public int selectRecommendCount(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectRecommendCount", knowledgeVO);
	}
	
	public KnowledgeVO selectRecommend(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectRecommend", knowledgeVO);
	}
	
	public int insertInterests(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertInterests", knowledgeVO);
	}
	
	public int deleteInterests(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteInterests", knowledgeVO);
	}

	public KnowledgeVO selectInterests(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectInterests", knowledgeVO);
	}
	
	public List<KnowledgeVO> selectInterestsList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectInterestsList", knowledgeVO);
	}
	
	public int insertKnowledgeMap(KnowledgeMapVO knowledgeMapVO) {
		return insert("KnowledgeDAO.insertKnowledgeMap", knowledgeMapVO);
	}

	public int updateKnowledgeMap(KnowledgeMapVO knowledgeMapVO) {
		return update("KnowledgeDAO.updateKnowledgeMap", knowledgeMapVO);
	}

	public int deleteKnowledgeMap(KnowledgeMapVO knowledgeMapVO) {
		return delete("KnowledgeDAO.deleteKnowledgeMap", knowledgeMapVO);
	}
	
	public List<String> selectKnowledgeTitle() {
		return selectList("KnowledgeDAO.selectKnowledgeTitle");
	}

	public int updateKnowledgeLink(KnowledgeVO knowledgeVO) {
		return update("KnowledgeDAO.updateKnowledgeLink", knowledgeVO);
	}
	
	public List<LogVO> selectKnowledgeMapLogList() {
		return selectList("KnowledgeDAO.selectKnowledgeMapLogList");
	}
}
