package egovframework.mgt.wkp.cmu.service;

import egovframework.com.wkp.cmu.service.CommunityVO;

import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
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
public interface EgovCommunityManageService {
    public List<CommunityVO> findCommunity(String aprvYn, String searchType, String searchValue, int limit, int startIndex);

    public int findCommunityTotalCount(String aprvYn, String searchType, String searchValue);

    public void updateCommunityAprv(Long cmmntyNo, String aprv, String comment, String approverId);

    public List<CommunityBannerVO> findBanner(String useYn, String searchValue, int limit, int startIndex);

    public int findBannerTotalCount(String useYn, String searchValue);

    public CommunityBannerVO getBanner(Long bannerNo);

    public void insertBanner(CommunityBannerVO vo);

    public void updateBanner(CommunityBannerVO vo);

    public void deleteBanner(CommunityBannerVO vo);
}
