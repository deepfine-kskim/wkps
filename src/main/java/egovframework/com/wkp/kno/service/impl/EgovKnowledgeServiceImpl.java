package egovframework.com.wkp.kno.service.impl;

import java.sql.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.kno.service.EgovKnowledgeService;
import egovframework.com.wkp.kno.service.ErrorStatementVO;
import egovframework.com.wkp.kno.service.KnowledgeContentsVO;
import egovframework.com.wkp.kno.service.KnowledgeMapVO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.com.wkp.kno.service.OrgMileageVO;
import egovframework.com.wkp.kno.service.RelateKnowlgVO;
import egovframework.com.wkp.kno.service.UserMileageVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.mgt.wkp.log.service.LogVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("knowledgeService")
public class EgovKnowledgeServiceImpl extends EgovAbstractServiceImpl implements EgovKnowledgeService {

    @Resource(name="knowledgeDAO")
    private KnowledgeDAO knowledgeDAO;

	@Resource(name = "logService")
	EgovLogService egovLogService;

	@Override
	public ListWithPageNavigation<KnowledgeVO> selectKnowledgeList(KnowledgeVO knowledgeVO) {
		
        ListWithPageNavigation<KnowledgeVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectKnowledgeListCount(knowledgeVO), knowledgeVO.getPage(), null, null);
        knowledgeVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        knowledgeVO.setItemOffset(pageNavigation.getItemCountPerPage() * (knowledgeVO.getPage() - 1));
        result.setList(knowledgeDAO.selectKnowledgeList(knowledgeVO));
        result.setPageNavigation(pageNavigation);

		egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.KNOWLEDGE, null);

        return result;
	}
		
    @Override
    public int selectKnowledgeListCount(KnowledgeVO knowledgeVO) {
        return knowledgeDAO.selectKnowledgeListCount(knowledgeVO);
    }
    
    @Override    
	public Date selectKnowledgeLastUpdated(KnowledgeVO knowledgeVO) {
        return knowledgeDAO.selectKnowledgeLastUpdated(knowledgeVO);    	
    }

	@Override
	public KnowledgeVO selectKnowledgeDetail(KnowledgeVO knowledgeVO) {
		KnowledgeVO vo = knowledgeDAO.selectKnowledgeDetail(knowledgeVO);
		egovLogService.insert(LogType.SELECT_DETAIL, LogSubjectType.KNOWLEDGE, vo);
		return vo;
	}
	
	@Override
	public int insertKnowledge(KnowledgeVO knowledgeVO) {
		egovLogService.insert(LogType.INSERT, LogSubjectType.KNOWLEDGE, knowledgeVO);
		return knowledgeDAO.insertKnowledge(knowledgeVO);
	}

	@Override
	public int insertKnowledgeModificationRequest(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.insertKnowledgeModificationRequest(knowledgeVO);
	}

	@Override
	public int updateKnowledge(KnowledgeVO knowledgeVO) {
		egovLogService.insert(LogType.UPDATE, LogSubjectType.KNOWLEDGE, knowledgeVO);
		return knowledgeDAO.updateKnowledge(knowledgeVO);
	}

	@Override
	public int deleteKnowledge(KnowledgeVO knowledgeVO) {
		egovLogService.insert(LogType.DELETE, LogSubjectType.KNOWLEDGE, knowledgeVO);
		return knowledgeDAO.deleteKnowledge(knowledgeVO);
	}

	@Override
	public int insertKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO) {
		return knowledgeDAO.insertKnowledgeContents(knowledgeContentsVO);
	}

	@Override
	public int insertKnowledgeModificationRequestContent(KnowledgeContentsVO knowledgeContentsVO) {
		return knowledgeDAO.insertKnowledgeModificationRequestContent(knowledgeContentsVO);
	}

	@Override
	public int updateKnowledgeContents(KnowledgeContentsVO knowledgeContentsVO) {
		return knowledgeDAO.updateKnowledgeContents(knowledgeContentsVO);
	}

	@Override
	public int updateKnowledgeModificationRequestContent(KnowledgeContentsVO knowledgeContentsVO) {
		return knowledgeDAO.updateKnowledgeModificationRequestContent(knowledgeContentsVO);
	}
	
	@Override
	public int insertPreview(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.insertPreview(knowledgeVO);
	}

	@Override
	public List<KnowledgeContentsVO> selectKnowledgeContentsList(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectKnowledgeContentsList(knowledgeVO);
	}
	
	@Override
	public KnowledgeContentsVO selectKnowledgeContentsDetail(KnowledgeVO knowledgeVO ) {
		return knowledgeDAO.selectKnowledgeContentsDetail(knowledgeVO);
	}
	
	@Override
	public List<KnowledgeMapVO> selectKnowledgeMapList(KnowledgeMapVO knowledgeMapVO) {
		return knowledgeDAO.selectKnowledgeMapList(knowledgeMapVO);
	}
	
	@Override
	public KnowledgeMapVO selectKnowledgeMap(long knowlgMapNo) {
		return knowledgeDAO.selectKnowledgeMap(knowlgMapNo);
	}

	@Override
	public List<String> selectRelateKnowledgeList(long relateKnowlgNo) {
		return knowledgeDAO.selectRelateKnowledgeList(relateKnowlgNo);
	}
	
	@Override
	public List<RelateKnowlgVO> selectRelateKnowledgeListDelChk(long relateKnowlgNo) {
		return knowledgeDAO.selectRelateKnowledgeListDelChk(relateKnowlgNo);
	}
	
	public int deleteRelateKnowlg(RelateKnowlgVO relateKnowlgVO) {
		return knowledgeDAO.deleteRelateKnowlg(relateKnowlgVO);
	}
	
	public int updateKnowlg(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.updateKnowlg(knowledgeVO);
	}
	
	@Override
	public long insertRelateKnowledge(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.insertRelateKnowledge(knowledgeVO);
	}
	
	@Override
	public List<KnowledgeVO> selectKnowledgeHistoryList(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectKnowledgeHistoryList(knowledgeVO);
	}
	
	@Override
	public ListWithPageNavigation<ErrorStatementVO> selectErrorStatementList(ErrorStatementVO errorStatementVO) {
		
		ListWithPageNavigation<ErrorStatementVO> result = new ListWithPageNavigation<>();
		
        PageNavigation pageNavigation = new PageNavigation(selectErrorStatementListCount(errorStatementVO), errorStatementVO.getPage(), null, null);
        errorStatementVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        errorStatementVO.setItemOffset(pageNavigation.getItemCountPerPage() * (errorStatementVO.getPage() - 1));
        result.setList(knowledgeDAO.selectErrorStatementList(errorStatementVO));
        result.setPageNavigation(pageNavigation);

		return result;
	}

	@Override
	public int selectErrorStatementListCount(ErrorStatementVO errorStatementVO) {
		return knowledgeDAO.selectErrorStatementListCount(errorStatementVO);
	}

	@Override
	public ErrorStatementVO selectErrorStatementDetail(ErrorStatementVO errorStatementVO) {
		return knowledgeDAO.selectErrorStatementDetail(errorStatementVO);
	}
	
	@Override
	public ErrorStatementVO selectErrorStatementPre(ErrorStatementVO errorStatementVO) {
		return knowledgeDAO.selectErrorStatementPre(errorStatementVO);
	}
	
	@Override
	public ErrorStatementVO selectErrorStatementNext(ErrorStatementVO errorStatementVO) {
		return knowledgeDAO.selectErrorStatementNext(errorStatementVO);
	}

	@Override
	public int insertErrorStatement(ErrorStatementVO errorStatementVO) {
		return knowledgeDAO.insertErrorStatement(errorStatementVO);
	}
	
	@Override
	public int updateErrorStatement(ErrorStatementVO errorStatementVO) {
		return knowledgeDAO.updateErrorStatement(errorStatementVO);
	}

	@Override
	public int updateErrorStatementAnswer(ErrorStatementVO errorStatementVO) {
		return knowledgeDAO.updateErrorStatementAnswer(errorStatementVO);
	}

	@Override
	public List<KnowledgeVO> selectBookmarkList(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectBookmarkList(knowledgeVO);
	}
	
	@Override
	public int insertBookmark(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.insertBookmark(knowledgeVO);
	}

	@Override
	public int updateApproval(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.updateApproval(knowledgeVO);
	}

	@Override
	public int insertUserMileage(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.insertUserMileage(knowledgeVO);
	}

	@Override
	public int insertOrgMileage(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.insertOrgMileage(knowledgeVO);
	}
	
	@Override
	public int deleteUserMileage(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.deleteUserMileage(knowledgeVO);
	}

	@Override
	public int deleteOrgMileage(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.deleteOrgMileage(knowledgeVO);
	}

	@Override
	public int deleteUserMileageByTitle(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.deleteUserMileageByTitle(knowledgeVO);
	}

	@Override
	public int deleteOrgMileageByTitle(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.deleteOrgMileageByTitle(knowledgeVO);
	}

	@Override
	public ListWithPageNavigation<UserMileageVO> selectUserMileageList(UserMileageVO userMileageVO) {
		
        ListWithPageNavigation<UserMileageVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectUserMileageListCount(userMileageVO), userMileageVO.getPage(), null, null);
        userMileageVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        userMileageVO.setItemOffset(pageNavigation.getItemCountPerPage() * (userMileageVO.getPage() - 1));
        result.setList(knowledgeDAO.selectUserMileageList(userMileageVO));
        result.setPageNavigation(pageNavigation);

        return result;
	}

	@Override
	public ListWithPageNavigation<UserMileageVO> selectUserMileageDetail(UserMileageVO userMileageVO) {
		
        ListWithPageNavigation<UserMileageVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectUserMileageDetailCount(userMileageVO), userMileageVO.getPage(), null, null);
        userMileageVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        userMileageVO.setItemOffset(pageNavigation.getItemCountPerPage() * (userMileageVO.getPage() - 1));
        result.setList(knowledgeDAO.selectUserMileageDetail(userMileageVO));
        result.setPageNavigation(pageNavigation);

        return result;
	}

	@Override
	public ListWithPageNavigation<OrgMileageVO> selectOrgMileageList(OrgMileageVO orgMileageVO) {
		
        ListWithPageNavigation<OrgMileageVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectOrgMileageListCount(orgMileageVO), orgMileageVO.getPage(), null, null);
        orgMileageVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        orgMileageVO.setItemOffset(pageNavigation.getItemCountPerPage() * (orgMileageVO.getPage() - 1));
        result.setList(knowledgeDAO.selectOrgMileageList(orgMileageVO));
        result.setPageNavigation(pageNavigation);

        return result;
	}

	@Override
	public ListWithPageNavigation<OrgMileageVO> selectOrgMileageDetail(OrgMileageVO orgMileageVO) {
		
        ListWithPageNavigation<OrgMileageVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectOrgMileageDetailCount(orgMileageVO), orgMileageVO.getPage(), null, null);
        orgMileageVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        orgMileageVO.setItemOffset(pageNavigation.getItemCountPerPage() * (orgMileageVO.getPage() - 1));
        result.setList(knowledgeDAO.selectOrgMileageDetail(orgMileageVO));
        result.setPageNavigation(pageNavigation);

        return result;
	}
	
    @Override
    public int selectUserMileageListCount(UserMileageVO userMileageVO) {
        return knowledgeDAO.selectUserMileageListCount(userMileageVO);
    }
    
    @Override
    public int selectUserMileageDetailCount(UserMileageVO userMileageVO) {
        return knowledgeDAO.selectUserMileageDetailCount(userMileageVO);
    }
    
    @Override
    public int selectOrgMileageListCount(OrgMileageVO orgMileageVO) {
        return knowledgeDAO.selectOrgMileageListCount(orgMileageVO);
    }
    
    @Override
    public int selectOrgMileageDetailCount(OrgMileageVO orgMileageVO) {
        return knowledgeDAO.selectOrgMileageDetailCount(orgMileageVO);
    }

	@Override
	public int updateInqCnt(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.updateInqCnt(knowledgeVO);
	}

	@Override
	public Boolean updateRecommend(KnowledgeVO knowledgeVO) {
        
		Boolean result = false;
		
        try {
            if (knowledgeDAO.insertRecommend(knowledgeVO) > 0) {
                result = true;
            }
        } catch (Exception e) {
        	knowledgeDAO.deleteRecommend(knowledgeVO);
        }

        egovLogService.insert(result ? LogType.INSERT_KNOWLG_RECOMMENDATION:LogType.DELETE_KNOWLG_RECOMMENDATION, LogSubjectType.KNOWLEDGE, knowledgeVO);
				
		return result;
	}
	
	@Override
	public int selectRecommendCount(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectRecommendCount(knowledgeVO);
	}

	@Override
	public KnowledgeVO selectRecommend(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectRecommend(knowledgeVO);
	}

	@Override
	public Boolean updateInterests(KnowledgeVO knowledgeVO) {
		Boolean result = false;
		
        try {
            if (knowledgeDAO.insertInterests(knowledgeVO) > 0) {
                result = true;
            }
        } catch (Exception e) {
        	knowledgeDAO.deleteInterests(knowledgeVO);
        }

        egovLogService.insert(result ? LogType.INSERT_KNOWLG_INTEREST:LogType.DELETE_KNOWLG_INTEREST, LogSubjectType.KNOWLEDGE, knowledgeVO);
				
		return result;
	}

	@Override
	public KnowledgeVO selectInterests(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectInterests(knowledgeVO);
	}

	@Override
	public List<KnowledgeVO> selectInterestsList(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectInterestsList(knowledgeVO);
	}
	
	@Override
	public int insertKnowledgeMap(KnowledgeMapVO knowledgeMapVO) {
		int result = 0;
		egovLogService.insert(LogType.INSERT, LogSubjectType.KNOWLGMAP, knowledgeMapVO);
		try {
			result = knowledgeDAO.insertKnowledgeMap(knowledgeMapVO);	
		} catch (Exception e) {
			result = -1;
		}		
		return result;
	}

	@Override
	public int updateKnowledgeMap(KnowledgeMapVO knowledgeMapVO) {
		egovLogService.insert(LogType.UPDATE, LogSubjectType.KNOWLGMAP, knowledgeMapVO);
		return knowledgeDAO.updateKnowledgeMap(knowledgeMapVO);
	}

	@Override
	public int deleteKnowledgeMap(KnowledgeMapVO knowledgeMapVO) {
		egovLogService.insert(LogType.DELETE, LogSubjectType.KNOWLGMAP, knowledgeMapVO);
		return knowledgeDAO.deleteKnowledgeMap(knowledgeMapVO);
	}

	@Override
	public List<String> selectKnowledgeTitle() {
		return knowledgeDAO.selectKnowledgeTitle();
	}

	@Override
	public int updateKnowledgeLink(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.updateKnowledgeLink(knowledgeVO);
	}

	@Override
	public List<LogVO> selectKnowledgeMapLogList() {
		List<LogVO> logList = knowledgeDAO.selectKnowledgeMapLogList();
		for(int i=0; i < logList.size(); i++) {
			String cont = logList.get(i).getCont();
			int start = cont.indexOf(",") + 1;
			int end = cont.indexOf(",", start);
			logList.get(i).setCont(cont.substring(start, end));
		}
		return logList;
	}

	@Override
	public int deleteBookmark(KnowledgeVO KnowledgeVO) {
		return knowledgeDAO.deleteBookmark(KnowledgeVO);
	}

	@Override
	public ListWithPageNavigation<KnowledgeVO> selectModificationRequestList(KnowledgeVO knowledgeVO) {
		ListWithPageNavigation<KnowledgeVO> result = new ListWithPageNavigation<>();
		PageNavigation pageNavigation = new PageNavigation(selectModificationRequestListCount(knowledgeVO), knowledgeVO.getPage(), null, null);
		knowledgeVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
		knowledgeVO.setItemOffset(pageNavigation.getItemCountPerPage() * (knowledgeVO.getPage() - 1));
		result.setList(knowledgeDAO.selectModificationRequestList(knowledgeVO));
		result.setPageNavigation(pageNavigation);
		return result;
	}

	@Override
	public int selectModificationRequestListCount(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectModificationRequestListCount(knowledgeVO);
	}

	@Override
	public KnowledgeVO selectModificationRequestDetail(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectModificationRequestDetail(knowledgeVO);
	}

	@Override
	public List<KnowledgeContentsVO> selectModificationRequestContentList(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectModificationRequestContentList(knowledgeVO);
	}

	@Override
	public ListWithPageNavigation<KnowledgeVO> selectSucceedList(KnowledgeVO knowledgeVO) {
		ListWithPageNavigation<KnowledgeVO> result = new ListWithPageNavigation<>();
		PageNavigation pageNavigation = new PageNavigation(selectSucceedListCount(knowledgeVO), knowledgeVO.getPage(), null, null);
		knowledgeVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
		knowledgeVO.setItemOffset(pageNavigation.getItemCountPerPage() * (knowledgeVO.getPage() - 1));
		result.setList(knowledgeDAO.selectSucceedList(knowledgeVO));
		result.setPageNavigation(pageNavigation);
		return result;
	}

	@Override
	public int selectSucceedListCount(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.selectSucceedListCount(knowledgeVO);
	}

	@Override
	public int updateOwner(KnowledgeVO knowledgeVO) {
		return knowledgeDAO.updateOwner(knowledgeVO);
	}
}
