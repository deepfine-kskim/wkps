package egovframework.com.wkp.cmm.service;

import egovframework.com.wkp.usr.service.UserVO;

import java.util.List;

public interface EgovCommonService {
	
	public List<TargetVO> selectTargetList(TargetVO targetVO);

	public List<TargetVO> selectGroupListForDetail(TargetVO targetVO);
	
	public long insertTarget(TargetVO targetVO);
	
	public List<TargetVO> selectDisplayTargetList(Long targetNo);
	
	public List<ExcellenceUserVO> selectExcellenceUserList(ExcellenceUserVO excellenceUserVO);

	public int insertExcellenceUser(ExcellenceUserVO excellenceUserVO);
	
	public int deleteExcellenceUser(ExcellenceUserVO excellenceUserVO);
	
	public List<ExcellenceOrgVO> selectExcellenceOrgList(ExcellenceOrgVO excellenceOrgVO);
	
	public int insertExcellenceOrg(ExcellenceOrgVO excellenceOrgVO);
	
	public int deleteExcellenceOrg(ExcellenceOrgVO excellenceOrgVO);
	
	public List<RecommendVO> selectRecommendList();

	public int insertRecommend(RecommendVO recommendVO);

	public int deleteRecommend(RecommendVO recommendVO);
	
	public List<PersonalizeVO> selectPersonalizeList(PersonalizeVO personalizeVO);

	public int insertPersonalize(PersonalizeVO personalizeVO);

	public int deletePersonalize(PersonalizeVO personalizeVO);
	
	public List<GroupVO> selectGroupList(GroupVO groupVO);

	public List<GroupVO> selectGroupDetail(GroupVO groupVO);
	
	public String selectGroupName(long groupNo);
	
	public long insertGroup(GroupVO groupVO);
	
	public int insertGroupCheck(GroupVO groupVO);
	
	public int insertGroupDetail(GroupVO groupVO);
	
	public int deleteGroup(GroupVO groupVO);
	
	public UserVO selectMileageScore(UserVO userVO);
	
	public int updateMyBG(UserVO userVO);

	public int deleteMyBG(UserVO userVO);
	
	public int deleteGroupDetail(GroupVO groupVO);
	
	public int selectSortOrder(GroupVO groupVO);
	
    public List<ExcellenceUserVO> selectTopMileageUserList();
    
    public List<ExcellenceOrgVO> selectTopMileageOrgList();
    
    public List<RecommendVO> selectTopRecommendKnowledgeList(RecommendVO recommendVO);
    
    public List<PersonalizeVO> selectTopPersonalizeKnowledgeList(PersonalizeVO personalizeVO);
	
}
