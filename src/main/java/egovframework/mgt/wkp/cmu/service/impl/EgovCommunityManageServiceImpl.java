package egovframework.mgt.wkp.cmu.service.impl;

import egovframework.com.wkp.cmu.service.CommunityVO;
import egovframework.mgt.wkp.cmu.service.CommunityBannerVO;
import egovframework.mgt.wkp.cmu.service.EgovCommunityManageService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
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
 *  2014.12.08	이기하			암호화방식 변경(EgovFileScrty.encryptPassword)
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 * @since 2009.03.06
 */
@Service("communityManageService")
public class EgovCommunityManageServiceImpl extends EgovAbstractServiceImpl implements EgovCommunityManageService {

    @Resource(name = "communityManageDAO")
    private CommunityManageDAO communityManageDAO;

    @Override
    public void updateCommunityAprv(Long cmmntyNo, String aprv, String comment, String approverId) {
        communityManageDAO.updateCommunityAprv(cmmntyNo, aprv, comment, approverId);
    }

    @Override
    public List<CommunityBannerVO> findBanner(String useYn, String searchValue, int limit, int startIndex) {
        return communityManageDAO.findBanner(useYn, searchValue, limit, startIndex);
    }

    @Override
    public int findBannerTotalCount(String useYn, String searchValue) {
        return communityManageDAO.findBannerTotalCount(useYn, searchValue);
    }

    @Override
    public CommunityBannerVO getBanner(Long bannerNo) {
        return communityManageDAO.getBanner(bannerNo);
    }

    @Override
    public void insertBanner(CommunityBannerVO vo) {
        communityManageDAO.insertBanner(vo);
    }

    @Override
    public void updateBanner(CommunityBannerVO vo) {
        communityManageDAO.updateBanner(vo);
    }

    @Override
    public void deleteBanner(CommunityBannerVO vo) {
        communityManageDAO.deleteBanner(vo);
    }

    @Override
    public List<CommunityVO> findCommunity(String aprvYn, String searchType, String searchValue, int limit, int startIndex) {
        return communityManageDAO.findCommunity(aprvYn, searchType, searchValue, limit, startIndex);
    }

    @Override
    public int findCommunityTotalCount(String aprvYn, String searchType, String searchValue) {
        return communityManageDAO.findCommunityTotalCount(aprvYn, searchType, searchValue);
    }
}
