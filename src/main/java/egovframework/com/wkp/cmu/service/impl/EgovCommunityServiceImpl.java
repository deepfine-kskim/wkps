package egovframework.com.wkp.cmu.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ibm.icu.util.Calendar;

import egovframework.com.wkp.cal.service.CalendarVO;
import egovframework.com.wkp.cal.service.impl.CalendarDAO;
import egovframework.com.wkp.cmu.service.CommunityCommentVO;
import egovframework.com.wkp.cmu.service.CommunityEventVO;
import egovframework.com.wkp.cmu.service.CommunityFreeboardVO;
import egovframework.com.wkp.cmu.service.CommunityMemberVO;
import egovframework.com.wkp.cmu.service.CommunityNoticeVO;
import egovframework.com.wkp.cmu.service.CommunityRoleTypes;
import egovframework.com.wkp.cmu.service.CommunityVO;
import egovframework.com.wkp.cmu.service.EgovCommunityService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
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
 *  2014.12.08	이기하			암호화방식 변경(EgovFileScrty.encryptPassword)
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
@Service("communityService")
public class EgovCommunityServiceImpl extends EgovAbstractServiceImpl implements EgovCommunityService {

    @Resource(name="communityDAO")
    private CommunityDAO communityDAO;


    @Resource(name="calendarDAO")
    private CalendarDAO calendarDAO;
    
	
	public List<CommunityVO> selectMyCommunity(String userSid){
		List<CommunityVO> list = communityDAO.loadMyCommunity(userSid);
		
		for(CommunityVO vo : list) {
			vo.setListFree(communityDAO.findCommunityFreeboard(vo.getCmmntyNo(), null, null, 3, 0));
		}
		
		return list;
	}
	@Override
	public List<CommunityVO> selectNewCommunity() {
		return communityDAO.selectNewCommunity();
	}

	@Override
	public List<CommunityVO> selectBestCommunity() {
		return communityDAO.selectBestCommunity();
	}
	
	@Override
	public List<CommunityVO> selectTotalCommunity() {
		return communityDAO.selectTotalCommunity();
	}

	@Override
	public List<HashMap<String, Object>> selectCommunityBanner() {
		return null;
	}

	@Override
	public List<CommunityVO> findCommunity(String searchType, String searchValue, int limit, int startIndex)
			 {
		return communityDAO.findCommunity(searchType,searchValue, limit, startIndex);
	}

	@Override
	public int findCommunityTotalCount(String searchType, String searchValue) {
		return communityDAO.findCommunityTotalCount(searchType, searchValue);
	}

	@Override
	public void registReqCommunity(CommunityVO vo,CommunityMemberVO owner) {
		communityDAO.insertCommunity(vo);
		owner.setCmmntyRoleCd(CommunityRoleTypes.owner.getCode());
		owner.setCmmntyNo(vo.getCmmntyNo());
		owner.setAprvYn("Y");
		owner.setAprvDtm(Calendar.getInstance().getTime());
		communityDAO.insertCommunityMember(owner);
	}

	@Override
	public List<CalendarVO> selectCommunityToday(Long cmmntyNo, int limit, int startIndex) {
		return calendarDAO.findCalendar(cmmntyNo, limit, startIndex);
	}

	@Override
	public int selectCommunityTodayTotalCount(Long cmmntyNo) {
		return calendarDAO.findCalendarTotalCount(cmmntyNo);
	}

	@Override
	public CommunityVO getCommunity(Long cmmntyNo) {
		CommunityVO community = communityDAO.loadCommunity(cmmntyNo);
		
		List<CommunityMemberVO> owner = communityDAO.loadCommunityMemberByRole(cmmntyNo, CommunityRoleTypes.owner.getCode());
		community.setOwner(owner.get(0));
		community.setMemCount(communityDAO.findCommunityMemberTotalCount(cmmntyNo, null, null, "N", null));
		community.setNoticeCount(communityDAO.findCommunityNoticeTotalCount(cmmntyNo, null, null));
		community.setFreeCount(communityDAO.findCommunityFreeboardTotalCount(cmmntyNo, null, null));
		community.setKnowledgeCount(communityDAO.findCommunityKnowledgeTotalCount(cmmntyNo));
		return community;
	}

	@Override
	public boolean joinCheckNickname(Long cmmntyNo, String cmmntyNicknm) {
		return communityDAO.loadCommunityMemberByNickname(cmmntyNo, cmmntyNicknm) == null;
	}

	@Override
	public void joinReqMember(CommunityMemberVO vo) {

		if(vo.getAprvYn().equals("N")) {
			//이벤트 등록
	        List<CommunityMemberVO> owner = communityDAO.loadCommunityMemberByRole(vo.getCmmntyNo(), CommunityRoleTypes.owner.getCode());
	        for(CommunityMemberVO m : owner) {
	        	insertCommunityEvent(m.getUserSid(), CommunityEventVO.EVT_TYPE_COMMNTY_JOIN_REQUEST, m.getCmmntyNo(), -1L, -1L);
	        }
		}
        
		communityDAO.insertCommunityMember(vo);
	}
	@Override
	public void deleteMember(Long mberNo){
		communityDAO.deleteCommunityMember(mberNo);
	}
	@Override
	public List<CommunityNoticeVO> findCommunityNotice(Long cmmntyNo,String searchType, String searchValue, int limit,
			int startIndex) {
		return communityDAO.findCommunityNotice(cmmntyNo, searchType,searchValue, limit, startIndex);
	}

	@Override
	public int findCommunityNoticeTotalCount(Long cmmntyNo,String searchType, String searchValue) {
		return communityDAO.findCommunityNoticeTotalCount(cmmntyNo, searchType, searchValue);
	}

	@Override
	public CommunityNoticeVO getCommunityNotice(Long noticeNo) {
		CommunityNoticeVO vo = communityDAO.loadCommunityNotice(noticeNo);
		vo.setAttach(communityDAO.getAtchFile(vo.getAtchFileNo()));
		
		return vo;
	}
	@Override
	public CommunityNoticeVO getCommunityNoticePrev(Long cmmntyNo,Long noticeNo){
		return communityDAO.loadCommunityNoticePrev(cmmntyNo,noticeNo);
	}
	@Override
	public CommunityNoticeVO getCommunityNoticeNext(Long cmmntyNo,Long noticeNo){
		return communityDAO.loadCommunityNoticeNext(cmmntyNo,noticeNo);
	}
	@Override
	public void insertCommunityNotice(CommunityNoticeVO vo) {
		communityDAO.insertCommunityNotice(vo);
	}

	@Override
	public void updateCommunityNotice(CommunityNoticeVO vo) {
		communityDAO.updateCommunityNotice(vo);
	}

	@Override
	public void deleteCommunityNotice(CommunityNoticeVO vo) {
		communityDAO.deleteCommunityNotice(vo);
	}
	
	@Override
	public void updateCommunityNoticeInq(CommunityNoticeVO vo) {
		communityDAO.updateCommunityNoticeInq(vo);
	}

	@Override
	public List<CommunityFreeboardVO> findCommunityFreeboard(Long cmmntyNo,String searchType, String searchValue, int limit,
			int startIndex) {
		return communityDAO.findCommunityFreeboard(cmmntyNo, searchType, searchValue, limit, startIndex);
	}

	@Override
	public int findCommunityFreeboardTotalCount(Long cmmntyNo,String searchType, String searchValue) {
		return communityDAO.findCommunityFreeboardTotalCount(cmmntyNo, searchType, searchValue);
	}

	@Override
	public CommunityFreeboardVO getCommunityFreeboard(Long pstgNo) {
		CommunityFreeboardVO vo =communityDAO.loadCommunityFreeboard(pstgNo);
		vo.setAttach(communityDAO.getAtchFile(vo.getAtchFileNo()));
		vo.setComment(communityDAO.selectCommunityComment(vo.getPstgNo()));
		return vo;
		
	}
	
	@Override
	public CommunityFreeboardVO getCommunityFreeboardPrev(Long cmmntyNo,Long pstgNo){
		return communityDAO.loadCommunityFreeboardPrev(cmmntyNo, pstgNo);
	}
	
	@Override
	public CommunityFreeboardVO getCommunityFreeboardNext(Long cmmntyNo,Long pstgNo){
		return communityDAO.loadCommunityFreeboardNext(cmmntyNo, pstgNo);
	}
	
	@Override
	public void insertCommunityFreeboard(CommunityFreeboardVO vo) {
		communityDAO.insertCommunityFreeboard(vo);
	}

	@Override
	public void updateCommunityFreeboard(CommunityFreeboardVO vo) {
		communityDAO.updateCommunityFreeboard(vo);
	}

	@Override
	public void deleteCommunityFreeboard(CommunityFreeboardVO vo) {
		communityDAO.deleteCommunityFreeboard(vo);
	}
	
	@Override
	public void updateCommunityFreeboardInq(CommunityFreeboardVO vo) {
		communityDAO.updateCommunityFreeboardInq(vo);
	}
	
	@Override
	public void insertCommunityComment(CommunityCommentVO vo){
		communityDAO.insertCommunityComment(vo);
	}
	
	@Override
	public void deleteCommunityComment(CommunityCommentVO vo){
		communityDAO.deleteCommunityComment(vo);
	}
	@Override
	public void updateCommunityComment(CommunityCommentVO vo){
		communityDAO.updateCommunityComment(vo);
	}
	@Override
	public CommunityCommentVO getCommunityComment(Long commentNo){
		return communityDAO.getCommunityComment(commentNo);
	}
	@Override
	public List<CommunityMemberVO> findCommunityMember(Long cmmntyNo,String searchType, String nickname, String joinReq, String staff,
			int limit, int startIndex) {
		return communityDAO.findCommunityMember(cmmntyNo, searchType,nickname, joinReq, staff, limit, startIndex);
	}

	@Override
	public int findCommunityMemberTotalCount(Long cmmntyNo,String searchType, String nickname, String joinReq, String staff)
			 {
		return communityDAO.findCommunityMemberTotalCount(cmmntyNo, searchType,nickname, joinReq, staff);
	}
	
	@Override
	public void setBoardCount(List<CommunityMemberVO> listMem){
		for(CommunityMemberVO mem : listMem) {
			mem.setFreeCount(communityDAO.getFreeBoardCount(mem.getCmmntyNo(), mem.getMberNo()));
			mem.setCommentCount(communityDAO.getCommentBoardCount(mem.getCmmntyNo(), mem.getMberNo()));
		}
	}
	
	@Override
	public CommunityMemberVO getCommunityMemberNickname(Long cmmntyNo,String nickname){
		return communityDAO.getCommunityMemberNickname(cmmntyNo, nickname);
	}
	@Override
	public CommunityMemberVO getCommunityMemberUser(Long cmmntyNo,String userSid){
		return communityDAO.getCommunityMemberUser(cmmntyNo, userSid);
	}
	@Override
	public CommunityMemberVO getCommunityMember(Long mberNo){
		return communityDAO.getCommunityMember(mberNo);
	}
	@Override
	public void entrust(Long cmmntyNo, Long targetMberNo) {
		//위임
		List<CommunityMemberVO> oldOwner = communityDAO.loadCommunityMemberByRole(cmmntyNo, CommunityRoleTypes.owner.getCode());
		for(CommunityMemberVO vo : oldOwner) {
			vo.setCmmntyRoleCd(null);
			communityDAO.updateCommunityMember(vo);
		}
		
		communityDAO.updateCommunityMemberRole(targetMberNo, CommunityRoleTypes.owner.getCode());
	}

	@Override
	public void updateCommunity(CommunityVO vo) {
		communityDAO.updateCommunity(vo);
	}

	@Override
	public void closeCommunity(Long cmmntyNo) {
		CommunityVO vo = communityDAO.loadCommunity(cmmntyNo);
		communityDAO.deleteCommunity(vo);
	}

	@Override
	public void memberConfirm(Long[] mberNo) {
		for(Long m : mberNo) {
			//이벤트 등록
			CommunityMemberVO mvo = getCommunityMember(m);
			if(mvo != null) {
				insertCommunityEvent(mvo.getUserSid(), CommunityEventVO.EVT_TYPE_COMMNTY_JOIN_CONFIRM, mvo.getCmmntyNo(), -1L, -1L);
			}
			communityDAO.updateCommunityMemberConfirm(m);
		}
	}
	@Override
	public void memberReject(Long [] mberNo){
		for(Long m : mberNo) {
			//이벤트 등록
			CommunityMemberVO mvo = getCommunityMember(m);
			if(mvo != null) {
				insertCommunityEvent(mvo.getUserSid(), CommunityEventVO.EVT_TYPE_COMMNTY_JOIN_REJECT, mvo.getCmmntyNo(), -1L, -1L);
			}
			communityDAO.updateCommunityMemberReject(m);
		}
	}
	@Override
	public void memberDelete(Long[] mberNo) {
		for(Long m : mberNo) {
			communityDAO.deleteCommunityMember(m);
		}
	}

	@Override
	public void memberAddStaff(Long[] mberNo) {
		for(Long m : mberNo) {
			communityDAO.updateCommunityMemberRole(m, CommunityRoleTypes.board.getCode());
		}
		
	}

	@Override
	public void memberDelStaff(Long[] mberNo) {
		for(Long m : mberNo) {
			communityDAO.updateCommunityMemberRole(m,null);
		}
	}

	@Override
	public void memberUpdateStaffRole(Long[] mberNo, String[] role) {
		for(int i = 0; i < mberNo.length; i++) {
			communityDAO.updateCommunityMemberRole(mberNo[i], role[i]);
		}
	}

	@Override
	public void insertCommunityEvent(String userId,String eventType,Long cmmntyNo,Long pstgNo,Long commentNo){
		CommunityEventVO vo = new CommunityEventVO();
		vo.setUserId(userId);
		vo.setEventType(eventType);
		vo.setCommentNo(commentNo);
		vo.setCmmntyNo(cmmntyNo);
		vo.setPstgNo(pstgNo);
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.HOUR, 48);
		vo.setExpireDtm(cal.getTime());
		communityDAO.insertCommunityEvent(vo);
	}
	
	@Override
    public void clearCommunityEvent(Long eventNo){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.HOUR, -1);
		communityDAO.clearCommunityEvent(eventNo, cal.getTime());
    }
    
    public List<CommunityEventVO> selectCommunityEvent(String userId){
    	return communityDAO.selectCommunityEvent(userId, Calendar.getInstance().getTime());
    }
	
	@Override
	public int selectCommunityCount(String userId) {
		return communityDAO.selectCommunityCount(userId);
	}
	
	@Override
    public List<CommunityEventVO> selectCommunityApply(String userId, Long cmmntyNo){
    	return communityDAO.selectCommunityApply(userId, cmmntyNo, Calendar.getInstance().getTime());
    }

}