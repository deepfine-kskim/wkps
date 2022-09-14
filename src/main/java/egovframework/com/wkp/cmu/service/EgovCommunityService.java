package egovframework.com.wkp.cmu.service;

import egovframework.com.wkp.cal.service.CalendarVO;

import java.util.HashMap;
import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information(CommunityVO communityVO) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  2011.08.26  서준식          EsntlId를 이용한 로그인 추가
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
public interface EgovCommunityService {
	
	//메인
	
	public List<CommunityVO> selectMyCommunity(String userSid);
	public List<CommunityVO> selectNewCommunity();
	public List<CommunityVO> selectBestCommunity();
	public List<CommunityVO> selectTotalCommunity();	
	public List<HashMap<String,Object>> selectCommunityBanner();
	
	//검색
	public List<CommunityVO> findCommunity(String searchType,String searchValue,int limit,int startIndex);
	public int findCommunityTotalCount(String searchType,String searchValue);
	
	//커뮤니티 개설
	public void registReqCommunity(CommunityVO vo,CommunityMemberVO owner);
	
	//커뮤니티 상세
	public List<CalendarVO> selectCommunityToday(Long cmmntyNo,int limit,int startIndex);
	public int selectCommunityTodayTotalCount(Long cmmntyNo);
	public CommunityVO getCommunity(Long cmmntyNo);
	public CommunityVO getCommunity(Long cmmntyNo, String sid);
	public boolean joinCheckNickname(Long cmmntyNo,String nickname);
	public void joinReqMember(CommunityMemberVO vo);
	public void deleteMember(Long mberNo);
	
	//커뮤니티공지사항
	public List<CommunityNoticeVO> findCommunityNotice(Long cmmntyNo,String searchType,String searchValue,int limit,int startIndex);
	public List<CommunityNoticeVO> findCommunityNotice(Long cmmntyNo,String searchType,String searchValue,int limit,int startIndex, String sid);
	public int findCommunityNoticeTotalCount(Long cmmntyNo,String searchType,String searchValue, String sid);
	public int findCommunityNoticeTotalCount(Long cmmntyNo,String searchType,String searchValue);
	public CommunityNoticeVO getCommunityNotice(Long noticeNo);
	public CommunityNoticeVO getCommunityNoticePrev(Long cmmntyNo,Long noticeNo);
	public CommunityNoticeVO getCommunityNoticeNext(Long cmmntyNo,Long noticeNo);
	public void insertCommunityNotice(CommunityNoticeVO vo);
	public void updateCommunityNotice(CommunityNoticeVO vo);
	public void deleteCommunityNotice(CommunityNoticeVO vo);
	public void updateCommunityNoticeInq(CommunityNoticeVO vo);
	
	//커뮤니티자유게시판
	public List<CommunityFreeboardVO> findCommunityFreeboard(Long cmmntyNo,String searchType,String searchValue,int limit,int startIndex);
	public int findCommunityFreeboardTotalCount(Long cmmntyNo,String searchType,String searchValue);
	public List<CommunityFreeboardVO> findCommunityFreeboard(Long cmmntyNo,String searchType,String searchValue,int limit,int startIndex, String sid);
	public List<CommunityFreeboardVO> findCommunity2Freeboard(Long cmmntyNo,String searchType,String searchValue,int limit,int startIndex, String sid);
	public int findCommunityFreeboardTotalCount(Long cmmntyNo,String searchType,String searchValue, String sid);
	public int findCommunity2FreeboardTotalCount(Long cmmntyNo,String searchType,String searchValue, String sid);
	public CommunityFreeboardVO getCommunityFreeboard(Long pstgNo);
	public CommunityFreeboardVO getCommunity2Freeboard(Long pstgNo);
	public CommunityFreeboardVO getCommunityFreeboardPrev(Long cmmntyNo,Long pstgNo, String sid);
	public CommunityFreeboardVO getCommunityFreeboardNext(Long cmmntyNo,Long pstgNo, String sid);
	public CommunityFreeboardVO getCommunity2FreeboardPrev(Long cmmntyNo,Long pstgNo, String sid);
	public CommunityFreeboardVO getCommunity2FreeboardNext(Long cmmntyNo,Long pstgNo, String sid);
	public void insertCommunityFreeboard(CommunityFreeboardVO vo);
	public void insertCommunity2Freeboard(CommunityFreeboardVO vo);
	public void updateCommunityFreeboard(CommunityFreeboardVO vo);
	public void updateCommunity2Freeboard(CommunityFreeboardVO vo);
	public void deleteCommunityFreeboard(CommunityFreeboardVO vo);
	public void deleteCommunity2Freeboard(CommunityFreeboardVO vo);
	public void updateCommunityFreeboardInq(CommunityFreeboardVO vo);
	public void updateCommunity2FreeboardInq(CommunityFreeboardVO vo);

	public void insertCommunityComment(CommunityCommentVO vo);
	public void insertCommunity2Comment(CommunityCommentVO vo);
	public void deleteCommunityComment(CommunityCommentVO vo);
	public void deleteCommunity2Comment(CommunityCommentVO vo);
	public void updateCommunityComment(CommunityCommentVO vo);
	public void updateCommunity2Comment(CommunityCommentVO vo);
	public CommunityCommentVO getCommunityComment(Long commentNo);
	public CommunityCommentVO getCommunity2Comment(Long commentNo);

	//회원목록
	public List<CommunityMemberVO> findCommunityMember(Long cmmntyNo,String searchType,String nickname,String joinReq,String staff,int limit,int startIndex);
	public int findCommunityMemberTotalCount(Long cmmntyNo,String searchType,String nickname,String joinReq,String staff);
	public void setBoardCount(List<CommunityMemberVO> mem);
	public CommunityMemberVO getCommunityMemberNickname(Long cmmntyNo,String nickname);
	public CommunityMemberVO getCommunityMemberUser(Long cmmntyNo,String userSid);
	public CommunityMemberVO getCommunityMember(Long mberNo);

	public int getCommunityMemberExistUser(Long cmmntyNo,String userSid);
	
	//관리
	//커뮤디니위임
	public void entrust(Long cmmntyNo,Long targetMberNo);
	public void updateCommunity(CommunityVO vo);
	public void closeCommunity(Long cmmntyNo);
	public void memberConfirm(Long [] mberNo);
	public void memberReject(Long [] mberNo);
	public void memberDelete(Long [] mberNo);
	public void memberAddStaff(Long [] mberNo);
	public void memberDelStaff(Long [] mberNo);
	public void memberUpdateStaffRole(Long [] mberNo,String [] role);
	
    public void insertCommunityEvent(String userId,String eventType,Long cmmntyNo,Long pstgNo,Long commentNo,Long pstgNo2,Long commentNo2);
    public void clearCommunityEvent(Long eventNo);
    public List<CommunityEventVO> selectCommunityEvent(String userId);
    
    public int selectCommunityCount(String userId);
    
    public List<CommunityEventVO> selectCommunityApply(String userId,Long cmmntyNo);
}
