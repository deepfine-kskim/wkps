package egovframework.com.wkp.usr.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.usr.service.OrgVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("orgDAO")
public class OrgDAO extends EgovComAbstractDAO {

	public List<OrgVO> selectOrgList(OrgVO orgVO) {
		return selectList("OrgDAO.selectOrgList", orgVO);
	}

	public List<OrgVO> selectTopOrgList() {
		return selectList("OrgDAO.selectTopOrgList");
	}

	public OrgVO selectOrgDetail(OrgVO orgVO) {
		return selectOne("OrgDAO.selectOrgDetail", orgVO);
	}
	
	public OrgVO selectParentOrg(OrgVO orgVO) {
		return selectOne("OrgDAO.selectParentOrg", orgVO);
	}

	public int insertOrg(OrgVO orgVO) {
		return insert("OrgDAO.insertOrg", orgVO);
	}

	public int updateOrg(OrgVO orgVO) {
		return update("OrgDAO.updateOrg", orgVO);
	}

	public int deleteOrg(OrgVO orgVO) {
		return delete("OrgDAO.deleteOrg", orgVO);
	}

	public OrgVO selectTopOrgByOuCode(String ouCode) {
		return selectOne("OrgDAO.selectTopOrgByOuCode", ouCode);
	}
	
}
