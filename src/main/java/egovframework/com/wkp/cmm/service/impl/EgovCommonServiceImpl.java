package egovframework.com.wkp.cmm.service.impl;

import egovframework.com.wkp.cmm.service.*;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("commonService")
public class EgovCommonServiceImpl extends EgovAbstractServiceImpl implements EgovCommonService {

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;

	@Override
	public List<TargetVO> selectTargetList(TargetVO targetVO) {
		return commonDAO.selectTargetList(targetVO);
	}
	
    @Override
	public long insertTarget(TargetVO targetVO) {
		return commonDAO.insertTarget(targetVO);
	}
    
    @Override
    public List<TargetVO> selectDisplayTargetList(Long targetNo){
    	return commonDAO.selectDisplayTargetList(targetNo);
    }

	/**
	 * 우수 사용자 목록 조회
	 * @param excellenceUserVO VO
	 * @return 우수 사용자 목록
	 */
	@Override
	public List<ExcellenceUserVO> selectExcellenceUserList(ExcellenceUserVO excellenceUserVO) {
        return commonDAO.selectExcellenceUserList(excellenceUserVO);
	}

	/**
	 * 우수 사용자 등록
	 * @param excellenceUserVO VO
	 * @return 등록 건수
	 */
	@Override
	public int insertExcellenceUser(ExcellenceUserVO excellenceUserVO) {
		int result = 0;
		try {
			result = commonDAO.insertExcellenceUser(excellenceUserVO);
		} catch (Exception e) {
			result = -1;
		}
		return result;
	}

	/**
	 * 우수 사용자 삭제
	 * @param excellenceUserVO VO
	 * @return 삭제 건수
	 */
	@Override
	public int deleteExcellenceUser(ExcellenceUserVO excellenceUserVO) {
		return commonDAO.deleteExcellenceUser(excellenceUserVO);
	}

	/**
	 * 우수 부서 목록 조회
	 * @param excellenceOrgVO VO
	 * @return 우수 부서 목록
	 */
	@Override
	public List<ExcellenceOrgVO> selectExcellenceOrgList(ExcellenceOrgVO excellenceOrgVO) {
        return commonDAO.selectExcellenceOrgList(excellenceOrgVO);
	}

	/**
	 * 우수 부서 등록
	 * @param excellenceOrgVO VO
	 * @return 등록 건수
	 */
	@Override
	public int insertExcellenceOrg(ExcellenceOrgVO excellenceOrgVO) {
		int result = 0;
		try {
			result = commonDAO.insertExcellenceOrg(excellenceOrgVO);
		} catch (Exception e) {
			result = -1;
		}
		return result;
	}

	/**
	 * 우수 부서 삭제
	 * @param excellenceOrgVO VO
	 * @return 삭제 건수
	 */
	@Override
	public int deleteExcellenceOrg(ExcellenceOrgVO excellenceOrgVO) {
		return commonDAO.deleteExcellenceOrg(excellenceOrgVO);
	}

	@Override
	public List<RecommendVO> selectRecommendList() {
        return commonDAO.selectRecommendList();
	}
	
	@Override
	public int insertRecommend(RecommendVO recommendVO) {
		int result = 0;
		try{
			result = commonDAO.insertRecommend(recommendVO);
		} catch (Exception e) {
			result = -1;
		}
		return result;
	}
	
	@Override
	public int deleteRecommend(RecommendVO recommendVO) {
		return commonDAO.deleteRecommend(recommendVO);
	}
	
	@Override
	public List<PersonalizeVO> selectPersonalizeList(PersonalizeVO personalizeVO) {
		return commonDAO.selectPersonalizeList(personalizeVO);
	}

	@Override
	public int insertPersonalize(PersonalizeVO personalizeVO) {
		int result = 0;
		try{
			return commonDAO.insertPersonalize(personalizeVO);
		} catch (Exception e) {
			result = -1;
		}
		return result;
	}

	@Override
	public int deletePersonalize(PersonalizeVO personalizeVO) {
		return commonDAO.deletePersonalize(personalizeVO);
	}

	@Override
	public List<GroupVO> selectGroupList(GroupVO groupVO) {
		return commonDAO.selectGroupList(groupVO);
	}

	@Override
	public List<GroupVO> selectGroupDetail(GroupVO groupVO) {
		return commonDAO.selectGroupDetail(groupVO);
	}
	
	@Override
	public String selectGroupName(long groupNo) {
		return commonDAO.selectGroupName(groupNo);
	}
	
	@Override
	public long insertGroup(GroupVO groupVO) {
		return commonDAO.insertGroup(groupVO);
	}
	
	@Override
	public int insertGroupCheck(GroupVO groupVO) {
		return commonDAO.insertGroupCheck(groupVO);
	}

	@Override
	public int insertGroupDetail(GroupVO groupVO) {
		return commonDAO.insertGroupDetail(groupVO);
	}

	@Override
	public int deleteGroup(GroupVO groupVO) {
		return commonDAO.deleteGroup(groupVO);
	}

	@Override
	public UserVO selectMileageScore(UserVO userVO) {
		return commonDAO.selectMileageScore(userVO);
	}

	@Override
	public int updateMyBG(UserVO userVO) {
		return commonDAO.updateMyBG(userVO);
	}

	@Override
	public int deleteMyBG(UserVO userVO) {
		return commonDAO.deleteMyBG(userVO);
	}
	
	@Override
	public int deleteGroupDetail(GroupVO groupVO) {
		return commonDAO.deleteGroupDetail(groupVO);
	}
	
	@Override
	public int selectSortOrder(GroupVO groupVO) {
		return commonDAO.selectSortOrder(groupVO);
	}
	
	@Override
	public List<ExcellenceUserVO> selectTopMileageUserList() {
		return commonDAO.selectTopMileageUserList();
	}
	
	@Override
	public List<ExcellenceOrgVO> selectTopMileageOrgList() {
		return commonDAO.selectTopMileageOrgList();
	}

	@Override
	public List<RecommendVO> selectTopRecommendKnowledgeList(RecommendVO recommendVO) {
		return commonDAO.selectTopRecommendKnowledgeList(recommendVO);
	}

	@Override
	public List<PersonalizeVO> selectTopPersonalizeKnowledgeList(PersonalizeVO personalizeVO) {
		return commonDAO.selectTopPersonalizeKnowledgeList(personalizeVO);
	}

}