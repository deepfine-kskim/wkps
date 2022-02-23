package egovframework.mgt.wkp.cmu.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.cmu.service.CommunityVO;
import egovframework.mgt.wkp.cmu.service.CommunityBannerVO;
import org.springframework.stereotype.Repository;

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
@Repository("communityManageDAO")
public class CommunityManageDAO extends EgovComAbstractDAO {
    public List<CommunityVO> findCommunity(String aprvYn, String searchType, String searchValue, int limit, int startIndex) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("aprvYn", aprvYn);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        return selectList("CommunityManageDAO.findCommunity", param);
    }

    public int findCommunityTotalCount(String aprvYn, String searchType, String searchValue) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("aprvYn", aprvYn);
        param.put("search_type", searchType);
        param.put("search_value", searchValue);
        return selectOne("CommunityManageDAO.findCommunityTotalCount", param);
    }

    public void updateCommunityAprv(Long cmmntyNo, String aprvYn, String rejectComment, String approverId) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("cmmntyNo", cmmntyNo);
        param.put("aprvYn", aprvYn);
        param.put("rejectComment", rejectComment);
        param.put("approverId", approverId);
        update("CommunityManageDAO.updateCommunityAprv", param);
    }

    public List<CommunityBannerVO> findBanner(String useYn, String searchValue, int limit, int startIndex) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("useYn", useYn);
        param.put("search_value", searchValue);
        param.put("limit", limit);
        param.put("startIndex", startIndex);
        return selectList("CommunityManageDAO.findBanner", param);
    }

    public int findBannerTotalCount(String useYn, String searchValue) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("useYn", useYn);
        param.put("search_value", searchValue);
        return selectOne("CommunityManageDAO.findBannerTotalCount", param);
    }

    public CommunityBannerVO getBanner(Long bannerNo) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("bannerNo", bannerNo);
        return selectOne("CommunityManageDAO.getBanner", param);
    }

    public void insertBanner(CommunityBannerVO vo) {
        insert("CommunityManageDAO.insertBanner", vo);
    }

    public void updateBanner(CommunityBannerVO vo) {
        update("CommunityManageDAO.updateBanner", vo);
    }

    public void deleteBanner(CommunityBannerVO vo) {
        update("CommunityManageDAO.deleteBanner", vo);
    }
}
