package egovframework.com.wkp.kno.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.mgt.wkp.log.service.LogVO;

import java.sql.Date;
import java.util.List;

public interface EgovKnowledgeService {
	
	public ListWithPageNavigation<KnowledgeVO> selectKnowledgeList(KnowledgeVO knowledgeVO);
	
    public int selectKnowledgeListCount(KnowledgeVO knowledgeVO);

	public Date selectKnowledgeLastUpdated(KnowledgeVO knowledgeVO);
	
	public KnowledgeVO selectKnowledgeDetail(KnowledgeVO knowledgeVO);
	
	public int insertKnowledge(KnowledgeVO knowledgeVO);

	public int insertKnowledgeModificationRequest(KnowledgeVO knowledgeVO);

	public int updateKnowledge(KnowledgeVO knowledgeVO);
	
	public int deleteKnowledge(KnowledgeVO knowledgeVO);

	public int deleteKnowledgeByTitle(KnowledgeVO knowledgeVO);
	
	public int insertKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO);

	public int insertKnowledgeModificationRequestContent(KnowledgeContentsVO knowledgeContentsVO);
	
	public int updateKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO);

	public int updateKnowledgeModificationRequestContent(KnowledgeContentsVO knowledgeContentsVO);

	public int insertPreview(KnowledgeVO knowledgeVO);
	
	public List<KnowledgeContentsVO> selectKnowledgeContentsList(KnowledgeVO knowledgeVO);
	
	public KnowledgeContentsVO selectKnowledgeContentsDetail(KnowledgeVO knowledgeVO);
	
	public List<KnowledgeMapVO> selectKnowledgeMapList(KnowledgeMapVO knowledgeMapVO);
	
	public KnowledgeMapVO selectKnowledgeMap(long knowlgMapNo);
	
	public List<String> selectRelateKnowledgeList(long relateKnowlgNo);
	
	public List<RelateKnowlgVO> selectRelateKnowledgeListDelChk(long relateKnowlgNo);
	
	public int deleteRelateKnowlg(RelateKnowlgVO relateKnowlgVO);
	
	public int updateKnowlg(KnowledgeVO knowledgeVO);
	
	public long insertRelateKnowledge(KnowledgeVO knowledgeVO);
	
	public List<KnowledgeVO> selectKnowledgeHistoryList(KnowledgeVO knowledgeVO);
		
	public ListWithPageNavigation<ErrorStatementVO> selectErrorStatementList(ErrorStatementVO errorStatementVO);
	
	public int selectErrorStatementListCount(ErrorStatementVO errorStatementVO);
	
	public ErrorStatementVO selectErrorStatementDetail(ErrorStatementVO errorStatementVO);
	
	public ErrorStatementVO selectErrorStatementPre(ErrorStatementVO errorStatementVO);
	
	public ErrorStatementVO selectErrorStatementNext(ErrorStatementVO errorStatementVO);
	
	public int insertErrorStatement(ErrorStatementVO errorStatementVO);
	
	public int updateErrorStatement(ErrorStatementVO errorStatementVO);
	
	public int updateErrorStatementAnswer(ErrorStatementVO errorStatementVO);

	public List<KnowledgeVO> selectBookmarkList(KnowledgeVO knowledgeVO);
	
	public int insertBookmark(KnowledgeVO knowledgeVO);
	
	public int updateApproval(KnowledgeVO knowledgeVO);
	
	public int insertUserMileage(KnowledgeVO knowledgeVO);
	
	public int insertOrgMileage(KnowledgeVO knowledgeVO);
	
	public int deleteUserMileage(KnowledgeVO knowledgeVO);

	public int deleteOrgMileage(KnowledgeVO knowledgeVO);

	public int deleteUserMileageByTitle(KnowledgeVO knowledgeVO);

	public int deleteOrgMileageByTitle(KnowledgeVO knowledgeVO);
	
	public ListWithPageNavigation<UserMileageVO> selectUserMileageList(UserMileageVO userMileageVO);
	
	public ListWithPageNavigation<UserMileageVO> selectUserMileageDetail(UserMileageVO userMileageVO);
	
	public ListWithPageNavigation<OrgMileageVO> selectOrgMileageList(OrgMileageVO orgMileageVO);
	
	public ListWithPageNavigation<OrgMileageVO> selectOrgMileageDetail(OrgMileageVO orgMileageVO);
	
	public int selectUserMileageListCount(UserMileageVO userMileageVO);
	
	public int selectUserMileageDetailCount(UserMileageVO userMileageVO);
	
	public int selectOrgMileageListCount(OrgMileageVO orgMileageVO);
	
	public int selectOrgMileageDetailCount(OrgMileageVO orgMileageVO);
	
	public int updateInqCnt(KnowledgeVO knowledgeVO);
	
	public Boolean updateRecommend(KnowledgeVO knowledgeVO);
	
	public int selectRecommendCount(KnowledgeVO knowledgeVO);
	
	public KnowledgeVO selectRecommend(KnowledgeVO knowledgeVO);
	
	public Boolean updateInterests(KnowledgeVO knowledgeVO);
	
	public KnowledgeVO selectInterests(KnowledgeVO knowledgeVO);
	
	public List<KnowledgeVO> selectInterestsList(KnowledgeVO knowledgeVO);
    
    public int insertKnowledgeMap(KnowledgeMapVO knowledgeMapVO);
    
    public int updateKnowledgeMap(KnowledgeMapVO knowledgeMapVO);
    
    public int deleteKnowledgeMap(KnowledgeMapVO knowledgeMapVO);
    
    public List<String> selectKnowledgeTitle();
    
    public int updateKnowledgeLink(KnowledgeVO knowledgeVO);
	
    public List<LogVO> selectKnowledgeMapLogList();

	public int deleteBookmark(KnowledgeVO KnowledgeVO);

	public ListWithPageNavigation<KnowledgeVO> selectModificationRequestList(KnowledgeVO knowledgeVO);

	public int selectModificationRequestListCount(KnowledgeVO knowledgeVO);

	public KnowledgeVO selectModificationRequestDetail(KnowledgeVO knowledgeVO);

	public List<KnowledgeContentsVO> selectModificationRequestContentList(KnowledgeVO knowledgeVO);

	public ListWithPageNavigation<KnowledgeVO> selectSucceedList(KnowledgeVO knowledgeVO);

	public int selectSucceedListCount(KnowledgeVO knowledgeVO);

	public int updateOwner(KnowledgeVO knowledgeVO);

	public ListWithPageNavigation<KnowledgeVO> selectApprovalList(KnowledgeVO knowledgeVO);

	public int selectApprovalListCount(KnowledgeVO knowledgeVO);

	public int checkDuplication(KnowledgeVO knowledgeVO);

	public int countKnowledgeView(KnowledgeVO knowledgeVO);

	public void insertKnowledgeView(KnowledgeVO knowledgeVO);

	public List<KnowledgeVO> selectNewKnowledgeList();
}
