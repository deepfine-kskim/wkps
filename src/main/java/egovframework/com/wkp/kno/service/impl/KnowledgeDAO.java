package egovframework.com.wkp.kno.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.kno.service.*;
import egovframework.mgt.wkp.log.service.LogVO;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

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

	public int insertKnowledgeModificationRequest(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertKnowledgeModificationRequest", knowledgeVO);
	}
	
	public int updateKnowledge(KnowledgeVO knowledgeVO) {
		return update("KnowledgeDAO.updateKnowledge", knowledgeVO);
	}

	public int deleteKnowledge(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteKnowledge", knowledgeVO);
	}

	public int deleteKnowledgeByTitle(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteKnowledgeByTitle", knowledgeVO);
	}

	public int insertKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO) {
		return insert("KnowledgeDAO.insertKnowledgeContents", knowledgeContentsVO);
	}

	public int insertKnowledgeModificationRequestContent(KnowledgeContentsVO knowledgeContentsVO) {
		return insert("KnowledgeDAO.insertKnowledgeModificationRequestContent", knowledgeContentsVO);
	}
	
	public int updateKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO) {
		return update("KnowledgeDAO.updateKnowledgeContents", knowledgeContentsVO);
	}

	public int updateKnowledgeModificationRequestContent(KnowledgeContentsVO knowledgeContentsVO) {
		return update("KnowledgeDAO.updateKnowledgeModificationRequestContent", knowledgeContentsVO);
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

	public int deleteUserMileageByTitle(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteUserMileageByTitle", knowledgeVO);
	}

	public int deleteOrgMileageByTitle(KnowledgeVO knowledgeVO) {
		return delete("KnowledgeDAO.deleteOrgMileageByTitle", knowledgeVO);
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

	public int deleteBookmark(KnowledgeVO KnowledgeVO) {
		return delete("KnowledgeDAO.deleteBookmark", KnowledgeVO);
	}

	public List<KnowledgeVO> selectModificationRequestList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectModificationRequestList", knowledgeVO);
	}

	public int selectModificationRequestListCount(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectModificationRequestListCount", knowledgeVO);
	}

	public KnowledgeVO selectModificationRequestDetail(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectModificationRequestDetail", knowledgeVO);
	}

	public List<KnowledgeContentsVO> selectModificationRequestContentList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectModificationRequestContentList", knowledgeVO);
	}

	public List<KnowledgeVO> selectSucceedList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectSucceedList", knowledgeVO);
	}

	public int selectSucceedListCount(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectSucceedListCount", knowledgeVO);
	}

	public int updateOwner(KnowledgeVO knowledgeVO) {
		return update("KnowledgeDAO.updateOwner", knowledgeVO);
	}

	public List<KnowledgeVO> selectApprovalList(KnowledgeVO knowledgeVO) {
		return selectList("KnowledgeDAO.selectApprovalList", knowledgeVO);
	}

	public int selectApprovalListCount(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.selectApprovalListCount", knowledgeVO);
	}

	public int checkDuplication(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.checkDuplication", knowledgeVO);
	}

	/**
	 * 지식 조회 여부 확인
	 */
	public int countKnowledgeView(KnowledgeVO knowledgeVO) {
		return selectOne("KnowledgeDAO.countKnowledgeView", knowledgeVO);
	}

	/**
	 * 지식 조회 여부 등록
	 */
	public int insertKnowledgeView(KnowledgeVO knowledgeVO) {
		return insert("KnowledgeDAO.insertKnowledgeView", knowledgeVO);
	}

	/**
	 * 최신 지식 조회 (행정자료, 업무참고자료, 개인행정지식별 2건)
	 */
	public List<KnowledgeVO> selectNewKnowledgeList() {
		return selectList("KnowledgeDAO.selectNewKnowledgeList");
	}
}
