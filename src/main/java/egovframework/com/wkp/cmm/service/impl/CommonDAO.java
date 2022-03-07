package egovframework.com.wkp.cmm.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.cmm.service.ExcellenceOrgVO;
import egovframework.com.wkp.cmm.service.ExcellenceUserVO;
import egovframework.com.wkp.cmm.service.GroupVO;
import egovframework.com.wkp.cmm.service.PersonalizeVO;
import egovframework.com.wkp.cmm.service.RecommendVO;
import egovframework.com.wkp.cmm.service.TargetVO;
import egovframework.com.wkp.usr.service.UserVO;

@Repository("commonDAO")
public class CommonDAO extends EgovComAbstractDAO {

	public List<TargetVO> selectTargetList(TargetVO targetVO) {
		return selectList("CommonDAO.selectTargetList", targetVO);
	}
	
	public long insertTarget(TargetVO targetVO) {
		insert("CommonDAO.insertTarget", targetVO);
		if(targetVO.getOrgList() != null) {
			for(int i=0; i < targetVO.getOrgList().size(); i++){
				targetVO.setTargetTypeCd("ORG");
				targetVO.setSortOrdr(i);
				targetVO.setTargetCode(targetVO.getOrgList().get(i));
				insert("CommonDAO.insertTargetDetail", targetVO);
			}	
		}
		
		if(targetVO.getUserList() != null) {
			for(int i=0; i < targetVO.getUserList().size(); i++){
				targetVO.setTargetTypeCd("USER");
				targetVO.setSortOrdr(i);
				targetVO.setTargetCode(targetVO.getUserList().get(i));
				insert("CommonDAO.insertTargetDetail", targetVO);
			}
		}

		if(targetVO.getGroupList() != null) {
			for(int i=0; i < targetVO.getGroupList().size(); i++){
				targetVO.setTargetTypeCd("GROUP");
				targetVO.setSortOrdr(i);
				targetVO.setTargetCode(targetVO.getGroupList().get(i));
				insert("CommonDAO.insertTargetDetail", targetVO);
			}	
		}
		
		return targetVO.getTargetNo();
	}
	
	public List<TargetVO> selectDisplayTargetList(Long targetNo) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("targetNo", targetNo);
		return selectList("CommonDAO.selectDisplayTargetList", param);
	}

	/**
	 * 우수 사용자 목록 조회
	 * @param excellenceUserVO VO
	 * @return 우수 사용자 목록
	 */
	public List<ExcellenceUserVO> selectExcellenceUserList(ExcellenceUserVO excellenceUserVO) {
		return selectList("CommonDAO.selectExcellenceUserList", excellenceUserVO);
	}

	/**
	 * 우수 사용자 등록
	 * @param excellenceUserVO VO
	 * @return 등록 건수
	 */
	public int insertExcellenceUser(ExcellenceUserVO excellenceUserVO) {
		return insert("CommonDAO.insertExcellenceUser", excellenceUserVO);
	}

	/**
	 * 우수 사용자 삭제
	 * @param excellenceUserVO VO
	 * @return 삭제 건수
	 */
	public int deleteExcellenceUser(ExcellenceUserVO excellenceUserVO) {
		return delete("CommonDAO.deleteExcellenceUser", excellenceUserVO);
	}

	/**
	 * 우수 부서 목록 조회
	 * @param excellenceOrgVO VO
	 * @return 우수 부서 목록
	 */
	public List<ExcellenceOrgVO> selectExcellenceOrgList(ExcellenceOrgVO excellenceOrgVO) {
		return selectList("CommonDAO.selectExcellenceOrgList", excellenceOrgVO);
	}

	/**
	 * 우수 부서 등록
	 * @param excellenceOrgVO VO
	 * @return 등록 건수
	 */
	public int insertExcellenceOrg(ExcellenceOrgVO excellenceOrgVO) {
		return insert("CommonDAO.insertExcellenceOrg", excellenceOrgVO);
	}

	/**
	 * 우수 부서 삭제
	 * @param excellenceOrgVO VO
	 * @return 삭제 건수
	 */
	public int deleteExcellenceOrg(ExcellenceOrgVO excellenceOrgVO) {
		return delete("CommonDAO.deleteExcellenceOrg", excellenceOrgVO);
	}

	public List<RecommendVO> selectRecommendList(RecommendVO recommendVO) {
		return selectList("CommonDAO.selectRecommendList", recommendVO);
	}

	public int insertRecommend(RecommendVO recommendVO) {
		return insert("CommonDAO.insertRecommend", recommendVO);
	}
	
	public int deleteRecommend(RecommendVO recommendVO) {
		return delete("CommonDAO.deleteRecommend", recommendVO);
	}
	
	public List<PersonalizeVO> selectPersonalizeList(PersonalizeVO personalizeVO) {
		return selectList("CommonDAO.selectPersonalizeList", personalizeVO);
	}

	public int insertPersonalize(PersonalizeVO personalizeVO) {
		return insert("CommonDAO.insertPersonalize", personalizeVO);
	}

	public int deletePersonalize(PersonalizeVO personalizeVO) {
		return delete("CommonDAO.deletePersonalize", personalizeVO);
	}
	
	public List<GroupVO> selectGroupList(GroupVO groupVO) {
		return selectList("CommonDAO.selectGroupList", groupVO);
	}

	public List<GroupVO> selectGroupDetail(GroupVO groupVO) {
		return selectList("CommonDAO.selectGroupDetail", groupVO);
	}
	
	public String selectGroupName(long groupNo) {
		return selectOne("CommonDAO.selectGroupName", groupNo);
	}
	
	public long insertGroup(GroupVO groupVO) {
		insert("CommonDAO.insertGroup", groupVO);
		return groupVO.getGroupNo();
	}
	
	public int insertGroupCheck(GroupVO groupVO) {
		return selectOne("CommonDAO.insertGroupCheck", groupVO);
	}

	public int insertGroupDetail(GroupVO groupVO) {
		int result = 0;
		if(groupVO.getOrgList() != null) {
			int sortOrder = groupVO.getSortOrdr();
			if(sortOrder > 0) {
				for(int i=0; i < groupVO.getOrgList().size(); i++){
					groupVO.setTargetTypeCd("ORG");
					groupVO.setSortOrdr(sortOrder + i);
					groupVO.setTargetCode(groupVO.getOrgList().get(i));
					result += insert("CommonDAO.insertGroupDetail", groupVO);
				}
			} else {
				for(int i=0; i < groupVO.getOrgList().size(); i++){
					groupVO.setTargetTypeCd("ORG");
					groupVO.setSortOrdr(i);
					groupVO.setTargetCode(groupVO.getOrgList().get(i));
					result += insert("CommonDAO.insertGroupDetail", groupVO);
				}
			}
		}
		
		if(groupVO.getUserList() != null) {
			int sortOrder = groupVO.getSortOrdr();
			if(sortOrder > 0) {
				for(int i=0; i < groupVO.getUserList().size(); i++){
					groupVO.setTargetTypeCd("USER");
					groupVO.setSortOrdr(sortOrder + i);
					groupVO.setTargetCode(groupVO.getUserList().get(i));
					result += insert("CommonDAO.insertGroupDetail", groupVO);
				}
			} else {
				for(int i=0; i < groupVO.getUserList().size(); i++){
					groupVO.setTargetTypeCd("USER");
					groupVO.setSortOrdr(i);
					groupVO.setTargetCode(groupVO.getUserList().get(i));
					result += insert("CommonDAO.insertGroupDetail", groupVO);
				}
			}
		}
		return result;
	}
	
	public int deleteGroup(GroupVO groupVO) {
		return delete("CommonDAO.deleteGroup", groupVO);
	}
	
	public UserVO selectMileageScore(UserVO userVO) {
		return selectOne("CommonDAO.selectMileageScore", userVO);
	}
	
	public int updateMyBG(UserVO userVO) {
		return update("CommonDAO.updateMyBG", userVO);
	}
	
	public int deleteMyBG(UserVO userVO) {
		return update("CommonDAO.deleteMyBG", userVO);
	}
	
	public int deleteGroupDetail(GroupVO groupVO)  {
		return delete("CommonDAO.deleteGroupDetail", groupVO);
	}
	
	public int selectSortOrder(GroupVO groupVO) {
		int result = 0;
		if(groupVO.getOrgList() != null) {
			for(int i=0; i < groupVO.getOrgList().size(); i++){
				groupVO.setTargetTypeCd("ORG");
				result = selectOne("CommonDAO.selectSortOrder", groupVO);
			}	
		}
		
		if(groupVO.getUserList() != null) {
			for(int i=0; i < groupVO.getUserList().size(); i++){
				groupVO.setTargetTypeCd("USER");
				result = selectOne("CommonDAO.selectSortOrder", groupVO);
			}
		}
		return result;
	}
	
	public List<ExcellenceUserVO> selectTopMileageUserList() {
		return selectList("CommonDAO.selectTopMileageUserList");
	}
		
	public List<ExcellenceOrgVO> selectTopMileageOrgList() {
		return selectList("CommonDAO.selectTopMileageOrgList");
	}
	
	public List<RecommendVO> selectTopRecommendKnowledgeList(RecommendVO recommendVO) {
		return selectList("CommonDAO.selectTopRecommendKnowledgeList", recommendVO);
	}
	
	public List<PersonalizeVO> selectTopPersonalizeKnowledgeList(PersonalizeVO personalizeVO) {
		return selectList("CommonDAO.selectTopPersonalizeKnowledgeList", personalizeVO);
	}

}
