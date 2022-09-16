package egovframework.com.wkp.cmu.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.cmu.service.*;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 * @since 2009.03.06
 */
@Repository("communityDAO")
public class CommunityDAO extends EgovComAbstractDAO {


    public CommunityVO loadCommunity(Long cmmntyNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        return selectOne("CommunityDAO.loadCommunity", param);
    }

    public List<CommunityVO> loadMyCommunity(String userSid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("userSid", userSid);
        return selectList("CommunityDAO.loadMyCommunity", param);
    }

    public List<CommunityVO> selectNewCommunity() {

        return selectList("CommunityDAO.selectNewCommunity");
    }

    public List<CommunityVO> selectBestCommunity() {

        return selectList("CommunityDAO.selectBestCommunity");
    }
    
    public List<CommunityVO> selectTotalCommunity() {
        return selectList("CommunityDAO.selectTotalCommunity");
    }

    public List<CommunityVO> findCommunity(String searchType, String searchValue, int limit, int startIndex) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        return selectList("CommunityDAO.findCommunity", param);
    }

    public int findCommunityTotalCount(String searchType, String searchValue) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        return selectOne("CommunityDAO.findCommunityTotalCount", param);
    }

    public void insertCommunity(CommunityVO vo) {
        insert("CommunityDAO.insertCommunity", vo);
    }

    public void updateCommunity(CommunityVO vo) {
        update("CommunityDAO.updateCommunity", vo);
    }

    public void deleteCommunity(CommunityVO vo) {
        update("CommunityDAO.deleteCommunity", vo);
    }


    public CommunityNoticeVO loadCommunityNotice(Long noticeNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("noticeNo", noticeNo);
        return selectOne("CommunityDAO.loadCommunityNotice", param);
    }

    public CommunityNoticeVO loadCommunityNoticePrev(Long cmmntyNo, Long noticeNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("noticeNo", noticeNo);
        return selectOne("CommunityDAO.loadCommunityNoticePrev", param);
    }

    public CommunityNoticeVO loadCommunityNoticeNext(Long cmmntyNo, Long noticeNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("noticeNo", noticeNo);

        return selectOne("CommunityDAO.loadCommunityNoticeNext", param);
    }

    public List<CommunityNoticeVO> findCommunityNotice(Long cmmntyNo, String searchType, String searchValue, int limit, int startIndex) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        return selectList("CommunityDAO.findCommunityNotice", param);
    }

    public List<CommunityNoticeVO> findCommunityNotice(Long cmmntyNo, String searchType, String searchValue, int limit, int startIndex, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        param.put("sid", sid);
        return selectList("CommunityDAO.findCommunityNotice", param);
    }

    public int findCommunityNoticeTotalCount(Long cmmntyNo, String searchType, String searchValue) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        return selectOne("CommunityDAO.findCommunityNoticeTotalCount", param);
    }

    public int findCommunityNoticeTotalCount(Long cmmntyNo, String searchType, String searchValue, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("sid", sid);
        return selectOne("CommunityDAO.findCommunityNoticeTotalCount", param);
    }

    public void insertCommunityNotice(CommunityNoticeVO vo) {
        insert("CommunityDAO.insertCommunityNotice", vo);
    }

    public void updateCommunityNotice(CommunityNoticeVO vo) {
        update("CommunityDAO.updateCommunityNotice", vo);
    }

    public void deleteCommunityNotice(CommunityNoticeVO vo) {
        update("CommunityDAO.deleteCommunityNotice", vo);
    }
    
    public void updateCommunityNoticeInq(CommunityNoticeVO vo) {
        update("CommunityDAO.updateCommunityNoticeInq", vo);
    }

    public void insertCommunityComment(CommunityCommentVO vo) {
        insert("CommunityDAO.insertCommunityComment", vo);
    }
    public void insertCommunity2Comment(CommunityCommentVO vo) {
        insert("CommunityDAO.insertCommunity2Comment", vo);
    }

    public void deleteCommunityComment(CommunityCommentVO vo) {
        update("CommunityDAO.deleteCommunityComment", vo);
    }

    public void deleteCommunity2Comment(CommunityCommentVO vo) {
        update("CommunityDAO.deleteCommunity2Comment", vo);
    }
    
    public void updateCommunityComment(CommunityCommentVO vo) {
        update("CommunityDAO.updateCommunityComment", vo);
    }
    public void updateCommunity2Comment(CommunityCommentVO vo) {
        update("CommunityDAO.updateCommunity2Comment", vo);
    }

    public CommunityCommentVO getCommunityComment(Long commentNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("commentNo", commentNo);
        return selectOne("CommunityDAO.getCommunityComment", param);
    }

    public CommunityCommentVO getCommunity2Comment(Long commentNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("commentNo", commentNo);
        return selectOne("CommunityDAO.getCommunity2Comment", param);
    }

    public List<CommunityCommentVO> selectCommunityComment(Long pstgNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("pstgNo", pstgNo);
        return selectList("CommunityDAO.selectCommunityComment", param);
    }

    public List<CommunityCommentVO> selectCommunity2Comment(Long pstgNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("pstgNo", pstgNo);
        return selectList("CommunityDAO.selectCommunity2Comment", param);
    }

    public CommunityFreeboardVO loadCommunityFreeboard(Long pstgNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("pstgNo", pstgNo);
        return selectOne("CommunityDAO.loadCommunityFreeboard", param);
    }

    public CommunityFreeboardVO loadCommunity2Freeboard(Long pstgNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("pstgNo", pstgNo);
        return selectOne("CommunityDAO.loadCommunity2Freeboard", param);
    }

    public CommunityFreeboardVO loadCommunityFreeboardPrev(Long cmmntyNo, Long pstgNo, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("pstgNo", pstgNo);
        param.put("sid", sid);
        return selectOne("CommunityDAO.loadCommunityFreeboardPrev", param);
    }

    public CommunityFreeboardVO loadCommunityFreeboardNext(Long cmmntyNo, Long pstgNo, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("pstgNo", pstgNo);
        param.put("sid", sid);
        return selectOne("CommunityDAO.loadCommunityFreeboardNext", param);
    }

    public CommunityFreeboardVO loadCommunity2FreeboardPrev(Long cmmntyNo, Long pstgNo, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("pstgNo", pstgNo);
        param.put("sid", sid);
        return selectOne("CommunityDAO.loadCommunity2FreeboardPrev", param);
    }

    public CommunityFreeboardVO loadCommunity2FreeboardNext(Long cmmntyNo, Long pstgNo, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("pstgNo", pstgNo);
        param.put("sid", sid);
        return selectOne("CommunityDAO.loadCommunity2FreeboardNext", param);
    }

    public List<CommunityFreeboardVO> findCommunityDashBoard(Long cmmntyNo, String searchType, String searchValue, int limit, int startIndex) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        return selectList("CommunityDAO.findCommunityDashBoard", param);
    }

    public List<CommunityFreeboardVO> findCommunityFreeboard(Long cmmntyNo, String searchType, String searchValue, int limit, int startIndex) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        return selectList("CommunityDAO.findCommunityFreeboard", param);
    }

    public int findCommunityFreeboardTotalCount(Long cmmntyNo, String searchType, String searchValue) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        return selectOne("CommunityDAO.findCommunityFreeboardTotalCount", param);
    }

    public List<CommunityFreeboardVO> findCommunityFreeboard(Long cmmntyNo, String searchType, String searchValue, int limit, int startIndex, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        param.put("sid", sid);
        return selectList("CommunityDAO.findCommunityFreeboard", param);
    }

    public List<CommunityFreeboardVO> findCommunity2Freeboard(Long cmmntyNo, String searchType, String searchValue, int limit, int startIndex, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        param.put("sid", sid);
        return selectList("CommunityDAO.findCommunity2Freeboard", param);
    }

    public CommunityVO getCommunityNicknameByUserSid(Long cmmntyNo, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("sid", sid);
        return selectOne("CommunityDAO.getCommunityNicknameByUserSid", param);
    }

    public int findCommunityFreeboardTotalCount(Long cmmntyNo, String searchType, String searchValue, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("sid", sid);
        return selectOne("CommunityDAO.findCommunityFreeboardTotalCount", param);
    }

    public int findCommunity2FreeboardTotalCount(Long cmmntyNo, String searchType, String searchValue, String sid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("sid", sid);
        return selectOne("CommunityDAO.findCommunity2FreeboardTotalCount", param);
    }

    public int findCommunity2FreeboardTotalCount(Long cmmntyNo, String searchType, String searchValue) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        return selectOne("CommunityDAO.findCommunity2FreeboardTotalCount", param);
    }

    public void insertCommunityFreeboard(CommunityFreeboardVO vo) {
        insert("CommunityDAO.insertCommunityFreeboard", vo);
    }

    public void insertCommunity2Freeboard(CommunityFreeboardVO vo) {
        insert("CommunityDAO.insertCommunity2Freeboard", vo);
    }

    public void updateCommunityFreeboard(CommunityFreeboardVO vo) {
        update("CommunityDAO.updateCommunityFreeboard", vo);
    }

    public void updateCommunity2Freeboard(CommunityFreeboardVO vo) {
        update("CommunityDAO.updateCommunity2Freeboard", vo);
    }

    public void deleteCommunityFreeboard(CommunityFreeboardVO vo) {
        update("CommunityDAO.deleteCommunityFreeboard", vo);
    }

    public void deleteCommunity2Freeboard(CommunityFreeboardVO vo) {
        update("CommunityDAO.deleteCommunity2Freeboard", vo);
    }
    
    public void updateCommunityFreeboardInq(CommunityFreeboardVO vo) {
        update("CommunityDAO.updateCommunityFreeboardInq", vo);
    }

    public void updateCommunity2FreeboardInq(CommunityFreeboardVO vo) {
        update("CommunityDAO.updateCommunity2FreeboardInq", vo);
    }
    
    public int findCommunityKnowledgeTotalCount(Long cmmntyNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        return selectOne("CommunityDAO.findCommunityKnowledgeTotalCount", param);
    }

    public CommunityMemberVO loadCommunityMember(Long mberNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("mberNo", mberNo);
        return selectOne("CommunityDAO.loadCommunityMember", param);
    }

    public CommunityMemberVO loadCommunityMemberByNickname(Long cmmntyNo, String cmmntyNicknm) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("cmmntyNicknm", cmmntyNicknm);
        return selectOne("CommunityDAO.loadCommunityMemberByNickname", param);
    }

    public List<CommunityMemberVO> loadCommunityMemberByRole(Long cmmntyNo, String cmmntyRoleCd) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("cmmntyRoleCd", cmmntyRoleCd);
        return selectList("CommunityDAO.loadCommunityMemberByRole", param);
    }

    public List<CommunityMemberVO> findCommunityMember(Long cmmntyNo, String searchType, String nickname, String joinReq, String staff, int limit, int startIndex) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("nickname", nickname);
        param.put("joinReq", joinReq);
        param.put("staff", staff);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        return selectList("CommunityDAO.findCommunityMember", param);
    }

    public int findCommunityMemberTotalCount(Long cmmntyNo, String searchType, String nickname, String joinReq, String staff) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("search_type", searchType);
        param.put("nickname", nickname);
        param.put("joinReq", joinReq);
        param.put("staff", staff);
        return selectOne("CommunityDAO.findCommunityMemberTotalCount", param);
    }

    public int getFreeBoardCount(Long cmmntyNo, Long mberNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("mberNo", mberNo);

        return selectOne("CommunityDAO.getFreeBoardCount", param);
    }

    public int getCommentBoardCount(Long cmmntyNo, Long mberNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("mberNo", mberNo);

        return selectOne("CommunityDAO.getCommentBoardCount", param);
    }

    public CommunityMemberVO getCommunityMemberNickname(Long cmmntyNo, String nickname) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("nickname", nickname);
        return selectOne("CommunityDAO.getCommunityMemberNickname", param);
    }

    public CommunityMemberVO getCommunityMemberUser(Long cmmntyNo, String userSid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("userSid", userSid);
        return selectOne("CommunityDAO.getCommunityMemberUser", param);
    }
    public CommunityMemberVO getCommunityMember(Long mberNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("mberNo", mberNo);
        return selectOne("CommunityDAO.getCommunityMember", param);
    }
    public int getCommunityMemberExistUser(Long cmmntyNo, String userSid) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("userSid", userSid);
        return selectOne("CommunityDAO.getCommunityMemberExistUser", param);
    }
    
    public void insertCommunityMember(CommunityMemberVO vo) {
        insert("CommunityDAO.insertCommunityMember", vo);
    }

    public void updateCommunityMember(CommunityMemberVO vo) {
        update("CommunityDAO.updateCommunityMember", vo);
    }

    public void updateCommunityMemberNickName(CommunityMemberVO vo) {
        update("CommunityDAO.updateCommunityMemberNickName", vo);
    }

    public void deleteCommunityMember(CommunityMemberVO vo) {
        update("CommunityDAO.deleteCommunityMember", vo);
    }

    public void deleteCommunityMember(Long mberNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("mberNo", mberNo);
        update("CommunityDAO.deleteCommunityMemberByNo", param);
    }

    public void updateCommunityMemberConfirm(Long mberNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("mberNo", mberNo);
        update("CommunityDAO.updateCommunityMemberConfirm", param);
    }

    public void updateCommunityMemberReject(Long mberNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("mberNo", mberNo);
        update("CommunityDAO.updateCommunityMemberReject", param);
    }

    public void updateCommunityMemberRole(Long mberNo, String cmmntyRoleCd) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("mberNo", mberNo);
        param.put("cmmntyRoleCd", cmmntyRoleCd);
        update("CommunityDAO.updateCommunityMemberRole", param);
    }

    public List<AtchFileVO> getAtchFile(Long atchFileNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("atchFileNo", atchFileNo);

        return selectList("CommunityDAO.getAtchFile", param);
    }
    
    public void insertCommunityEvent(CommunityEventVO vo) {
        insert("CommunityDAO.insertCommunityEvent", vo);
    }
    
    public void clearCommunityEvent(Long eventNo,Date expireDtm ) {
    	HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("eventNo", eventNo);
        param.put("expireDtm", expireDtm);
        update("CommunityDAO.clearCommunityEvent", param);
    }
    
    public List<CommunityEventVO> selectCommunityEvent(String userId,Date nowDtm ) {
    	HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("userId", userId);
        param.put("nowDtm", nowDtm);
        return selectList("CommunityDAO.selectCommunityEvent", param);
    }
    
	public int selectCommunityCount(String userId) {
    	HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("userId", userId);
		return selectOne("CommunityDAO.selectCommunityCount");
	}
	
    public List<CommunityEventVO> selectCommunityApply(String userId,long cmmntyNo,Date nowDtm ) {
    	HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("userId", userId);
        param.put("cmmntyNo", cmmntyNo);
        param.put("nowDtm", nowDtm);
        return selectList("CommunityDAO.selectCommunityApply", param);
    }
}
